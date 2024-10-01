using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Model.VehicleRent;
using ConstructionAPI.Service.Expense;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.Site;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using OfficeOpenXml.Style;
using OfficeOpenXml;
using System.Data;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/expense")]
    [ApiController]
    [Authorize]
    public class ExpenseController : ControllerBase
    {
        private readonly IExpenseService _expenseService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;


        public ExpenseController(IExpenseService expenseService, IHttpContextAccessor contextAccessor, IJWTAuthenticationService jWTAuthenticationService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _expenseService = expenseService;
            _httpContextAccessor = contextAccessor;
            _jwtAuthenticationService = jWTAuthenticationService;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }

        [HttpGet("expense-type-list")]
        public async Task<ApiResponse<ExpenseTypeResponseModel>> GetExpenseTypeList()
        {
            ApiResponse<ExpenseTypeResponseModel> response = new ApiResponse<ExpenseTypeResponseModel>() { Data = new List<ExpenseTypeResponseModel>() };
            var result = await _expenseService.GetExpenseTypeList();
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpPost("list")]
        public async Task<ApiResponse<ExpenseResponseModel>> GetExpenseList(ExpensePaginationModel model)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiResponse<ExpenseResponseModel> response = new ApiResponse<ExpenseResponseModel>() { Data = new List<ExpenseResponseModel>() };
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _expenseService.GetExpenseList(model, tokenModel.ClientId);
            if (result != null)
            {
                for (var i = 0; i < result.Count; i++)
                {
                    result[i].ExpenseFile = result[i].ExpenseFile != null ? PathValue + _config["Path:ExpenseImagePath"] + '/' + result[i].ExpenseFile : null;
                }
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }


        [HttpDelete("delete/{expenseId}")]
        public async Task<ApiPostResponse<int>> DeleteExpense(string expenseId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var expenseIdGuid = new Guid(expenseId);
            var result = await _expenseService.DeleteExpense(expenseIdGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.ExpenseDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ExpenseDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{expenseId}")]
        public async Task<ApiPostResponse<ExpenseResponseModel>> GetExpenseById(string expenseId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiPostResponse<ExpenseResponseModel> response = new ApiPostResponse<ExpenseResponseModel>();
            var expenseGuid = new Guid(expenseId);
            var result = await _expenseService.GetExpenseById(expenseGuid);
            if (result != null)
            {
                if(result.ExpenseFile != null)
                {
                    result.ExpenseFile = PathValue+ _config["Path:ExpenseImagePath"]+'/' + result.ExpenseFile;
                }
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> AddUpdateExpense([FromForm] ExpenseRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            if (model.ExpenseFile != null)
            {
                var path = _hostingEnvironment.WebRootPath + _config["Path:ExpenseImagePath"];
                model.ExpenseFileName = model.ExpenseFile.FileName;
                model.ExpenseNewFileName = await CommonMethod.UploadImage(model.ExpenseFile, path);
            }
           var result = await _expenseService.SaveExpense(model, tokenModel.UserId, new Guid(tokenModel.ClientId));
            if (result > 0)
            {
                response.Message = ErrorMessage.ExpenseUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.ExpenseAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.ExpenseAddEditError;
                response.Success = false;
            }
            return response;
        }


        [HttpGet("active-inactive/{expenseId}")]
        public async Task<BaseApiResponse> ActiveDeactiveUserByAdmin(string expenseId)
        {
            BaseApiResponse response = new BaseApiResponse();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _expenseService.ActiveInactiveExpense(expenseId, tokenModel.UserId);
            if (result != null)
            {
                if (result.IsActive == false)
                {
                    response.Message = ErrorMessage.ExpenseDeactivated;
                    response.Success = true;
                }
                else
                {
                    response.Message = ErrorMessage.ExpenseActivated;
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
        public async Task<IActionResult> ExportExcel(ExpenseExportRequestModel model)
        {
            int rowCount = 5;
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _expenseService.GetExpenseListForExport(model,tokenModel.ClientId);
            DataTable datatable = new DataTable();
            datatable.Columns.Add("Date");
            datatable.Columns.Add("Expense Type");
            datatable.Columns.Add("Amount");
            datatable.Columns.Add("Description");
            datatable.Columns.Add("Site Name");

            if (result != null)
            {
                foreach (var item in result)
                {
                    rowCount++;
                    DataRow dr = datatable.NewRow();
                    dr["Date"] = item.ExpenseDate.ToString("dd/MM/yyyy");
                    dr["Expense Type"] = item.ExpenseType;
                    dr["Amount"] = item.Amount;
                    dr["Description"] = item.Description;
                    dr["Site Name"] = item.SiteName;
                    datatable.Rows.Add(dr);
                }

                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
                var stream = new MemoryStream();
                using (var package = new ExcelPackage(stream))
                {
                    var worksheet = package.Workbook.Worksheets.Add("Expense List");

                    // Load data into Excel worksheet, adjust column range to exclude the last blank column
                    worksheet.Cells[5, 2, 5, 6].LoadFromDataTable(datatable, true);

                    // Apply borders to the loaded data range
                    var borderRange = worksheet.Cells[5, 2, rowCount, 6]; // Adjusted to exclude the last blank column
                    borderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    borderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                    // Apply borders and styles to the title range
                    var titleBorderRange = worksheet.Cells[2, 2, 3, 6]; // Adjusted to exclude the last blank column
                    titleBorderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    titleBorderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                    // Merge cells for title
                    int startRow = 2;
                    int endRow = 3;
                    int startColumn = 2;
                    int endColumn = 6; // Adjusted to exclude the last blank column

                    string mergeRange = $"{worksheet.Cells[startRow, startColumn, endRow, endColumn].Address}";
                    worksheet.Cells[mergeRange].Merge = true;
                    worksheet.Cells[mergeRange].Value = "Expense List";
                    worksheet.Cells[mergeRange].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells[mergeRange].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                    worksheet.Cells[mergeRange].Style.Font.Size = 14;
                    worksheet.Cells[mergeRange].Style.Font.Bold = true;
                    worksheet.Cells[mergeRange].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    worksheet.Cells[mergeRange].Style.Fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#DCDCDC"));

                    // Apply additional styles
                    worksheet.Cells[5, 2, 5, 6].Style.Font.Bold = true;
                    worksheet.Cells[5, 2, 5, 6].Style.Font.Size = 12;
                    worksheet.Cells[5, 2, 5, 6].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    worksheet.Cells[5, 2, 5, 6].Style.Fill.BackgroundColor.SetColor(System.Drawing.ColorTranslator.FromHtml("#DCDCDC"));
                    worksheet.Cells.AutoFitColumns();

                    package.Save();
                }

                stream.Position = 0;
                string excelname = $"Expense-List.xlsx";
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", excelname);
            }
            else
            {
                return NoContent();
            }
        }

        [HttpPost("export-pdf")]
        public async Task<IActionResult> ExportExpenseListPDF([FromBody] ExpenseExportRequestModel model)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _expenseService.GetExpenseListForExport(model,tokenModel.ClientId);

            if (result != null)
            {
                var Path = _hostingEnvironment.WebRootPath + _config["PdfTemplate:ExpenseTemplate"];
                var pdf = _expenseService.GenerateExpenseListPdf(result, Path);
                return File(pdf, "application/pdf", "Vehicle-Rent-List.pdf");
            }
            else
            {
                return NoContent();
            }
        }
    }
}