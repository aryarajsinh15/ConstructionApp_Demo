    using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.Site;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.Net.Http.Headers;
using System.Reflection;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/site")]
    [ApiController]
    [Authorize]
    public class SiteController : ControllerBase
    {
        #region Fields
        private readonly ISiteService _siteService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;
        #endregion

        #region Constructor
        public SiteController(ISiteService siteService, IJWTAuthenticationService jwtAuthenticationService, IHttpContextAccessor httpContextAccessor, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _siteService = siteService;
            _jwtAuthenticationService = jwtAuthenticationService;
            _httpContextAccessor = httpContextAccessor;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }
        #endregion

        #region Methods
        /// <summary>
        ///  Get site list  
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        [HttpPost("list")]
        public async Task<ApiResponse<SiteListResponseModel>> GetSiteList(SiteListRequestModel model)
        {
            ApiResponse<SiteListResponseModel> response = new ApiResponse<SiteListResponseModel>() { Data = new List<SiteListResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _siteService.GetSitesList(model, tokenModel.ClientId);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
        ///  Get siteinfo by siteId  
        /// </summary>
        /// <param name="siteId></param>
        /// <returns></returns>
        [HttpGet("{siteId}")]
        public async Task<ApiPostResponse<SiteResponseModel>> GetSiteById(string siteId)
        {
            ApiPostResponse<SiteResponseModel> response = new ApiPostResponse<SiteResponseModel>();
            var siteGuid = new Guid(siteId);
            var result = await _siteService.GetSiteById(siteGuid);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
        /// Delete site 
        /// </summary>
        /// <param name="siteId"></param>
        /// <returns></returns>
        [HttpDelete("delete/{siteId}")]
        public async Task<ApiPostResponse<int>> DeleteSite(string siteId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var siteGuid = new Guid(siteId);
            var result = await _siteService.DeleteSite(siteGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.SiteDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SiteDeleteError;
                response.Success = false;
            }
            return response;
        }

        /// <summary>
        ///  Add Update siteinfo 
        /// </summary>
        /// <param model="SiteResponseModel"></param>
        /// <returns></returns>
        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> AddUpdateSite([FromBody] SiteRequestModel site)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _siteService.SaveSites(site, tokenModel.UserId, new Guid(tokenModel.ClientId));
            if (result == 2)
            {
                response.Message = ErrorMessage.SiteNameAlreadyExists;
                response.Success = false;
            }
            else if (result == 1)
            {
                response.Message = ErrorMessage.SiteUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.SiteAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SiteAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("active-inactive/{siteId}")]
        public async Task<BaseApiResponse> ActiveDeactiveUserByAdmin(string siteId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _siteService.ActiveInactiveSite(siteId, tokenModel.UserId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.SiteDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.SiteActivated;
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


        [HttpGet("active-site-list")]
        public async Task<ApiResponse<ActiveSiteResponseModel>> GetActiveSiteList()
        {
            ApiResponse<ActiveSiteResponseModel> response = new ApiResponse<ActiveSiteResponseModel>() { Data = new List<ActiveSiteResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _siteService.ActiveSiteList(new Guid(tokenModel.ClientId));
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpPost("save-site-image")]
        public async Task<ApiPostResponse<int>> AddSiteImages([FromForm] SiteImageRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            List<SiteImageNameModel> siteImageListName = new List<SiteImageNameModel> ();

            if (model.Photo.Count > 0)
            {
                var path = _hostingEnvironment.WebRootPath + _config["Path:SiteImagePath"];
                for (var i = 0; i < model.Photo.Count; i++)
                {
                    SiteImageNameModel galleryImage = new SiteImageNameModel
                    {
                        ImageFileOriginalName = model.Photo[i].FileName,
                        ImageFileEncryptedName = await CommonMethod.UploadImage(model.Photo[i], path)
                    };
                    siteImageListName.Add(galleryImage);
                }
            }
            if (model.SiteImage != null && model.SiteImage.Count > 0)
            {
                model.SiteImage.Clear();
            }
            model.SiteImage = siteImageListName;
            var result = await _siteService.AddSiteImages(model);
            if (result == 0)
            {
                response.Message = ErrorMessage.SitePhotoUploadSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SomethingWentWrong;
                response.Success = false;
            }

            return response;

        }

        [HttpGet("site-image-list/{siteId}")]
        public async Task<ApiResponse<SiteImageResponseModel>> GetSiteImageList(string siteId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;

            ApiResponse<SiteImageResponseModel> response = new ApiResponse<SiteImageResponseModel>() { Data = new List<SiteImageResponseModel>() };
            var result = await _siteService.SiteImages(siteId);
            if (result != null)
            {
                for (var i = 0; i < result.Count; i++)
                {
                    for(var j = 0; j < result[i].Images.Count; j++)
                    {
                        result[i].Images[j].PhotoName = result[i].Images[j].PhotoName != null ? PathValue + _config["Path:SiteImagePath"] + '/' + result[i].Images[j].PhotoName : null;
                    }
                }
                response.Data = result;
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
        /// Delete site 
        /// </summary>
        /// <param name="siteId"></param>
        /// <returns></returns>
        [HttpDelete("delete-site-photo/{sitePhotoId}")]
        public async Task<ApiPostResponse<int>> DeleteSitePhoto(string sitePhotoId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var sitePhotoGuid = new Guid(sitePhotoId);
            var result = await _siteService.DeleteSitePhoto(sitePhotoGuid);
            if (result > 0)
            {
                response.Message = ErrorMessage.SitePhotoDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SitePhotoDeleteError;
                response.Success = false;
            }
            return response;
        }
        #endregion
    }
}