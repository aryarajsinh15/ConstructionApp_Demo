using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.PersonFinance;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.ContractorFinance;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.PersonFinance;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.ComponentModel;
using System.Data;
using LicenseContext = OfficeOpenXml.LicenseContext;

namespace PersonFinance.Area.Admin
{
    [Route("api/person-finance")]
    [ApiController]
    [Authorize]
    public class PersonFinanceController : ControllerBase
    {
        public readonly IPersonFinanceService _personFinanceService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;

        public PersonFinanceController(IPersonFinanceService personFinanceService, IHttpContextAccessor httpContextAccessor, IJWTAuthenticationService jWTAuthenticationService)
        {
            _personFinanceService = personFinanceService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jWTAuthenticationService;
        }

        [HttpPost("list")]
        public async Task<ApiResponse<PersonFinanceListResponseModel>> GetPersonFinanceList(PersonFinanceListRequestModel model)
        {
            ApiResponse<PersonFinanceListResponseModel> response = new ApiResponse<PersonFinanceListResponseModel>() { Data = new List<PersonFinanceListResponseModel>() };
            var result = await _personFinanceService.GetPersonFinanceList(model);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpDelete("delete/{personfinanceId}")]
        public async Task<ApiPostResponse<int>> DeletePersonFinance(string personfinanceId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var personfinanceIdGuid = new Guid(personfinanceId);
            var result = await _personFinanceService.DeletePersonFinance(personfinanceIdGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.PersonFinaceDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.PersonFinaceDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{personfinanceId}")]
        public async Task<ApiPostResponse<PersonFinanceResponseModel>> GetPersonFinanceById(string personFinanceId)
        {
            ApiPostResponse<PersonFinanceResponseModel> response = new ApiPostResponse<PersonFinanceResponseModel>();
            var personFinanceIdGuid = new Guid(personFinanceId);
            var result = await _personFinanceService.GetPersonFinanceById(personFinanceIdGuid);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> AddUpdatePersonFinance([FromBody] PersonFinanceRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            model.CreditOrDebit = "Credit";
            var result = await _personFinanceService.SavePersonFinance(model, tokenModel.UserId);
            if (result == 1)
            {
                response.Message = ErrorMessage.PersonFinaceUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.PersonFinaceAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.PersonFinaceAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("export-excel/{personfinanceId}")]
        public async Task<IActionResult> ExportExcel(string personfinanceId)
        {
            int rowCount = 5;
            var result = await _personFinanceService.GetPersonFinanceListForExport(personfinanceId);
            DataTable datatable = new DataTable();
            datatable.Columns.Add("Date");
            datatable.Columns.Add("User Name");
            datatable.Columns.Add("Amount");
            datatable.Columns.Add("Payment Type");
            datatable.Columns.Add("Cheque No.");
            datatable.Columns.Add("Bank Name");
            datatable.Columns.Add("Cheque For");
            datatable.Columns.Add("Remarks");
            if (result != null)
            {
                foreach (var item in result)
                {
                    rowCount++;
                    DataRow dr = datatable.NewRow();
                    dr["Date"] = item.SelectedDate.ToString("dd/MM/yyyy");
                    dr["User Name"] = item.UserName;
                    dr["Amount"] = item.Amount;
                    dr["Payment Type"] = item.PaymentType;
                    dr["Cheque No."] = item.ChequeNo;
                    dr["Bank Name"] = item.BankName;
                    dr["Cheque For"] = item.ChequeFor;
                    dr["Remarks"] = item.Remarks;
                    datatable.Rows.Add(dr);
                }
                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
                var stream = new MemoryStream();
                using (var package = new ExcelPackage(stream))
                {
                    var worksheet = package.Workbook.Worksheets.Add("Person Payment");
                    worksheet.Cells[5, 2, 5,9].LoadFromDataTable(datatable, true);
                    worksheet.Cells[2,2].Value = "Person Payment - " + result[0].PersonName;
                    var borderRange = worksheet.Cells[5, 2, rowCount, 9];
                    borderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    var titleBorderRange = worksheet.Cells[2, 2, 3, 9];
                    titleBorderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    // Merge cells in a 2x2 range
                    int startRow = 2; // Start row number to merge
                    int endRow = 3; // End row number to merge
                    int startColumn = 2; // Start column number to merge
                    int endColumn = 9; // End column number to merge

                    string mergeRange = $"{worksheet.Cells[startRow, startColumn, endRow, endColumn].Address}";

                    // Merge the cells to create a 2x2 merged cell
                    worksheet.Cells[mergeRange].Merge = true;
                    worksheet.Cells[mergeRange].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells[mergeRange].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                    worksheet.Cells[mergeRange].Style.Font.Size = 14;
                    worksheet.Cells[mergeRange].Style.Font.Bold = true;
                    worksheet.Cells[mergeRange].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    worksheet.Cells[mergeRange].Style.Fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#DCDCDC"));
                    worksheet.Cells[5, 2, 5, 9].Style.Font.Bold = true;
                    worksheet.Cells[5, 2, 5, 9].Style.Font.Size = 12;
                    worksheet.Cells[5, 2, 5, 9].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    worksheet.Cells[5, 2, 5, 9].Style.Fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#DCDCDC"));
                    worksheet.Cells.AutoFitColumns();
                    package.Save();
                }
                stream.Position = 0;
                string excelname = $"{result[0].PersonName}-Person-Payment-List.xlsx";
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", excelname);

            }
            else
            {
                return NoContent();
            }

        }
    }
}
