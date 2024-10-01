using ConstructionAPI.Common.Enum;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.Login;
using ConstructionAPI.Model.Settings;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.Account;
using ConstructionAPI.Service.JWTAuthentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/account")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        #region Field
        private readonly IAccountService _accountService;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly AppSettings _appSettings;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IConfiguration _config;

        #endregion

        #region Constructor
        public AccountController(IAccountService accountService, IOptions<AppSettings> appSettings, IJWTAuthenticationService jWTAuthenticationService, IHttpContextAccessor httpContextAccessor, IConfiguration config)
        {
            _accountService = accountService;
            _appSettings = appSettings.Value;
            _jwtAuthenticationService = jWTAuthenticationService;
            _httpContextAccessor = httpContextAccessor;
            _config = config;
        }
        #endregion

        [HttpPost("login")]
        public async Task<ApiPostResponse<LoginResponseModel>> LoginUser([FromBody] LoginRequestModel model)
        {
            //throw new Exception("Chirag Testing Exception");
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;

            ApiPostResponse<LoginResponseModel> response = new ApiPostResponse<LoginResponseModel>() { Data = new LoginResponseModel() };
            var password = EncryptionDecryption.GetEncrypt(model.Password);
            model.Password = password;
            var data = await _accountService.LoginUser(model);

            if(data == null)
            {
                response.Success = false;
                response.Message = ErrorMessage.InvalidEmailId;
                return response;
            }
            else if(data.Status == LoginStatus.EmailNotExist)
            {
                response.Success = false;
                response.Message = ErrorMessage.UserNotExists;
                return response;
            }
            else if (data.Status == LoginStatus.CompanyInActivated)
            {
                response.Success = false;
                response.Message = ErrorMessage.CompanyDeactived;
                return response;
            }
            else if (data.Status == LoginStatus.CompanyPackageExpired)
            {
                response.Success = false;
                response.Message = ErrorMessage.CompanyPackageExpired;
                return response;
            }
            else if (data.Status == LoginStatus.UserDeactive)
            {
                response.Success = false;
                response.Message = ErrorMessage.UserDeactived;
                return response;
            }
            else
            {
                TokenModel objTokenData = new TokenModel();
                objTokenData.UserName = data.EmailId;
                objTokenData.UserName = data.UserName;
                objTokenData.FullName = data.FullName;
                objTokenData.RoleId = data.RoleId;
                objTokenData.UserId = data.UserId;
                objTokenData.ClientId = data.ClientId.ToString();
                AccessTokenModel objAccessTokenData = _jwtAuthenticationService.GenerateToken(objTokenData, _appSettings.JWT_Secret, _appSettings.JWT_Validity_Mins);
                data.JWTToken = objAccessTokenData.Token;
                data.UserPhoto = data.UserPhoto != null ? PathValue + _config["Path:UserPhotoPath"] + '/' + data.UserPhoto : "";

                await _accountService.UpdateLoginToken(objAccessTokenData.Token, data.UserId);
                response.Message = ErrorMessage.LoginSuccess;
                response.Success = true;
            }
            response.Data = data;
            return response;

        }

        [HttpPost("change-password")]
        [Authorize]
        public async Task<ApiPostResponse<int>> ChangeUserPassword([FromBody] ChangePasswordRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            if(model.NewPassword != model.ConfirmPassword)
            {
                response.Message = ErrorMessage.NewPasswordConfirmPasswordNotMatch; 
                response.Success = false;
                return response;
            }
            model.OldPassword = EncryptionDecryption.GetEncrypt(model.OldPassword);
            model.NewPassword = EncryptionDecryption.GetEncrypt(model.NewPassword);

            var result = await _accountService.UpdateUserPassword(model, tokenModel.UserId);
            if (result == 1)
            {
                response.Message = ErrorMessage.WorngOldPassword;
                response.Success = false;
            }
            else if (result == 2)
            {
                response.Message = ErrorMessage.OldPasswordNewPassowordNotSame;
                response.Success = false;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.ChangePasswordSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ChangePasswordError;
                response.Success = false;
            }
            return response;
        }
    }
}
