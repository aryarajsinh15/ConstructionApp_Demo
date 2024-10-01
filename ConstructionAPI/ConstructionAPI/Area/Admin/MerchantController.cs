using ConstructionAPI.Common.Enum;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.Merchant;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using System.Net.NetworkInformation;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/merchant")]
    [ApiController]
    //[Authorize]
    public class MerchantController : ControllerBase
    {
        #region Fields
        private readonly IMerchantService _merchantService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;
        #endregion

        #region Constructor
        public MerchantController(IMerchantService merchantService, 
            IHttpContextAccessor httpContextAccessor, 
            IJWTAuthenticationService jwtAuthenticationService, 
            Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment)
        {
            _merchantService = merchantService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jwtAuthenticationService;
            _hostingEnvironment = hostingEnvironment;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Get Merchant List 
        /// </summary>
        /// <param name="model"></param>
        [HttpPost("list")]
        public async Task<ApiResponse<MerchantResponseModel>> GetMerchantList(CommonPaginationModel model)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiResponse<MerchantResponseModel> response = new ApiResponse<MerchantResponseModel> { Data = new List<MerchantResponseModel>() };

            var result = await _merchantService.GetMerchantList(model, tokenModel.ClientId);

            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
		/// Get Merchant detail By Id 
		/// </summary>
		/// <param name="id"></param>
		[HttpGet("{id}")]
        public async Task<ApiResponse<MerchantResponseModel>> GetMerchantById(string id)
        {
            ApiResponse<MerchantResponseModel> response = new ApiResponse<MerchantResponseModel> { Data = new List<MerchantResponseModel>() };
            var result = await _merchantService.GetMerchantGetById(id);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
		/// Save Merchant 
		/// </summary>
		/// <param name="model"></param>
		[HttpPost("save")]
        public async Task<BaseApiResponse> SaveMerchant(MerchantRequestModel model)
        {
            BaseApiResponse response = new BaseApiResponse();

            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            tokenModel.UserId = Guid.NewGuid();
            var result = await _merchantService.SaveMerchant(model, tokenModel.UserId, tokenModel.ClientId);

            if (result.IsSuccess == Status.Success)
            {
                response.Message = result.Result;
                response.Success = true;
            }
            else if (result.IsSuccess == Status.Failed)
            {
                response.Message = result.Result;
                response.Success = false;
            }
            return response;
        }

        /// <summary>
		/// Delete Merchant
		/// </summary>
		/// <param name="id"></param>
		[HttpDelete("delete/{id}")]
        public async Task<BaseApiResponse> DeleteMerchant(string id)
        {
            BaseApiResponse response = new BaseApiResponse();
            var result = await _merchantService.DeleteMerchant(id);

            response.Message = result.Result;
            if (result.IsSuccess == Status.Success)
            {
                response.Success = true;
            }
            else
            {
                response.Success = false;
            }
            return response;
        }

        /// <summary>
        /// Get Client List
        /// </summary>
        /// <returns></returns>        
        [HttpGet("client-list")]
        public async Task<IActionResult> GetClientList()
        {
            var response = new ApiResponse<ClientResponseModel> { Data = new List<ClientResponseModel>(), Success = false };
            try
            {
                var result = await _merchantService.GetClientList();

                if (result != null)
                {
                    response.Data = result;
                    response.Success = true;
                    return Ok(response);
                }
                else
                {
                    response.Message = "No clients found.";
                    return NotFound(response);
                }
            }
            catch (Exception ex)
            {
                response.Message = $"An error occurred: {ex.Message}";
                return StatusCode(StatusCodes.Status500InternalServerError, response);
            }
        }

        /// <summary>
        /// Active Deactive Merchant
        /// </summary>
        /// <param name="expenseId"></param>
        /// <returns></returns>
        [HttpGet("active-inactive/{merchantId}")]
        public async Task<BaseApiResponse> ActiveDeactiveMerchant(string merchantId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _merchantService.ActiveInactiveMerchant(merchantId, tokenModel.UserId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.MerchantDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.MerchantActivated;
                    response.Message = ErrorMessage.MerchantActivated;
                    response.Message = ErrorMessage.MerchantActivated;
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

        /// <summary>
        /// Get Merchant List 
        /// </summary>
        /// <param name="model"></param>
        [HttpGet("dropdown-list")]
        public async Task<ApiResponse<MerchantListDropDownModel>> GetMerchantListForDropDown()
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiResponse<MerchantListDropDownModel> response = new ApiResponse<MerchantListDropDownModel> { Data = new List<MerchantListDropDownModel>() };

            var result = await _merchantService.GetMerchantListForDropDown(tokenModel.ClientId);

            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }
        #endregion
    }
}
