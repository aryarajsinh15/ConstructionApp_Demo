using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.ContractorFinance;
using ConstructionAPI.Service.JWTAuthentication;
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

namespace ConstructionAPI.Area.Admin
{
    [Route("api/contractor-finance")]
    [ApiController]
    [Authorize]
    public class ContractorFinanceController : ControllerBase
    {
        public readonly IContractorFinanceService _contractorFinanceService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;


        public ContractorFinanceController(IContractorFinanceService contractorFinanceService, IHttpContextAccessor httpContextAccessor, IJWTAuthenticationService jWTAuthenticationService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _contractorFinanceService = contractorFinanceService;
            _httpContextAccessor = httpContextAccessor;
            _jwtAuthenticationService = jWTAuthenticationService;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }

        [HttpPost("list")]
        public async Task<ApiResponse<ContractorFinanceListResponseModel>> GetContractorFinanceList(ContractorFinanceListRequestModel model)
        {
            ApiResponse<ContractorFinanceListResponseModel> response = new ApiResponse<ContractorFinanceListResponseModel>() { Data = new List<ContractorFinanceListResponseModel>() };
            var result = await _contractorFinanceService.GetContractorFinanceList(model);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpDelete("delete/{contractorFinanceId}")]
        public async Task<ApiPostResponse<int>> DeleteContractorFinance(string contractorFinanceId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var contractorFinanceGuid = new Guid(contractorFinanceId);
            var result = await _contractorFinanceService.DeleteContractorFinance(contractorFinanceGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.ContractorFinaceDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ContractorFinaceDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{contractorFinanceId}")]
        public async Task<ApiPostResponse<ContractorFinanceResponseModel>> GetContractorFinanceById(string contractorFinanceId)
        {
            ApiPostResponse<ContractorFinanceResponseModel> response = new ApiPostResponse<ContractorFinanceResponseModel>();
            var contractorFinanceGuid = new Guid(contractorFinanceId);
            var result = await _contractorFinanceService.GetContractorFinanceById(contractorFinanceGuid);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> AddUpdateContractorFinance([FromBody] ContractorFinanceRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            model.CreditOrDebit = "Credit";
            var result = await _contractorFinanceService.SaveContractorFinance(model, tokenModel.UserId);
            if (result == 1)
            {
                response.Message = ErrorMessage.ContractorFinaceUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.ContractorFinaceAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ContractorFinaceAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("export-excel/{siteId}")]
        public async Task<IActionResult> ExportExcel(string siteId)
        {
            int rowCount = 5;
            decimal? total = 0;
            var result = await _contractorFinanceService.GetContractorFinanceListForExport(siteId);
            if (result != null)
            {
                total = result.FirstOrDefault().TotalAmount;
            }
            DataTable datatable = new DataTable();
            datatable.Columns.Add("Date");
            datatable.Columns.Add("Amount");
            datatable.Columns.Add("Payment Type");
            datatable.Columns.Add("Cheque No.");
            datatable.Columns.Add("Bank Name");
            datatable.Columns.Add("Cheque For");
            datatable.Columns.Add("User Name");
            datatable.Columns.Add("Remarks");

            if (result != null)
            {
                foreach (var item in result)
                {
                    rowCount++;
                    DataRow dr = datatable.NewRow();
                    dr["Date"] = item.SelectedDate.ToString("dd/MM/yyyy");
                    dr["Amount"] = item.Amount;
                    dr["Payment Type"] = item.PaymentType;
                    dr["Cheque No."] = item.ChequeNo;
                    dr["Bank Name"] = item.BankName;
                    dr["Cheque For"] = item.ChequeFor;
                    dr["User Name"] = item.UserName;
                    dr["Remarks"] = item.Remarks;
                    datatable.Rows.Add(dr);
                }

                // Add total row
                DataRow totalRow = datatable.NewRow();
                totalRow["Amount"] = total;
                datatable.Rows.Add(totalRow);
                rowCount++;

                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
                var stream = new MemoryStream();
                using (var package = new ExcelPackage(stream))
                {
                    var worksheet = package.Workbook.Worksheets.Add("Site Payment");
                    worksheet.Cells[5, 2, 5, 9].LoadFromDataTable(datatable, true);
                    worksheet.Cells[2, 2].Value = "Site Payment - " + result[0].SiteName;

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

                    // Apply bold style to the total amount row
                    worksheet.Cells[rowCount, 3].Style.Font.Bold = true;

                    worksheet.Cells.AutoFitColumns();
                    package.Save();
                }

                stream.Position = 0;
                string excelname = $"{result[0].SiteName}-Site-Payment-List.xlsx";
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", excelname);
            }
            else
            {
                return NoContent();
            }
        }

        [HttpGet("export-pdf/{siteId}")]
        public async Task<IActionResult> ExportContractFincacePDF(string siteId)
        {
            var result = await _contractorFinanceService.GetContractorFinanceListForExport(siteId);

            if (result != null)
            {
                var Path = _hostingEnvironment.WebRootPath + _config["PdfTemplate:SiteCreditTemplate"];
                var pdf = _contractorFinanceService.GenerateContractorFincancePdf(result, Path);
                return File(pdf, "application/pdf", "Site Payment.pdf");

            }
            else
            {
                return NoContent();
            }

        }
    }
}
