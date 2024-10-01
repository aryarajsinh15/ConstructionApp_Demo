using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.SitePhotoCategory;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.SitePhotoCategory;
using ConstructionAPI.Service.VehicleOwner;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/site-photo-category")]
    [ApiController]
    [Authorize]
    public class SitePhotoCategoryController : ControllerBase
    {
        public readonly ISitePhotoCategoryService _sitePhotoCategoryService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;

        public SitePhotoCategoryController(ISitePhotoCategoryService sitePhotoCategoryService, IHttpContextAccessor httpContextAccessor, IJWTAuthenticationService jWTAuthenticationService)
        {
            _sitePhotoCategoryService = sitePhotoCategoryService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jWTAuthenticationService;
        }


        [HttpPost("list")]
        public async Task<ApiResponse<SitePhotoCategoryListResponseModel>> GetSitePhotoCategoryList(CommonPaginationModel model)
        {
            ApiResponse<SitePhotoCategoryListResponseModel> response = new ApiResponse<SitePhotoCategoryListResponseModel>() { Data = new List<SitePhotoCategoryListResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _sitePhotoCategoryService.GetSitePhotoCategoryList(model, tokenModel.ClientId);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpDelete("delete/{sitePhotoCategoryId}")]
        public async Task<ApiPostResponse<int>> DeleteSitePhotoCategory(string sitePhotoCategoryId)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var sitePhotoCategoryGuid = new Guid(sitePhotoCategoryId);
            var result = await _sitePhotoCategoryService.DeleteSitePhotoCategory(sitePhotoCategoryGuid);
            if (result > 0)
            {
                response.Message = ErrorMessage.SitePhotoCategoryDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SitePhotoCategoryDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{sitePhotoCategoryId}")]
        public async Task<ApiPostResponse<SitePhotoCategoryResponseModel>> GetVehicleById(string sitePhotoCategoryId)
        {
            ApiPostResponse<SitePhotoCategoryResponseModel> response = new ApiPostResponse<SitePhotoCategoryResponseModel>();
            var sitePhotoCategoryGuid = new Guid(sitePhotoCategoryId);
            var result = await _sitePhotoCategoryService.GetSitePhotoCategoryById(sitePhotoCategoryGuid);
            if (result != null)
            {
                response.Data = result;
                response.Success = true;
                response.Message = ErrorMessage.Success;
            }
            else
            {
                response.Success = false;
                response.Message = ErrorMessage.SomethingWentWrong;
            }
            return response;
        }

        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> AddUpdateSitePhotoCategory([FromBody] SitePhotoCategoryRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _sitePhotoCategoryService.SaveSitePhotoCategory(model, tokenModel.ClientId);

            if (result == 1)
            {
                response.Message = ErrorMessage.SitePhotoCategoryUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.SitePhotoCategoryAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SitePhotoCategoryAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("active-category-list")]
        public async Task<ApiResponse<SitePhotoCategoryListResponseModel>> GetActiveSiteList()
        {
            ApiResponse<SitePhotoCategoryListResponseModel> response = new ApiResponse<SitePhotoCategoryListResponseModel>() { Data = new List<SitePhotoCategoryListResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _sitePhotoCategoryService.GetActiveSitePhotoCategoryList(tokenModel.ClientId);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }
    }
}
