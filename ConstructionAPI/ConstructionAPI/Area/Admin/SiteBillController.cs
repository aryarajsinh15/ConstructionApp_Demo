using ConstructionAPI.Common.CommonMethod;
using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.PersonBill;
using ConstructionAPI.Model.SiteBill;
using ConstructionAPI.Model.Token;
using ConstructionAPI.Service.Client;
using ConstructionAPI.Service.Expense;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.SiteBill;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using OfficeOpenXml.Style;
using OfficeOpenXml;
using System.Drawing;
using System.IO;

namespace ConstructionAPI.Area.Admin
{
    [Route("api/site-bill")]
    [ApiController]
    [Authorize]
    public class SiteBillController : ControllerBase
    {
        private readonly ISiteBillService _siteBillService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IJWTAuthenticationService _jwtAuthenticationService;
        private readonly IClientService _clientService;
        private readonly IConfiguration _config;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;

        public SiteBillController(ISiteBillService siteBillService, IHttpContextAccessor httpContextAccessor, IConfiguration config, IJWTAuthenticationService jWTAuthenticationService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, IClientService clientService)
        {
            _siteBillService = siteBillService;
            _httpContextAccessor = httpContextAccessor;
            _config = config;
            _jwtAuthenticationService = jWTAuthenticationService;
            _hostingEnvironment = hostingEnvironment;
            _clientService = clientService;
        }


        [HttpPost("list")]
        public async Task<ApiResponse<SiteBillListResponseModel>> GetSiteBillList(SiteBillListRequestModel model)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiResponse<SiteBillListResponseModel> response = new ApiResponse<SiteBillListResponseModel>() { Data = new List<SiteBillListResponseModel>() };
            var result = await _siteBillService.GetSiteBillList(model);
            if (result != null)
            {
                for (var i = 0; i < result.Count; i++)
                {
                    result[i].SiteBillFile = result[i].SiteBillFile != null ? PathValue + _config["Path:SiteBillPath"] + '/' + result[i].SiteBillFile : null;
                }
                response.Data = result;
            }
            response.Success = true;
            response.Message = ErrorMessage.Success;
            return response;
        }

        [HttpDelete("delete/{billId}")]
        public async Task<ApiPostResponse<int>> DeleteSiteBill(string billId)
        {
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            var billIdGuid = new Guid(billId);
            var result = await _siteBillService.DeleteSiteBill(billIdGuid, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.SiteBillDeleteSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SiteBillDeleteError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("{billId}")]
        public async Task<ApiPostResponse<SiteBillResponseModel>> GetSiteBillById(string billId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            ApiPostResponse<SiteBillResponseModel> response = new ApiPostResponse<SiteBillResponseModel>();
            var billIdGuid = new Guid(billId);
            var result = await _siteBillService.GetSiteBillById(billIdGuid);
            if (result != null)
            {
                if (result.SiteBillFile != null)
                {
                    result.SiteBillFile = PathValue + _config["Path:SiteBillPath"] + '/' + result.SiteBillFile;
                }
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpPost("save")]
        public async Task<ApiPostResponse<int>> AddUpdateSiteBill([FromForm] SiteBillRequestModel model)
        {
            ApiPostResponse<int> response = new ApiPostResponse<int>();
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            if (model.SiteBillFile != null)
            {
                var path = _hostingEnvironment.WebRootPath + _config["Path:SiteBillPath"];
                model.SiteBillFileName = model.SiteBillFile.FileName;
                model.SiteBillNewFileName = await CommonMethod.UploadImage(model.SiteBillFile, path);
            }
            var result = await _siteBillService.SaveSiteBill(model, tokenModel.UserId);
            if (result > 0)
            {
                response.Message = ErrorMessage.SiteBillUpdateSuccess;
                response.Success = true;
            }
            else if (result == 0)
            {
                response.Message = ErrorMessage.SiteBillAddSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SiteBillAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpPost("without-file-save")]
        public async Task<ApiPostResponse<int>> AddUpdateSiteBillWithoutFile([FromBody] BillPaymentWithoutFileRequestModel model)
        {

            ApiPostResponse<int> response = new ApiPostResponse<int>(); 
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var result = await _siteBillService.SaveSiteBillWithoutFile(model, tokenModel.UserId);
            if (result == 0)
            {
                response.Message = ErrorMessage.SiteBillAddSuccess;
                response.Success = true;
            }
            else if (result == 1)
            {
                response.Message = ErrorMessage.SiteBillUpdateSuccess;
                response.Success = true;
            }
            else
            {
                response.Message = ErrorMessage.SiteBillAddEditError;
                response.Success = false;
            }
            return response;
        }

        [HttpGet("without-file-bill-detail/{billId}")]
        public async Task<ApiPostResponse<BillPaymentWithoutFileResponseModel>> GetWithoutFileSiteBillById(string billId)
        {
            ApiPostResponse<BillPaymentWithoutFileResponseModel> response = new ApiPostResponse<BillPaymentWithoutFileResponseModel>();
            var billIdGuid = new Guid(billId);
            var result = await _siteBillService.GetWithoutFileSiteBillById(billIdGuid);
            if (result != null)
            {
                response.Data = result;
            }
            response.Success = true;
            return response;
        }

        [HttpGet("generate/{billId}")]
        public async Task<IActionResult> GeneratePdf( string billId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            TokenModel tokenModel = new TokenModel();
            string jwtToken = _httpContextAccessor.HttpContext.Request.Headers[HeaderNames.Authorization].ToString().Replace(JwtBearerDefaults.AuthenticationScheme + " ", "");
            if (!string.IsNullOrEmpty(jwtToken))
            {
                tokenModel = _jwtAuthenticationService.GetTokenData(jwtToken);
            }
            var billIdGuid = new Guid(billId);
            var clientGuid = new Guid(tokenModel.ClientId);
            var model = await _siteBillService.GetWithoutFileSiteBillById(billIdGuid);
            var detail =await _clientService.GetClientById(clientGuid);
            if(detail.HeaderImageLetterPage != null)
            {
                detail.HeaderImageLetterPage = PathValue + _config["PdfTemplate:HeaderImagePath"] + '/' + detail.HeaderImageLetterPage;
            }
            var Path = _hostingEnvironment.WebRootPath + _config["PdfTemplate:SiteBillWithoutFileTemplate"];
            var pdf = _siteBillService.GeneratePdf(model, Path, detail);
            return File(pdf, "application/pdf", "BillPayment.pdf");
        }

        [HttpGet("generate-excel/{billId}")]
        public async Task<IActionResult> GenerateSiteBillExcel(string billId)
        {
            var PathValue = _httpContextAccessor.HttpContext.Request.Scheme + "://" + HttpContext.Request.Host.Value;
            var billIdGuid = new Guid(billId);
            
            var model = await _siteBillService.GetWithoutFileSiteBillById(billIdGuid);
         
            var Path = _hostingEnvironment.WebRootPath + _config["PdfTemplate:SiteBillWithoutFileTemplate"];
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            var stream = new MemoryStream();
            using (ExcelPackage package = new ExcelPackage(stream))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Bill Details");

                worksheet.Cells[2, 1].Value = model.SiteName;
                worksheet.Cells[2, 1,3,10].Merge = true;
                worksheet.Cells[2, 1,3,10].Style.Font.Bold = true;
                worksheet.Cells[2, 1,3,10].Style.Font.Size = 16;
                worksheet.Cells[2, 1,3,10].Style.HorizontalAlignment= ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1,3,10].Style.VerticalAlignment= ExcelVerticalAlignment.Center;
                var headerRange = worksheet.Cells[2, 1, 3, 10];
                headerRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                headerRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                headerRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                headerRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;


                int row = 5;

                // Add Bill Details
                worksheet.Cells[row, 1].Value = "Bill Date:";
                worksheet.Cells[row, 1].Style.Font.Bold = true;
                worksheet.Cells[row, 2].Value = model.BillDate.ToString("dd/MM/yyyy");
                row++;
                worksheet.Cells[row, 1].Value = "Bill Number:";
                worksheet.Cells[row, 1].Style.Font.Bold = true;
                worksheet.Cells[row, 2].Value = model.BillNo;
                row++;
                worksheet.Cells[row, 1].Value = "Remarks:";
                worksheet.Cells[row, 1].Style.Font.Bold = true;
                worksheet.Cells[row, 2].Value = model.Remarks;
                row++;
                var detailRange = worksheet.Cells[5, 1, 7, 2];
                detailRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                detailRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                detailRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                detailRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                // Add Table Headers
                row++;
                worksheet.Cells[row, 1].Value = "#";
                worksheet.Cells[row, 2].Value = "Item Name";
                worksheet.Cells[row, 3].Value = "Type";
                worksheet.Cells[row, 4].Value = "Quantity";
                worksheet.Cells[row, 5].Value = "Length";
                worksheet.Cells[row, 6].Value = "Height";
                worksheet.Cells[row, 7].Value = "Width";
                worksheet.Cells[row, 8].Value = "Area";
                worksheet.Cells[row, 9].Value = "Rate";
                worksheet.Cells[row, 10].Value = "Total";

                // Styling Table Headers
                using (var range = worksheet.Cells[row, 1, row, 10])
                {
                    range.Style.Font.Bold = true;
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    range.Style.Fill.BackgroundColor.SetColor(Color.LightGray);
                    range.Style.Border.BorderAround(ExcelBorderStyle.Thin);
                }

                // Add Item Details
                int itemIndex = 1;
                foreach (var item in model.items)
                {
                    row++;
                    worksheet.Cells[row, 1].Value = itemIndex++;
                    worksheet.Cells[row, 1, row +item.itemDetails.Count ,1].Merge = true;
                    worksheet.Cells[row, 1, row + item.itemDetails.Count, 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center ;
                    worksheet.Cells[row, 1, row + item.itemDetails.Count, 1].Style.VerticalAlignment= ExcelVerticalAlignment.Center;
                    worksheet.Cells[row, 2].Value = item.Description;
                    worksheet.Cells[row,2,row,10].Merge = true;

                    foreach (var detail in item.itemDetails)
                    {
                        row++;
                        worksheet.Cells[row, 2].Value = detail.ItemName;
                        worksheet.Cells[row, 3].Value = detail.Type;
                        worksheet.Cells[row, 4].Value = detail.Quantity;
                        worksheet.Cells[row, 5].Value = detail.Length;
                        worksheet.Cells[row, 6].Value = detail.Height;
                        worksheet.Cells[row, 7].Value = detail.Width;
                        worksheet.Cells[row, 8].Value = detail.Area;
                    }

                    // Item Total Row
                    row++;
                    worksheet.Cells[row, 1].Value = "Total";
                    worksheet.Cells[row, 1,row,7].Merge = true;
                    worksheet.Cells[row, 1,row,7].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                    worksheet.Cells[row, 9].Value = item.Rate;
                    worksheet.Cells[row, 8].Value = GetItemAreaTotal(item);
                    worksheet.Cells[row, 9].Value = item.Rate;
                    worksheet.Cells[row, 10].Value = GetTotal(item);

                    using (var range = worksheet.Cells[row, 1, row, 10])
                    {
                        range.Style.Font.Bold = true;
                        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                        range.Style.Fill.BackgroundColor.SetColor(Color.LightGray);
                        range.Style.Border.BorderAround(ExcelBorderStyle.Thin);
                    }
                }

                // Final Total Row
                row++;
                worksheet.Cells[row, 1].Value = "Final Total";
                worksheet.Cells[row, 1,row,9].Merge = true;
                worksheet.Cells[row, 1,row,9].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                worksheet.Cells[row, 10].Value = model.TotalAmount;

                using (var range = worksheet.Cells[row, 1, row, 10])
                {
                    range.Style.Font.Bold = true;
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    range.Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                    range.Style.Border.BorderAround(ExcelBorderStyle.Thin);
                }
                var borderRange = worksheet.Cells[9, 1, row, 10];
                borderRange.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                borderRange.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                borderRange.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                borderRange.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                // AutoFit columns
                worksheet.Cells[1, 1, row, 10].AutoFitColumns();

                // Save the file
                string excelName = $"BillDetails-{model.BillNo}.xlsx";
                using (var streamA = new MemoryStream())
                {
                    package.SaveAs(streamA);
                    var content = streamA.ToArray();
                    return File(content, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", excelName);
                }
            }
        }
        private decimal GetItemAreaTotal(Items item)
        {
            return Math.Round(item.itemDetails.Sum(d => d.ItemCategory == "Less" ? -d.Area : d.Area), 2);
        }

        private decimal GetTotal(Items item)
        {
            var rate = item.Rate;
            return Math.Round((GetItemAreaTotal(item) * rate), 2);
        }

        private string GetFinalTotal(BillPaymentWithoutFileResponseModel model)
        {
            return Math.Round(model.items.Sum(item => GetTotal(item)), 2).ToString();
        }
    }
    
}
