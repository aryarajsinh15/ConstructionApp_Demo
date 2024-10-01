using ConstructionAPI.Common.Enum;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Person;
using ConstructionAPI.Model.PersonGroup;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.Client;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.PersonGroup;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/person-group")]
    [ApiController]
    [Authorize]
    public class PersonGroupController : ControllerBase
    {
        #region Fields
        private readonly IPersonGroupService _personGroupService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService; 
        #endregion

        #region Constructor
        public PersonGroupController(IPersonGroupService personGroupService, IJWTAuthenticationService jwtAuthenticationService, IHttpContextAccessor httpContextAccessor)
        {
            _personGroupService = personGroupService;
            _jwtAuthenticationService = jwtAuthenticationService;
            _httpContextAccessor = httpContextAccessor;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Get Person Group List
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("list")]
        public async Task<ApiResponse<PersonGroupListResponseModel>> GetGroupList(CommonPaginationModel model)
        {
            try
            {
                ApiResponse<PersonGroupListResponseModel> response = new ApiResponse<PersonGroupListResponseModel>() { Data = new List<PersonGroupListResponseModel>() };
                TokenModel tokenModel = new TokenModel();
                string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
                if (!string.IsNullOrEmpty(jwtToken))
                {
                    tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
                }
                var result = await _personGroupService.GetGroupList(model, tokenModel.ClientId);
                if (result != null)
                {
                    response.Data = result;
                }
                response.Success = true;
                return response;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost("save")]
        public async Task<BaseApiResponse> SavePersonGroup(PersonGroupRequestModel model)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }

            var result = await _personGroupService.SavePersonGroup(model, new Guid(tokenModel.ClientId), tokenModel.UserId);

            if (result.IsSuccess == Status.Updated || result.IsSuccess == Status.Saved)
            {
                response.Message = result.Result;
                response.Success = true;
            }
            else if(result.IsSuccess == Status.AlreadyExists)
            {
                response.Message = result.Result;
                response.Success = false;
            }
            else if (result.IsSuccess == Status.Failed)
            {
                response.Message = result.Result;
                response.Success = false;
            }
            return response;
        }

        [HttpDelete("delete/{groupId}")]
        public async Task<ApiPostResponse<int>> DeleteExpense(string groupId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var groupIdGuid = new Guid(groupId);
            var result = await _personGroupService.DeletePersonGroup(groupIdGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.PersonGroupDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.PersonGroupDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("active-inactive/{id}")]
        public async Task<BaseApiResponse> ActiveDeactivePersonGroup(string id)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _personGroupService.ActiveInactivePersonGroup(id, tokenModel.UserId);
            if (result != null)
            {

                if (result.IsSuccess == Status.InActivated)
                {
                    response.Message = result.Result;
                    response.Success = true;
                }
                else if (result.IsSuccess == Status.Activited)
                {
                    response.Message = result.Result;
                    response.Success = true;
                }
                else if (result.IsSuccess == Status.Failed)
                {
                    response.Message = result.Result;
                    response.Success = false;
                }
            }
            else
            {
                response.Message = ErrorMessage.SomethingWentWrong;
                response.Success = false;
            }
            return response;
        }
        #endregion

    }
}
