using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Model.VehicleOwner;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.VehicleOwner;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/vehicle-owner")]
    [ApiController]
    [Authorize]
    public class VehicleOwnerController : ControllerBase
    {
        public readonly IVehicleOwnerService _vehicleOwnerService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;

        public VehicleOwnerController(IVehicleOwnerService vehicleOwnerService, IHttpContextAccessor httpContextAccessor, IJWTAuthenticationService jWTAuthenticationService)
        {
            _vehicleOwnerService = vehicleOwnerService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jWTAuthenticationService;
        }

        [HttpPost("list")]
        public async Task<ApiResponse<VehicleOwnerListModel>> GetVehicleOwnerList(CommonPaginationModel model)
        {
            ApiResponse<VehicleOwnerListModel> response = new ApiResponse<VehicleOwnerListModel>() { Data = new List<VehicleOwnerListModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _vehicleOwnerService.GetVehicleOwnerList(model, tokenModel.ClientId);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpDelete("delete/{vehicleOwnerId}")]
        public async Task<ApiPostResponse<int>> DeleteVehicleOwner(string vehicleOwnerId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var clientIdGuid = new Guid(vehicleOwnerId);
            var result = await _vehicleOwnerService.DeleteVehicleOwner(clientIdGuid, tokenModel.UserId);
            if (result == 1)
            {
                response.Message = ErrorMessage.VehicleOwnerDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.VehicleOwnerDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{vehicleOwnerId}")]
        public async Task<ApiPostResponse<VehicleOwnerResponseModel>> GetVehicleById(string vehicleOwnerId)
        {
            ApiPostResponse<VehicleOwnerResponseModel> response = new ApiPostResponse<VehicleOwnerResponseModel>();
            var vehicleOwnerGuid = new Guid(vehicleOwnerId);
            var result = await _vehicleOwnerService.GetVehicleOwnerById(vehicleOwnerGuid);
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

        [HttpGet("active-inactive/{vehicleOwnerId}")]
        public async Task<BaseApiResponse> ActiveDeactiveVehicleOwner(string vehicleOwnerId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _vehicleOwnerService.ActiveInactiveVehicleOwner(vehicleOwnerId, tokenModel.UserId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.VehicleOwnerDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.VehicleOwnerActivated;
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
        public async Task<ApiPostResponse<int>> AddUpdateVehicleOwner([FromBody] VehicleOwnerRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _vehicleOwnerService.SaveVehicleOwner(model, tokenModel.UserId, tokenModel.ClientId);
            
            if (result == 1)
            {
                response.Message = ErrorMessage.VehicleOwnerUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.VehicleOwnerAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.VehicleOwnerAddEditError;
                response.Success = false;
            }
            return response;
        }
    }
}
