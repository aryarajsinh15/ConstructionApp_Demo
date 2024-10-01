using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Model.User;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.User;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/user")]
    [ApiController]
    [Authorize]
    public class UserController : ControllerBase
    {
        public readonly IUserService _userService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;

        public UserController(IUserService userService, IHttpContextAccessor httpContextAccessor, IJWTAuthenticationService jwtAuthenticationService)
        {
            _userService = userService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jwtAuthenticationService;
        }

        [HttpPost("list")]
        public async Task<ApiResponse<UserListResponseModel>> GetUserList(UserListRequestModel model)
        {
            if(model.ClientId == null)
            {
                TokenModel tokenModel = new TokenModel();
                string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
                if (!string.IsNullOrEmpty(jwtToken))
                {
                    tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
                }
                model.ClientId = tokenModel.ClientId;
            }
            ApiResponse<UserListResponseModel> response = new ApiResponse<UserListResponseModel>() { Data = new List<UserListResponseModel>() };
            var result = await _userService.GetUserList(model);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpDelete("delete/{userId}")]
        public async Task<ApiPostResponse<int>> DeleteUser(string userId)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var userGuid = new Guid(userId);
            var result = await _userService.DeleteUser(userGuid);
            if (result > 0)
            {
                response.Message = ErrorMessage.UserDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.UserDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{userId}")]
        public async Task<ApiPostResponse<UserResponseModel>> GetUserById(string userId)
        {
            ApiPostResponse<UserResponseModel> response = new ApiPostResponse<UserResponseModel>();
            var userGuid = new Guid(userId);
            var result = await _userService.GetUserById(userGuid);
            if (result != null)
            {
                result.password = EncryptionDecryption.GetDecrypt(result.password);
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpGet("active-inactive/{userId}")]
        public async Task<BaseApiResponse> ActiveDeactiveUserByAdmin(string userId)
        {
            BaseApiResponse response = new BaseApiResponse();
            var result = await _userService.ActiveInactiveUser(userId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.UserDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.UserActivated;
                    response.Success = true;
                }
            }
            else
            {
                response.Message = ErrorMessage.SomethingWentWrong;
                response.Success = false;
            }
            return response;
        }

        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> AddUpdateUser([FromBody] UserRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            if(model.clientId == null)
            {
                TokenModel tokenModel = new TokenModel();
                string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
                if (!string.IsNullOrEmpty(jwtToken))
                {
                    tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
                }
                model.clientId = tokenModel.ClientId;
            }
            model.Password = EncryptionDecryption.GetEncrypt(model.Password);
            var result = await _userService.SaveUser(model);

            if (result == 2)
            {
                response.Message = ErrorMessage.UserEmailAlreadyExists;
                response.Success = false;
            }
            else if (result == 3)
            {
                response.Message = ErrorMessage.UserNameAlreadyExists;
                response.Success = false;
            }
            else if (result == 1)
            {
                response.Message = ErrorMessage.UserUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.UserAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.UserAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("active-user-list")]
        public async Task<ApiResponse<ActiveUserResponseModel>> GetActiveUserList()
        {
            ApiResponse<ActiveUserResponseModel> response = new ApiResponse<ActiveUserResponseModel>() { Data = new List<ActiveUserResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _userService.ActiveUserList(new Guid(tokenModel.ClientId));
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

       
    }
}
