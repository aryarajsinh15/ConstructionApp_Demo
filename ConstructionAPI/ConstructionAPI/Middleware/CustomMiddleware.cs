using ConstructionAPI.Common.EmailNotification;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Settings;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.Account;
using ConstructionAPI.Service.JWTAuthentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.Extensions.Options;
using Microsoft.Net.Http.Headers;
using Microsoft.VisualBasic;
using Newtonsoft.Json;
using System.Diagnostics;
using System.Net;
using static ConstructionAPI.Common.EmailNotification.EmailNotification;
using Constants = ConstructionAPI.Common.Helper.Constants;

namespace ConstructionAPI.Middleware
{
    public class CustomMiddleware
    {
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly RequestDelegate _next;
        private readonly SMTPSettings _smtpSettings;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly AppSettings _appSettings;
        private readonly IConfiguration _config;

        public CustomMiddleware(IJWTAuthenticationService jwtAuthenticationService, 
            RequestDelegate next, IOptions<SMTPSettings> smtpSettings, 
            IHttpContextAccessor httpContextAccessor, 
            IOptions<AppSettings> appSettings,
            IConfiguration config)
        {
            _jwtAuthenticationService = jwtAuthenticationService;
            _next = next;
            _smtpSettings = smtpSettings.Value;
            _httpContextAccessor = httpContextAccessor;
            _appSettings = appSettings.Value;
            _config = config;
        }

        public async Task Invoke(HttpContext context, IAccountService _accountService)
        {

            string headervalue = context.Request.Headers["Authorization"].ToString();
            if (!string.IsNullOrEmpty(headervalue))
            {
                string jwtToken = context.Request.Headers[HeaderNames.Authorization].ToString().Replace("Bearer ", "");
                if (!string.IsNullOrEmpty(jwtToken))
                {
                    TokenModel userTokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
                    var result = await _accountService.ValidateUserTokenData(userTokenModel.UserId.ToString(), jwtToken);
                    if (result == 1)
                    {
                        if (userTokenModel != null)
                        {
                            if (userTokenModel.TokenValidTo < DateTime.UtcNow.AddMinutes(1))
                            {
                                context.Response.ContentType = "application/json";
                                context.Response.Headers[HeaderNames.AccessControlAllowOrigin] = "*";
                                context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                                return;
                            }
                        }
                    }
                    else
                    {
                        context.Response.ContentType = "application/json";
                        context.Response.Headers[HeaderNames.AccessControlAllowOrigin] = "*";
                        context.Response.StatusCode = StatusCodes.Status403Forbidden;
                        return;
                    }

                }
            }
            using (MemoryStream requestBodyStream = new MemoryStream())
            {
                using (MemoryStream responseBodyStream = new MemoryStream())
                {
                    Stream originalRequestBody = context.Request.Body;
                    Stream originalResponseBody = context.Response.Body;
                    try
                    {

                        await context.Request.Body.CopyToAsync(requestBodyStream);
                        requestBodyStream.Seek(0, SeekOrigin.Begin);

                        string requestBodyText = new StreamReader(requestBodyStream).ReadToEnd();

                        requestBodyStream.Seek(0, SeekOrigin.Begin);
                        context.Request.Body = requestBodyStream;

                        string responseBody = "";

                        context.Response.Body = responseBodyStream;

                        Stopwatch watch = Stopwatch.StartNew();
                        await _next(context);
                        watch.Stop();

                        responseBodyStream.Seek(0, SeekOrigin.Begin);
                        responseBody = new StreamReader(responseBodyStream).ReadToEnd();


                        responseBodyStream.Seek(0, SeekOrigin.Begin);

                        await responseBodyStream.CopyToAsync(originalResponseBody);


                    }
                    catch (Exception ex)
                    {
                        await context.Request.Body.CopyToAsync(requestBodyStream);
                        requestBodyStream.Seek(0, SeekOrigin.Begin);

                        string requestBodyText = new StreamReader(requestBodyStream).ReadToEnd();

                        context.Response.ContentType = "application/json";
                        context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;

                        byte[] data = System.Text.Encoding.UTF8.GetBytes(new BaseApiResponse()
                        {
                            Success = false,
                            Message = ex.Message
                        }.ToString());

                        var url = context.Request.GetDisplayUrl();
                        if (!url.Contains("https://localhost"))
                        {
                            SendExceptionEmail(ex, context, requestBodyText);
                        }
                        return;
                    }
                    finally
                    {
                        context.Request.Body = originalRequestBody;
                        context.Response.Body = originalResponseBody;
                    }
                }
            }
        }

        /// <summary>
        /// Send Exception Email
        /// </summary>
        public async Task<bool> SendExceptionEmail(Exception ex, HttpContext context, string requestBodyText)
        {
            TokenModel userTokenData = null;
            var paramValues = JsonConvert.DeserializeObject(requestBodyText);
            if (paramValues == null)
            {
                paramValues = ErrorMessage.NoParametersPassed;
            }
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                userTokenData = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            EmailNotification.EmailSetting setting = new EmailSetting
            {
                EmailEnableSsl = Convert.ToBoolean(_smtpSettings.EmailEnableSsl),
                EmailHostName = _smtpSettings.EmailHostName,
                EmailPassword = _smtpSettings.EmailPassword,
                EmailAppPassword = _smtpSettings.EmailAppPassword,
                EmailPort = Convert.ToInt32(_smtpSettings.EmailPort),
                FromEmail = _smtpSettings.FromEmail,
                FromName = _smtpSettings.FromName,
                EmailUsername = _smtpSettings.EmailUsername,
            };

            string emailBody = string.Empty;
            string BasePath = Path.Combine(Directory.GetCurrentDirectory(), Constants.EmailTemplate);

            if (!Directory.Exists(BasePath))
            {
                Directory.CreateDirectory(BasePath);
            }
            bool isSuccess = false;

            using (StreamReader reader = new StreamReader(Path.Combine(BasePath, Constants.ExceptionReport)))
            {
                emailBody = reader.ReadToEnd();
            }
            string host = _httpContextAccessor.HttpContext.Request.Scheme + "://" + _httpContextAccessor.HttpContext.Request.Host.Value;
            emailBody = emailBody.Replace("##LogoURL##", host + _config["AppSettings:Logo"]);
            emailBody = emailBody.Replace("##DateTime##", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            emailBody = emailBody.Replace("##RequestedURL##", context.Request.GetDisplayUrl());
            emailBody = emailBody.Replace("##ExceptionMessage##", ex.Message);
            emailBody = emailBody.Replace("##RequestParams##", paramValues.ToString());
            emailBody = ex.InnerException != null ? emailBody.Replace("##InnerException##", ex.InnerException.ToString()) : emailBody.Replace("##InnerException##", string.Empty);
            emailBody = userTokenData != null && userTokenData.UserId != null ? emailBody.Replace("##UserId##", userTokenData.UserId.ToString()) : emailBody.Replace("##UserId##", string.Empty);
            emailBody = userTokenData != null && userTokenData.UserName != null ? emailBody.Replace("##UserName##", userTokenData.UserName.ToString()) : emailBody.Replace("##UserName##", string.Empty);
            isSuccess = SendMailMessage(_appSettings.ErrorSendToEmail, null, null, "Exception Log Alert !", emailBody, setting, null);
            if (isSuccess)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
