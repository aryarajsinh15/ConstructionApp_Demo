using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.SiteBill;
using ConstructionAPI.Repository.Repository.Expense;
using ConstructionAPI.Repository.Repository.SiteBill;
using DinkToPdf;
using DinkToPdf.Contracts;
using iTextSharp.text;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.SiteBill
{
    public class SiteBillService : ISiteBillService
    {
        #region Fields
        private readonly ISiteBillRepository _repository;
        private readonly IConverter _converter;
        #endregion

        #region Construtor
        public SiteBillService(ISiteBillRepository repository, IConverter converter)
        {
            _repository = repository;
            _converter = converter;
        }
        #endregion


        public async Task<List<SiteBillListResponseModel>> GetSiteBillList(SiteBillListRequestModel model)
        {
            return await _repository.GetSiteBillList(model);
        }

        public async Task<long> SaveSiteBill(SiteBillRequestModel model, Guid userId)
        {
            return await _repository.SaveSiteBill(model, userId);
        }

        public async Task<long> DeleteSiteBill(Guid siteBillId, Guid userid)
        {
            return await _repository.DeleteSiteBill(siteBillId, userid);
        }

        public async Task<SiteBillResponseModel> GetSiteBillById(Guid siteBillId)
        {
            return await _repository.GetSiteBillById(siteBillId);
        }

        public async Task<long> SaveSiteBillWithoutFile(BillPaymentWithoutFileRequestModel model, Guid userId)
        {
            return await _repository.SaveSiteBillWithoutFile(model, userId);
        }

        public async Task<BillPaymentWithoutFileResponseModel> GetWithoutFileSiteBillById(Guid siteBillId)
        {
            return await _repository.GetWithoutFileSiteBillById(siteBillId) ;
        }

        public byte[] GeneratePdf(BillPaymentWithoutFileResponseModel model, string path, ClientResponseModel detail)
        {

            var htmlTemplate = System.IO.File.ReadAllText(path);
            var htmlContent = FillHtmlTemplate(htmlTemplate, model, detail);

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
                    HeaderSettings = { FontName = "Arial", FontSize = 9 },
                    FooterSettings = { FontName = "Arial", FontSize = 9 }
                }
            }
            };

            return _converter.Convert(doc);
        }




        private string FillHtmlTemplate(string htmlTemplate, BillPaymentWithoutFileResponseModel model, ClientResponseModel clientDetail)
        {
            var sb = new StringBuilder(htmlTemplate);

            sb.Replace("{{SiteName}}", model.SiteName);
            sb.Replace("{{BillDate}}", model.BillDate.ToString("dd/MM/yyyy"));
            sb.Replace("{{BillNo}}", model.BillNo);
            sb.Replace("{{Remarks}}", model.Remarks);
            if (clientDetail.HeaderImageLetterPage != null)
            {
                sb.Replace("{{headerImageReplace}}", "<img src=" + clientDetail.HeaderImageLetterPage + " class='header'>");
            }
            else
            {
                sb.Replace("{{headerImageReplace}}", "");
            }
            // Add more replacements as necessary for the items and itemDetails

            // For the items and itemDetails, you can use a loop and string interpolation to build the HTML

            var itemsHtml = new StringBuilder();
            for (int i = 0; i < model.items.Count; i++)
            {
                var item = model.items[i];
                itemsHtml.Append($"<tr><td rowspan='{item.itemDetails.Count + 2}'>{i + 1}.</td>");
                itemsHtml.Append($"<td colspan='9'><span>{item.Description}</span></td></tr>");
                foreach (var detail in item.itemDetails)
                {
                    itemsHtml.Append("<tr>");
                    itemsHtml.Append($"<td>{detail.ItemName}</td>");
                    itemsHtml.Append($"<td>{detail.Type}</td>");
                    itemsHtml.Append($"<td>{detail.Quantity}</td>");
                    itemsHtml.Append($"<td>{detail.Length}</td>");
                    itemsHtml.Append($"<td>{detail.Height}</td>");
                    itemsHtml.Append($"<td>{detail.Width}</td>");
                    itemsHtml.Append($"<td>{detail.Area}</td>");
                    itemsHtml.Append("<td></td>");
                    itemsHtml.Append("<td></td>");
                    itemsHtml.Append("</tr>");
                }
                itemsHtml.Append($"<tr><td colspan='6' style=\"text-align:right;\"><strong>Total</strong></td><td><strong>{GetItemAreaTotal(item).ToString()}</strong></td>");
                itemsHtml.Append($"<td>{item.Rate}</td>");
                itemsHtml.Append($"<td><strong>{GetTotal(item).ToString()}</strong></td></tr>");
            }

            sb.Replace("{{tableBody}}", itemsHtml.ToString());
            sb.Replace("{{getFinalTotal}}", GetFinalTotal(model).ToString());

            return sb.ToString();
        }

        private decimal GetItemAreaTotal(Items item)
        {
            // Implement your logic to calculate the total area for an item
            return Math.Round(item.itemDetails.Sum(d =>d.ItemCategory == "Less" ?  - d.Area : d.Area),2);
        }

        private decimal GetTotal(Items item)
        {
            var rate = item.Rate;
            return Math.Round((GetItemAreaTotal(item) * rate),2);
            // Implement your logic to calculate the total for an item

        }

        private string GetFinalTotal(BillPaymentWithoutFileResponseModel model)
        {
            // Implement your logic to calculate the final total
            return Math.Round(model.items.Sum(item => GetTotal(item)),2).ToString();
        }

    }
}
