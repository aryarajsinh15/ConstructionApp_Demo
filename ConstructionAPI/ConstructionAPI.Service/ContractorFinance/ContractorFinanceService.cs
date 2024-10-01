using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Repository.Repository.Client;
using ConstructionAPI.Repository.Repository.NewFolder;
using DinkToPdf.Contracts;
using DinkToPdf;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ConstructionAPI.Model.SiteBill;
using ConstructionAPI.Model.VehicleRent;

namespace ConstructionAPI.Service.ContractorFinance
{
    public class ContractorFinanceService : IContractorFinanceService
    {

        #region Fields
        private readonly IContractorFinanceRepository _repository;
        private readonly IConverter _converter;

        #endregion

        #region Construtor
        public ContractorFinanceService(IContractorFinanceRepository repository, IConverter converter)
        {
            _repository = repository;
            _converter = converter;
        }
        #endregion

        public async Task<long> DeleteContractorFinance(Guid contractorFinanceId, Guid userId)
        {
            return await _repository.DeleteContractorFinance(contractorFinanceId, userId);
        }

        public async Task<ContractorFinanceResponseModel> GetContractorFinanceById(Guid contractorFinanceId)
        {
            return await _repository.GetContractorFinanceById(contractorFinanceId);
        }

        public async Task<List<ContractorFinanceListResponseModel>> GetContractorFinanceList(ContractorFinanceListRequestModel model)
        {
            return await _repository.GetContractorFinanceList(model);
        }

        public async Task<List<ContractorFinanceListResponseModel>> GetContractorFinanceListForExport(string siteId)
        {
            return await _repository.GetContractorFinanceListForExport(siteId);
        }

        public async Task<long> SaveContractorFinance(ContractorFinanceRequestModel model, Guid userId)
        {
            return await _repository.SaveContractorFinance(model, userId);
        }
        //public byte[] GenerateContractorFincancePdf(List<ContractorFinanceListResponseModel> list, string path)
        //{
        //    var htmlTemplate = System.IO.File.ReadAllText(path);
        //    var htmlContent = GenereateHTMLContent(htmlTemplate, list);

        //    var doc = new HtmlToPdfDocument()
        //    {
        //        GlobalSettings = {
        //        ColorMode = ColorMode.Color,
        //        Orientation = Orientation.Portrait,
        //        PaperSize = PaperKind.A4
        //    },
        //        Objects = {
        //        new ObjectSettings() {
        //            PagesCount = true,
        //            HtmlContent = htmlContent,
        //            WebSettings = { DefaultEncoding = "utf-8" },
        //            HeaderSettings = { FontName = "Arial", FontSize = 9 },
        //            FooterSettings = { FontName = "Arial", FontSize = 9 }
        //        }
        //        }
        //    };

        //    return _converter.Convert(doc);
        //}
        //private string GenereateHTMLContent(string htmlTemplate, List<ContractorFinanceListResponseModel> list)
        //{
        //    var sb = new StringBuilder(htmlTemplate);
        //    sb.Replace("{{siteName}}", list[0].SiteName);

        //    // Add more replacements as necessary for the items and itemDetails

        //    // For the items and itemDetails, you can use a loop and string interpolation to build the HTML

        //    var itemsHtml = new StringBuilder();
        //    for (int i = 0; i < list.Count; i++)
        //    {

        //        itemsHtml.Append($"<tr><td rowspan=''>{i + 1}.</td>");
        //        itemsHtml.Append($"<td>{list[i].SelectedDate.ToString("dd/MM/yyyy")}</td>");
        //        itemsHtml.Append($"<td>{list[i].Amount}</td>");
        //        itemsHtml.Append($"<td>{list[i].PaymentType}</td>");
        //        itemsHtml.Append($"<td>{list[i].ChequeNo}</td>");
        //        itemsHtml.Append($"<td>{list[i].BankName}</td>");
        //        itemsHtml.Append($"<td>{list[i].ChequeFor}</td>");
        //        itemsHtml.Append($"<td>{list[i].UserName}</td>");
        //        itemsHtml.Append($"<td>{list[i].Remarks}</td>");
        //        itemsHtml.Append("</tr>");
        //    }

        //    sb.Replace("{{tableBody}}", itemsHtml.ToString());

        //    return sb.ToString();
        //}

        public byte[] GenerateContractorFincancePdf(List<ContractorFinanceListResponseModel> list, string path)
        {
            var htmlTemplate = System.IO.File.ReadAllText(path);
            var htmlContent = GenerateHTMLContent(htmlTemplate, list);

            var doc = new HtmlToPdfDocument()
            {
                GlobalSettings = {
                    ColorMode = ColorMode.Color,
                    Orientation = Orientation.Portrait,
                    PaperSize = PaperKind.A4
                },
                Objects = {
                    new ObjectSettings() {
                        PagesCount = true,
                        HtmlContent = htmlContent,
                        WebSettings = { DefaultEncoding = "utf-8" },
                        HeaderSettings = { FontName = "Noto Sans", FontSize = 9 },
                        FooterSettings = { FontName = "Noto Sans", FontSize = 9 },
                    }
                }
            };
            return _converter.Convert(doc);
        }

        private string GenerateHTMLContent(string htmlTemplate, List<ContractorFinanceListResponseModel> list)
        {
            var sb = new StringBuilder(htmlTemplate);
            sb.Replace("{{siteName}}", list[0].SiteName);
            var itemsHtml = new StringBuilder();
            for (int i = 0; i < list.Count; i++)
            {
                itemsHtml.Append($"<tr><td>{i + 1}.</td>");
                itemsHtml.Append($"<td>{list[i].SelectedDate.ToString("dd/MM/yyyy")}</td>");
                itemsHtml.Append($"<td>{list[i].Amount}</td>");
                itemsHtml.Append($"<td>{list[i].PaymentType}</td>");
                itemsHtml.Append($"<td>{list[i].ChequeNo}</td>");
                itemsHtml.Append($"<td>{list[i].BankName}</td>");
                itemsHtml.Append($"<td>{list[i].ChequeFor}</td>");
                itemsHtml.Append($"<td class='{(IsGujarati(list[i].UserName) ? "gujarati" : "")}'>{list[i].UserName}</td>");
                itemsHtml.Append($"<td class='{(IsGujarati(list[i].Remarks) ? "gujarati" : "")}'>{list[i].Remarks}</td>");
                itemsHtml.Append("</tr>");
            }
            sb.Replace("{{tableBody}}", itemsHtml.ToString());
            return sb.ToString();
        }

        private bool IsGujarati(string text)
        {
            return text.Any(c => c >= '\u0A80' && c <= '\u0AFF');
        }
    }
}
