using ConstructionAPI.Common.Enum;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Model.VehicleOwner;
using ConstructionAPI.Model.VehicleRent;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.VehicalRent;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using OfficeOpenXml.Style;
using OfficeOpenXml;
using System.Data;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/vehicle-rent")]
    [ApiController]
    public class VehicleRentController : ControllerBase
    {
        #region Fields
        private readonly IVehicleRentService _vehiclerentService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;
        #endregion

        #region Constructor
        public VehicleRentController(IVehicleRentService vehicleRentService, IHttpContextAccessor httpContextAccessor
            , IJWTAuthenticationService jwtAuthenticationService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _vehiclerentService = vehicleRentService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jwtAuthenticationService;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }
        #endregion

        /// <summary>
        /// Get Vehicle Rent List 
        /// </summary>
        /// <param name="model"></param>
        [HttpPost("list")]
        public async Task<ApiResponse<VehicleRentResponseModel>> GetVehicleRentList(VehileRentListRequestModel model)
        {
            ApiResponse<VehicleRentResponseModel> response = new ApiResponse<VehicleRentResponseModel> { Data = new List<VehicleRentResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _vehiclerentService.GetVehicleRentList(model, tokenModel.ClientId);

            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }


        [HttpGet("vehicle-owner-rent")]
        public async Task<ApiResponse<VehicleOwnerListForRentModel>> GetVehicleOwnerListForRent()
        {
            ApiResponse<VehicleOwnerListForRentModel> response = new ApiResponse<VehicleOwnerListForRentModel> { Data = new List<VehicleOwnerListForRentModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _vehiclerentService.GetVehicleOwnerListForRent(tokenModel.ClientId);

            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
		/// Delete Vehicle Rent By Id 
		/// </summary>
		/// <param name="id"></param>
		[HttpGet("{vehicleRentId}")]
        public async Task<ApiPostResponse<VehicalRentResponseModel>> GetVehicleRentGetById(string vehicleRentId)
        {
            ApiPostResponse<VehicalRentResponseModel> response = new ApiPostResponse<VehicalRentResponseModel>();
            var result = await _vehiclerentService.GetVehicleRentGetById(vehicleRentId);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        /// <summary>
		/// Save VehicleRent detail
		/// </summary>
		/// <param name="model"></param>
		[HttpPost("save")]
        public async Task<BaseApiResponse> SaveVehicleRent([FromForm] VehicleRentRequestModel model)
        {
            BaseApiResponse response = new BaseApiResponse();

            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            tokenModel.UserId = Guid.NewGuid();
            var result = await _vehiclerentService.SaveVehicleRent(model, tokenModel.UserId, new Guid(tokenModel.ClientId));

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
		/// Delete Vehicle Rent By Id 
		/// </summary>
		/// <param name="id"></param>
		[HttpDelete("delete/{id}")]
        public async Task<BaseApiResponse> DeleteVehicleRent(string id)
        {
            BaseApiResponse response = new BaseApiResponse();
            var result = await _vehiclerentService.DeleteVehicleRent(id);

            response.Message = result.Result;
            if (result.IsSuccess == Status.Success)
            {
                response.Message = ErrorMessage.VehicleRentDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.VehicleRentDeleteError;
                response.Success = false;
            }
            return response;
        }

        /// <summary>
		/// Delete Vehicle Rent Active-Inactive
		/// </summary>
		/// <param name="id"></param>
        [HttpGet("active-inactive/{VehicleRentId}")]
        public async Task<BaseApiResponse> ActiveDeactiveUserByAdmin(string VehicleRentId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _vehiclerentService.ActiveInactiveVehicleRent(VehicleRentId, tokenModel.UserId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.VehicleRentDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.VehicleRentActivated;
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

        [HttpPost("export-excel")]
        public async Task<IActionResult> ExportExcel(VehicleRentExportRequestModel model)
        {
            int rowCount = 5;
            var result = await _vehiclerentService.GetVehicleRentListForExport(model);
            DataTable datatable = new DataTable();
            datatable.Columns.Add("Date");
            datatable.Columns.Add("Vehicle Owner Name");
            datatable.Columns.Add("From Location");
            datatable.Columns.Add("To Location");
            datatable.Columns.Add("Vehicle Number");
            datatable.Columns.Add("Amount");

            if (result != null)
            {
                foreach (var item in result)
                {
                    rowCount++;
                    DataRow dr = datatable.NewRow();
                    dr["Date"] = item.VehicleRentDate.ToString("dd/MM/yyyy");
                    dr["Vehicle Owner Name"] = item.VehicleOwnerName;
                    dr["From Location"] = item.FromLocation;
                    dr["To Location"] = item.ToLocation;
                    dr["Vehicle Number"] = item.VehicleNumber;
                    dr["Amount"] = item.Amount;
                    datatable.Rows.Add(dr);
                }

                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
                var stream = new MemoryStream();
                using (var package = new ExcelPackage(stream))
                {
                    var worksheet = package.Workbook.Worksheets.Add("Vehicle Rent List");
                    worksheet.Cells[5, 2, 5, 7].LoadFromDataTable(datatable, true);

                    var borderRange = worksheet.Cells[5, 2, rowCount, 7];
                    borderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                    var titleBorderRange = worksheet.Cells[2, 2, 3, 7];
                    titleBorderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                    // Merge cells in a 2x2 range
                    int startRow = 2; // Start row number to merge
                    int endRow = 3; // End row number to merge
                    int startColumn = 2; // Start column number to merge
                    int endColumn = 7; // End column number to merge

                    string mergeRange = $"{worksheet.Cells[startRow, startColumn, endRow, endColumn].Address}";

                    // Merge the cells to create a 2x2 merged cell
                    worksheet.Cells[mergeRange].Merge = true;
                    worksheet.Cells[mergeRange].Value = "Vehicle Rent List";
                    worksheet.Cells[mergeRange].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells[mergeRange].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                    worksheet.Cells[mergeRange].Style.Font.Size = 14;
                    worksheet.Cells[mergeRange].Style.Font.Bold = true;
                    worksheet.Cells[mergeRange].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    worksheet.Cells[mergeRange].Style.Fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#DCDCDC"));

                    worksheet.Cells[5, 2, 5, 7].Style.Font.Bold = true;
                    worksheet.Cells[5, 2, 5, 7].Style.Font.Size = 12;
                    worksheet.Cells[5, 2, 5, 7].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    worksheet.Cells[5, 2, 5, 7].Style.Fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#DCDCDC"));
                    worksheet.Cells.AutoFitColumns();

                    package.Save();
                }
                stream.Position = 0;
                string excelname = $"Vehicle-Rent-List.xlsx";
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", excelname);
            }
            else
            {
                return NoContent();
            }
        }

        [HttpPost("export-pdf")]
        public async Task<IActionResult> ExportVehicleRentListPDF([FromBody] VehicleRentExportRequestModel model)
        {
            var result = await _vehiclerentService.GetVehicleRentListForExport(model);

            if (result != null)
            {
                var Path = _hostingEnvironment.WebRootPath + _config["PdfTemplate:VehicleRentTemplate"];
                var pdf = _vehiclerentService.GenerateVehicleRentListPdf(result, Path);
                return File(pdf, "application/pdf", "Vehicle-Rent-List.pdf");
            }
            else
            {
                return NoContent();
            }
        }
    }
}
