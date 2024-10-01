using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Profile;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Model.User;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.Profile;
using ConstructionAPI.Service.Site;
using ConstructionAPI.Service.User;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/profile")]
    [ApiController]
    [Authorize]
    public class ProfileController : ControllerBase
    {
        #region Fields
        private readonly IProfileService _profileService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        public readonly IUserService _userService;
        private readonly IConfiguration _config;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;

        #endregion

        #region Constructor
        public ProfileController(IProfileService profileService, IHttpContextAccessor httpContextAccessor, IJWTAuthenticationService jwtAuthenticationService,IUserService userService, IConfiguration config, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment)
        {
            _profileService = profileService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jwtAuthenticationService;
            _userService = userService;
            _config = config;
            _hostingEnvironment = hostingEnvironment;
        }
        #endregion

        #region Methods

        /// <summary>
        ///  Update profile 
        /// </summary>
        /// <param model="ProfileResponseModel"></param>
        /// <returns></returns>
        [HttpPost("update-profile")]
        public async Task<ApiPostResponse<int>> UpdateProfile([FromForm] ProfileRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            if (model.UserPhoto != null)
            {
                var path = _hostingEnvironment.WebRootPath + _config["Path:UserPhotoPath"];
                model.UserPhotoName = await CommonMethod.UploadImage(model.UserPhoto, path);
            }
            var result = await _profileService.UpdateProfile(model, tokenModel.UserId);
            if (result == 1)
            {
                response.Message = ErrorMessage.UpdateProflieSuccess;
                response.Success = true;
            }
            else if (result == 2)
            {
                response.Message = ErrorMessage.UserEmailAlreadyExists;
                response.Success = false;
            }
            else if (result == 3)
            {
                response.Message = ErrorMessage.UserNameAlreadyExists;
                response.Success = false;
            }
            else
            {
                response.Message = ErrorMessage.UpdateProflieError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("get-user-details")]
        public async Task<ApiPostResponse<UserResponseModel>> GetUserById()
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<UserResponseModel> response = new ApiPostResponse<UserResponseModel>();
            var result = await _userService.GetUserById(tokenModel.UserId);
            
            if (result != null)
            {
                result.UserPhoto = result.UserPhoto != null ? PathValue + _config["Path:UserPhotoPath"] + '/' + result.UserPhoto : "";
                result.password = EncryptionDecryption.GetDecrypt(result.password);
                response.Data = result;
            }
            response.Success = true;
            return response;
        }
        #endregion
    }
}