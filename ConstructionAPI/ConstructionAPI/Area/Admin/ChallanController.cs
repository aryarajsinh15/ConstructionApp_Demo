using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Challan;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Dashboard;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Model.VehicleRent;
using ConstructionAPI.Service.Challan;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.VehicalRent;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authentication.OAuth.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using Microsoft.VisualBasic;
using System.Reflection;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/challan")]
    [ApiController]
    [Authorize]
    public class ChallanController : ControllerBase
    {
        #region Fields
        private readonly IChallanService _challanService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;
        #endregion

        #region Constructor
        public ChallanController(IChallanService challanService, IHttpContextAccessor httpContextAccessor
            , IJWTAuthenticationService jwtAuthenticationService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _challanService = challanService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jwtAuthenticationService;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }
        #endregion

        /// <summary>
        /// Get Challan Rent List 
        /// </summary>
        /// <param name="model"></param>
        [HttpPost("list")]
        public async Task<ApiResponse<ChallanResponseModel>> GetChallanList(ChallanListRequestModel model)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiResponse<ChallanResponseModel> response = new ApiResponse<ChallanResponseModel> { Data = new List<ChallanResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _challanService.GetChallanList(model, tokenModel.ClientId);
            if (result != null)
            {
                for (var i = 0; i < result.Count; i++)
                {
                    result[i].ChallanPhoto = result[i].ChallanPhoto != null ? PathValue + _config["Path:ChallanImagePath"] + '/' + result[i].ChallanPhoto : null;
                }
            }
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> SaveChallan([FromForm] ChallanRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            if (model.ChallanId != null && model.ChallanPhoto!= null)
            {
                await DeleteChallanImage(model.ChallanId);
            }

            if (model.ChallanPhoto != null)
            {
                var path = _hostingEnvironment.WebRootPath + _config["Path:ChallanImagePath"];
                model.ChallanPhotoName = model.ChallanPhoto.FileName;
                model.ChallanNewPhotoName = await CommonMethod.UploadImage(model.ChallanPhoto, path);
            }
            var result = await _challanService.SaveChallan(model, tokenModel.UserId, new Guid(tokenModel.ClientId));
            if (result > 0)
            {
                response.Message = ErrorMessage.ChallanUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.ChallanAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ChallanAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpDelete("delete/{challanId}")]
        public async Task<ApiPostResponse<int>> DeleteChallan(string challanId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var challanIdIdGuid = new Guid(challanId);
            var result = await _challanService.DeleteChallan(challanIdIdGuid, tokenModel.UserId);
            if (result > 0)
            {
                await DeleteChallanImage(challanId);
                response.Message = ErrorMessage.ChallanDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ChallanDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{challanId}")]
        public async Task<ApiPostResponse<ChallanResponseModel>> GetChallanById(string challanId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiPostResponse<ChallanResponseModel> response = new ApiPostResponse<ChallanResponseModel>();
            var challanGuid = new Guid(challanId);
            var result = await _challanService.GetChallanById(challanGuid);
            if (result != null)
            {
                if (result.ChallanPhoto != null)
                {
                    result.ChallanPhoto = PathValue + _config["Path:ChallanImagePath"] + '/' + result.ChallanPhoto;
                }
                response.Data = result;
            }
            response.Success = true;
            return response;
         }

        [HttpGet("active-inactive/{challanId}")]
        public async Task<BaseApiResponse> ActiveDeactiveChallanByAdmin(string challanId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _challanService.ActiveInactiveChallan(challanId, tokenModel.UserId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.ChallanDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.ChallanActivated;
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

        [HttpGet("merchant-list")]
        public async Task<ApiResponse<MarchantListResponseModel>> GetMarchantList()
        {
            ApiResponse<MarchantListResponseModel> response = new ApiResponse<MarchantListResponseModel> { Data = new List<MarchantListResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _challanService.GetMarchantList(tokenModel.ClientId);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

       private async Task DeleteChallanImage(string challanId)
        {
           var ChallanImageName = _challanService.GetChallanImageName(challanId); ;
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            string ChallanPhysicalPath = _hostingEnvironment.WebRootPath + "\\" + "DataFiles" + "\\" + "ChallanFile" +"\\"+ ChallanImageName.Result.ChallanPhoto;
            if (ChallanPhysicalPath != null)
            {
                if(System.IO.File.Exists(ChallanPhysicalPath))
                {
                    System.IO.File.Delete(ChallanPhysicalPath);
                }
            }
        }
    }
}
