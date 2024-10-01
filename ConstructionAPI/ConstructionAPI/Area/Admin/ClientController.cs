using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.Client;
using ConstructionAPI.Service.Expense;
using ConstructionAPI.Service.JWTAuthentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/client")]
    [ApiController]
    [Authorize]
    public class ClientController : ControllerBase
    {
        private readonly IClientService _clientService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly IConfiguration _config;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;

        public ClientController(IClientService clientService, IJWTAuthenticationService jwtAuthenticationService, IHttpContextAccessor httpContextAccessor, IConfiguration config, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment)
        {
            _clientService = clientService;
            _jwtAuthenticationService = jwtAuthenticationService;
            _httpContextAccessor = httpContextAccessor;
            _config = config;
            _hostingEnvironment = hostingEnvironment;
        }

        [HttpPost("list")]
        public async Task<ApiResponse<ClientResponseModel>> GetClientList(CommonPaginationModel model)
        {
            ApiResponse<ClientResponseModel> response = new ApiResponse<ClientResponseModel>() { Data = new List<ClientResponseModel>() };
            var result = await _clientService.GetClientList(model);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpDelete("delete/{clientId}")]
        public async Task<ApiPostResponse<int>> DeleteClient(string clientId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var clientIdGuid = new Guid(clientId);
            var result = await _clientService.DeleteClient(clientIdGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.ClientDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ClientDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{clientId}")]
        public async Task<ApiPostResponse<ClientResponseModel>> GetClientById(string clientId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiPostResponse<ClientResponseModel> response = new ApiPostResponse<ClientResponseModel>();
            var clientGuid = new Guid(clientId);
            var result = await _clientService.GetClientById(clientGuid);
            
            if (result != null)
            {
                result.HeaderImageLetterPage = String.IsNullOrEmpty(result.HeaderImageLetterPage) ? null : PathValue + _config["PdfTemplate:HeaderImagePath"] + '/' + result.HeaderImageLetterPage;
                result.FooterImageLetterPage = String.IsNullOrEmpty(result.FooterImageLetterPage) ? null :  PathValue + _config["PdfTemplate:FooterImagePath"] + '/' + result.FooterImageLetterPage;

                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpGet("active-inactive/{clientId}")]
        public async Task<BaseApiResponse> ActiveDeactiveClientByAdmin(string clientId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _clientService.ActiveInactiveClient(clientId, tokenModel.UserId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.ClientDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.ClientActivated;
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
        public async Task<ApiPostResponse<int>> AddUpdateClient([FromForm] ClientRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            if(model.HeaderImage != null)
            {
                var path = _hostingEnvironment.WebRootPath + _config["PdfTemplate:HeaderImagePath"];
                model.HeaderImageLetterPage = await CommonMethod.UploadImage(model.HeaderImage, path);
            }
            if (model.FooterImage != null)
            {
                var path = _hostingEnvironment.WebRootPath + _config["PdfTemplate:FooterImagePath"];
                model.FooterImageLetterPage = await CommonMethod.UploadImage(model.FooterImage, path);
            }

            var result = await _clientService.SaveClient(model, tokenModel.UserId);
            if (result == 2)
            {
                response.Message = ErrorMessage.ClientFirmNameAlreadyExists;
                response.Success = false;
            }
            else if (result == 1)
            {
                response.Message = ErrorMessage.ClientUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.ClientAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ClientAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("package-type-list")]
        public async Task<ApiResponse<PackageTypeResposeModel>> GetExpenseTypeList()
        {
            ApiResponse<PackageTypeResposeModel> response = new ApiResponse<PackageTypeResposeModel>() { Data = new List<PackageTypeResposeModel>() };
            var result = await _clientService.GetPackageTypeList();
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

    }
}
