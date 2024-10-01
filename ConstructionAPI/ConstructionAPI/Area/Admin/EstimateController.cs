using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Estimate;
using ConstructionAPI.Model.SiteBill;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.Estimate;
using ConstructionAPI.Service.JWTAuthentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/estimate")]
    [ApiController]
    [Authorize]

    public class EstimateController : ControllerBase
    {
        public readonly IEstimateService _estimateService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;

        public EstimateController(IEstimateService estimateService, IHttpContextAccessor httpContextAccessor, IJWTAuthenticationService jWTAuthenticationService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _estimateService = estimateService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jWTAuthenticationService;
            _hostingEnvironment = hostingEnvironment;   
            _config = config;
        }

        [HttpPost("list")]
        public async Task<ApiResponse<EstimateListResponseModel>> GetEstimateList(EstimatePaginationModel model)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiResponse<EstimateListResponseModel> response = new ApiResponse<EstimateListResponseModel>() { Data = new List<EstimateListResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _estimateService.GetEstimateList(model, tokenModel.ClientId);
            if (result != null)
            {
                for (var i = 0; i < result.Count; i++)
                {
                    result[i].EstimateFile = result[i].EstimateFile != null ? PathValue + _config["Path:EstimateImagePath"] + '/' + result[i].EstimateFile : null;
                }
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }


        [HttpDelete("delete/{estimateId}")]
        public async Task<ApiPostResponse<int>> DeleteEstimate(string estimateId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var estimateIdGuid = new Guid(estimateId);
            var result = await _estimateService.DeleteEstimate(estimateIdGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.EstimateDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.EstimateDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{estimateId}")]
        public async Task<ApiPostResponse<EstimateListResponseModel>> GetEstimateById(string EstimateId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiPostResponse<EstimateListResponseModel> response = new ApiPostResponse<EstimateListResponseModel>();
            //var estimateGuid = new Guid(EstimateId);
            var result = await _estimateService.GetEstimateById(EstimateId);
            if (result != null)
            {
                if (result.EstimateFile != null)
                {
                    result.EstimateFile = PathValue + _config["Path:EstimateImagePath"] + '/' + result.EstimateFile;
                }
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpGet("active-inactive/{estimateId}")]
        public async Task<BaseApiResponse> ActiveDeactiveEstimate(string EstimateId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _estimateService.ActiveInactiveEstimate(EstimateId, tokenModel.UserId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.EstimateDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.EstimateActivated;
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
        public async Task<ApiPostResponse<int>> SaveEstimate([FromForm] EstimateRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            if (model.EstimatePhoto != null)
            {
                var path = _hostingEnvironment.WebRootPath + _config["Path:EstimateImagePath"];
                model.EstimatePhotoName = model.EstimatePhoto.FileName;
                model.EstimateNewPhotoName= await CommonMethod.UploadImage(model.EstimatePhoto, path);
            }
            var result = await _estimateService.SaveEstimate(model, tokenModel.UserId, tokenModel.ClientId);

            if (result == 1)
            {
                response.Message = ErrorMessage.EstimateUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.EstimateAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.EstimateAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpPost("without-file-save")]
        public async Task<ApiPostResponse<int>> AddUpdateEstimateBillWithoutFile(EstimateWithoutFileRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _estimateService.SaveEstimateBillWithoutFile(model, tokenModel.UserId, tokenModel.ClientId);
            if (result == 0)
            {
                response.Message = ErrorMessage.EstimateUpdateSuccess;
                response.Success = true;
            }
            else if (result == 1)
            {
                response.Message = ErrorMessage.EstimateAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.EstimateAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("without-file-bill-detail/{estimateBillId}")]
        public async Task<ApiPostResponse<EstimateBillWithoutFileResponseModel>> GetWithoutFileEstimateBillById(string estimateBillId)
        {
            ApiPostResponse<EstimateBillWithoutFileResponseModel> response = new ApiPostResponse<EstimateBillWithoutFileResponseModel>();
            //var estimateIdGuid = new Guid(estimateId);
            var result = await _estimateService.GetWithoutFileEstimateBillById(estimateBillId);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }


    }
}
