using ConstructionAPI.Common.Enum;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.MerchantPayment;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.Merchant;
using ConstructionAPI.Service.MerchantPayment;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/merchantpayment")]
    [ApiController]
    [Authorize]
    public class MerchantPaymentController : ControllerBase
    {
        #region Fields
        private readonly IMerchantPaymentService _merchantpaymentservice;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;
        #endregion

        #region Constructor
        public MerchantPaymentController(IMerchantPaymentService merchantpaymentService, IHttpContextAccessor httpContextAccessor
            , IJWTAuthenticationService jwtAuthenticationService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment)
        {
            _merchantpaymentservice = merchantpaymentService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jwtAuthenticationService;
            _hostingEnvironment = hostingEnvironment;
        }
        #endregion

        #region Methods
        /// <summary>
		/// Get MerchantPayment List 
		/// </summary>
		/// <param name="model"></param>
		[HttpPost("list")]
        public async Task<ApiResponse<MerchantPaymentListResponseModel>> GetMerchantPaymentList(MerchantFilterModel model)
        {
            ApiResponse<MerchantPaymentListResponseModel> response = new ApiResponse<MerchantPaymentListResponseModel> { Data = new List<MerchantPaymentListResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _merchantpaymentservice.GetMerchantPaymentList(model, tokenModel.ClientId);

            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
		/// MerchantPayment By Id 
		/// </summary>
		/// <param name="id"></param>
		[HttpGet("{id}")]
        public async Task<ApiResponse<MerchantPaymentResponseModel>> GetMerchantPaymentGetById(string id)
        {
            ApiResponse<MerchantPaymentResponseModel> response = new ApiResponse<MerchantPaymentResponseModel> { Data = new List<MerchantPaymentResponseModel>() };
            
            var result = await _merchantpaymentservice.GetMerchantPaymentGetById(id);

            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
		/// Save MerchantPayment
		/// </summary>
		/// <param name="model"></param>
		[HttpPost("save")]
        public async Task<BaseApiResponse> SaveMerchantPayment(MerchantPaymentRequestModel model)
        {
            BaseApiResponse response = new BaseApiResponse();

            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            tokenModel.UserId = Guid.NewGuid();
            var result = await _merchantpaymentservice.SaveMerchantPayment(model, tokenModel.UserId.ToString(),tokenModel.ClientId.ToString());

            if (result.IsSuccess == Status.Success)
            {
                response.Message = ErrorMessage.MerchantPaymentAddSuccess;
                response.Success = true;
            }
            else if (result.IsSuccess == Status.Updated)
            {
                response.Message = ErrorMessage.MerchantPaymentUpdateSuccess;
                response.Success = true;
            }
            else if (result.IsSuccess == Status.Failed)
            {
                response.Message = ErrorMessage.SomethingWentWrong;
                response.Success = false;
            }
            return response;          
        }

        /// <summary>
		/// Delete tbl_MerchantPayment By Id 
		/// </summary>
		/// <param name="id"></param>
		[HttpDelete("delete/{id}")]
        public async Task<BaseApiResponse> DeletetMerchantPayment(string id)
        {
            BaseApiResponse response = new BaseApiResponse();
            var result = await _merchantpaymentservice.DeleteMerchantPayment(id);

            response.Message = result.Result;
            if (result.IsSuccess == Status.Success)
            {
                response.Message = ErrorMessage.MerchantPaymentDeleteSuccess;
                response.Success = true;
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
