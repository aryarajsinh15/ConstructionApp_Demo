using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.PersonAttendance;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.PersonAttendance;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/person-attendance")]
    [ApiController]
    [Authorize]
    public class PersonAttendanceController : ControllerBase
    {
        #region Fields
        private readonly IPersonAttendanceService _personAttendanceService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        #endregion

        #region Constructor
        public PersonAttendanceController(IPersonAttendanceService personAttendanceService,
            IHttpContextAccessor httpContextAccessor,
            IJWTAuthenticationService jwtAuthenticationService)
        {
            _personAttendanceService = personAttendanceService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jwtAuthenticationService;
        }
        #endregion

        #region Methods
        [HttpPost("save")]
        public async Task<BaseApiResponse> SavePersonAttendance(PersonAttendanceRequestModel model)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
                model.LoggedId = tokenModel.UserId;
                model.ClientId = tokenModel.ClientId;
            }

            var result = await _personAttendanceService.SavePersonAttendance(model);
            if (result == 1)
            {
                response.Success = true;
                response.Message = ErrorMessage.SavePersonAttendanceSuccess;
            }
            else if (result == 2)
            {
                response.Success = true;
                response.Message = ErrorMessage.UpdatePersonAttendanceSuccess;
            }
            else if (result == 0)
            {
                response.Success = false;
                response.Message = ErrorMessage.PersonAttendanceExists;
            }
            else
            {
                response.Success = false;
                response.Message = ErrorMessage.SomethingWentWrong;
            }
            return response;
        }

        [HttpPost("list")]
        public async Task<ApiResponse<PersonAttendanceResponseModel>> PersonAttendanceList(PersonAttendancePagationModel model)
        {
            ApiResponse<PersonAttendanceResponseModel> response = new ApiResponse<PersonAttendanceResponseModel> { Data = new List<PersonAttendanceResponseModel>() };
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            TokenModel tokenModel = new TokenModel();
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
                model.ClientId = tokenModel.ClientId;
            }
            var result = await _personAttendanceService.PersonAttendanceList(model);

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

        [HttpDelete("delete/{attendanceId}")]
        public async Task<BaseApiResponse> DeletePersonAttendance(string attendanceId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _personAttendanceService.DeletePersonAttendance(attendanceId, tokenModel.UserId);

            if (result == 1)
            {
                response.Success = true;
                response.Message = ErrorMessage.PersonAttendanceDeleteSuccess;
            }
            else
            {
                response.Success = false;
                response.Message = ErrorMessage.SomethingWentWrong;
            }
            return response;
        }

        [HttpGet("detail/{attendanceId}")]
        public async Task<ApiPostResponse<PersonAttendanceByIdRequestModel>> GetPersonAttendanceById(string attendanceId)
        {
            ApiPostResponse<PersonAttendanceByIdRequestModel> response = new ApiPostResponse<PersonAttendanceByIdRequestModel>();
            var result = await _personAttendanceService.GetPersonAttendanceById(attendanceId);
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

        [HttpPost("attendance-by-person")]
        public async Task<ApiResponse<AttendanceByPersonResponseModel>> GetAttendanceByPersonId(AttendanceByPersonRequestModel model )
        {
            ApiResponse<AttendanceByPersonResponseModel> response = new ApiResponse<AttendanceByPersonResponseModel> { Data = new List<AttendanceByPersonResponseModel>() };
            var result = await _personAttendanceService.GetAttendanceByPersonId(model);
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
        #endregion
    }
}
