using ConstructionAPI.Common.Enum;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Person;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.Persons;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/person")]
    [ApiController]
    //[Authorize]
    public class PersonController : ControllerBase
    {
        #region Fields
        private readonly IPersonService _personsService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        #endregion

        #region Constructor
        public PersonController(IPersonService personsService, IHttpContextAccessor httpContextAccessor, IJWTAuthenticationService jwtAuthenticationService)
        {
            _personsService = personsService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jwtAuthenticationService;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Get tbl_Persons List 
        /// </summary>
        /// <param name="model"></param>
        [HttpPost("list")]
        public async Task<ApiResponse<PersonResponseModel>> GetPersonList(PersonRequestFilterModel model)
        {
            ApiResponse<PersonResponseModel> response = new ApiResponse<PersonResponseModel> { Data = new List<PersonResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _personsService.GetPersonList(model, tokenModel.ClientId);

            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
        /// Get tbl_Persons List 
        /// </summary>
        /// <param name="model"></param>
        [HttpPost("attendant-list")]
        public async Task<ApiResponse<PersonResponseModel>> GetAttendedPersonList(PersonAttedanceRequestFilterModel model)
        {
            ApiResponse<PersonResponseModel> response = new ApiResponse<PersonResponseModel> { Data = new List<PersonResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _personsService.GetAttendancePersonList(model, tokenModel.ClientId);

            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        /// <summary>
        /// Get Person List For Dropdown
        /// </summary>
        /// <param name="model"></param>
        [HttpGet("dropdown-list/{id}")]
        public async Task<ApiResponse<PersonDropDownModel>> GetPersonListForDropDown(string? id)
        {
            try
            {
                ApiResponse<PersonDropDownModel> response = new ApiResponse<PersonDropDownModel> { Data = new List<PersonDropDownModel>() };
                TokenModel tokenModel = new TokenModel();
                string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
                if (!string.IsNullOrEmpty(jwtToken))
                {
                    tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
                }
                var result = await _personsService.GetPersonListForDropDown(tokenModel.ClientId, id == "null" ? "" : id);

                if (result != null)
                {
                    response.Data = result;
                }
                response.Success = true;
                response.Message = ErrorMessage.Success;
                return response;
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        /// <summary>
		/// tbl_Persons By Id 
		/// </summary>
		/// <param name="id"></param>
		[HttpGet("{id}")]
        public async Task<ApiPostResponse<PersonResponseModel>> GetPersonById(string id)
        {
            ApiPostResponse<PersonResponseModel> response = new ApiPostResponse<PersonResponseModel>();
            var personGuid = new Guid(id);
            var result = await _personsService.GetPersonById(personGuid);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
        /// Save tbl_Persons
        /// </summary>
        /// <param name="model"></param>
        [HttpPost("save")]
        public async Task<BaseApiResponse> SavePersons(PersonRequestModel model)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }

            var result = await _personsService.SavePerson(model, tokenModel.ClientId, tokenModel.UserId.ToString());

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
		/// Delete tbl_Persons By Id 
		/// </summary>
		/// <param name="id"></param>
		[HttpDelete("delete/{id}")]
        public async Task<ApiPostResponse<int>> DeletePerson(string id)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var personGuid = new Guid(id);
            var result = await _personsService.DeletePersons(personGuid, tokenModel.UserId);
            if (result == 1)
            {
                response.Message = ErrorMessage.PersonDeleteSuccess;
                response.Success = true;
            }
            else if(result == 7)
            {
                response.Message = ErrorMessage.PersonAlreadyBeingUsed;
                response.Success = false;
            }
            else
            {
                response.Message = ErrorMessage.PersonDeleteError;
                response.Success = false;
            }
            return response;
        }

        /// <summary>
        /// Get Active person type List 
        /// </summary>        
        [HttpGet("persontype-list")]
        public async Task<ApiResponse<PersonTypeResponseModel>> GetPersonTypeList()
        {
            var response = new ApiResponse<PersonTypeResponseModel> { Data = new List<PersonTypeResponseModel>(), Success = false };

            var result = await _personsService.GetPersonTypeList();
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpPost("active-inactive")]
        public async Task<BaseApiResponse> ActiveDeactivePerson(CommonActiveModel model)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
                model.UserId = tokenModel.UserId;
            }
            var result = await _personsService.ActiveInactivePerson(model);
            if (result == 1)
            {
                if (model.IsActive == false)
                {
                    response.Message = ErrorMessage.PersonDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.PersonActivated;
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

        [HttpPost("attendant-save")]
        public async Task<BaseApiResponse> SaveAttendantPersons(AttendantPersonRequestModel model)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }

            var result = await _personsService.SaveAttendantPerson(model, tokenModel.ClientId, tokenModel.UserId.ToString());

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

        #endregion
    }
}
