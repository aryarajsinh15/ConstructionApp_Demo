using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.PersonBill;
using ConstructionAPI.Model.SiteBill;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.Expense;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.PersonBill;
using ConstructionAPI.Service.SiteBill;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/person-bill")]
    [ApiController]
    [Authorize]
    public class PersonBillController : ControllerBase
    {
        private readonly IPersonBillService _personBillService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly IConfiguration _config;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;

        public PersonBillController(IPersonBillService personBillService, IHttpContextAccessor httpContextAccessor, IConfiguration config, IJWTAuthenticationService jWTAuthenticationService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment)
        {
            _personBillService = personBillService;
            _httpContextAccessor = httpContextAccessor;
            _config = config;
            _jwtAuthenticationService = jWTAuthenticationService;
            _hostingEnvironment = hostingEnvironment;
        }


        [HttpPost("list")]
        public async Task<ApiResponse<PersonBillListResponseModel>> GetPersonBillList(PersonBillListRequestModel model)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiResponse<PersonBillListResponseModel> response = new ApiResponse<PersonBillListResponseModel>() { Data = new List<PersonBillListResponseModel>() };
            var result = await _personBillService.GetPersonBillList(model);
            if (result != null)
            {
                for (var i = 0; i < result.Count; i++)
                {
                    result[i].PersonBillFile = result[i].PersonBillFile != null ? PathValue + _config["Path:PersonBillPath"] + '/' + result[i].PersonBillFile : null;
                }
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpDelete("delete/{billId}")]
        public async Task<ApiPostResponse<int>> DeletePersonBill(string billId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var billIdGuid = new Guid(billId);
            var result = await _personBillService.DeletePersonBill(billIdGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.PersonDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.PersonBillDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{billId}")]
        public async Task<ApiPostResponse<PersonBillResponseModel>> GetPersonBillById(string billId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiPostResponse<PersonBillResponseModel> response = new ApiPostResponse<PersonBillResponseModel>();
            var billIdGuid = new Guid(billId);
            var result = await _personBillService.GetPersonBillById(billIdGuid);
            if (result != null)
            {
                if (result.SiteBillFile != null)
                {
                    result.SiteBillFile = PathValue + _config["Path:PersonBillPath"] + '/' + result.SiteBillFile;
                }
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> AddUpdatePersonBill([FromForm] PersonBillRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            if (model.PersonBillFile != null)
            {
                var path = _hostingEnvironment.WebRootPath + _config["Path:PersonBillPath"];
                model.PersonBillFileName = model.PersonBillFile.FileName;
                model.PersonBillNewFileName = await CommonMethod.UploadImage(model.PersonBillFile, path);
            }
            var result = await _personBillService.SavePersonBill(model, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.PersonBillUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.PersonBillAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.PersonBillAddEditError;
                response.Success = false;
            }
            return response;
        }
    }
}
