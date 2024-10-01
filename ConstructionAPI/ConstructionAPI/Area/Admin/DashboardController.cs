using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Dashboard;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.Client;
using ConstructionAPI.Service.Dashboard;
using ConstructionAPI.Service.JWTAuthentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/dashboard")]
    [ApiController]
    [Authorize]
    public class DashboardController : ControllerBase
    {
        private readonly IDashboardService _dashboardService;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly IHttpContextAccessor _httpContextAccessor;


        public DashboardController(IDashboardService dashboardService, IJWTAuthenticationService jwtAuthenticationService, IHttpContextAccessor httpContextAccessor)
        {
            _dashboardService = dashboardService;
            _jwtAuthenticationService = jwtAuthenticationService;
            _httpContextAccessor = httpContextAccessor;
        }

        [HttpGet("info")]
        public async Task<ApiPostResponse<DashboardResponseModel>> GetDashboardInfo()
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<DashboardResponseModel> response = new ApiPostResponse<DashboardResponseModel>();
            var result = await _dashboardService.GetDashboardInfo(tokenModel.ClientId);
            if (result != null)
            {
                response.Success = true;
                response.Data = result;
            }
            else
            {
                response.Success = false;
                response.Message = ErrorMessage.SomethingWentWrong;
            }
            return response;
        }
    }
}