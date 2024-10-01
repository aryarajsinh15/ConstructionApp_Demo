using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.VehicleRent;
using ConstructionAPI.Repository.Repository.Expense;
using DinkToPdf.Contracts;
using DinkToPdf;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Expense
{
    public class ExpenseService : IExpenseService
    {
        #region Fields
        private readonly IExpenseRepository _repository;
        private readonly IConverter _converter;
        #endregion

        #region Construtor
        public ExpenseService(IExpenseRepository repository, IConverter converter)
        {
            _repository = repository;
            _converter = converter;
        }
        #endregion

        public async Task<ExpenseResponseModel> ActiveInactiveExpense(string expenseId, Guid userId)
        {
            return await _repository.ActiveInactiveExpense(expenseId, userId);
        }

        public async Task<long> DeleteExpense(System.Guid expenseId, System.Guid userId)
        {
            return await _repository.DeleteExpense(expenseId, userId);
        }

        public async Task<ExpenseResponseModel> GetExpenseById(Guid expenseId)
        {
            return await _repository.GetExpenseById(expenseId);
        }

        public async Task<List<ExpenseResponseModel>> GetExpenseList(ExpensePaginationModel model, string clientId)
        {
            return await _repository.GetExpenseList(model, clientId);
        }

        public async Task<List<ExpenseResponseModel>> GetExpenseListForExport(ExpenseExportRequestModel model,string clientId)
        {
            return await _repository.GetExpenseListForExport(model,clientId);
        }

        public async Task<List<ExpenseTypeResponseModel>> GetExpenseTypeList()
        {
            return await _repository.GetExpenseTypeList();
        }

        public async Task<long> SaveExpense(ExpenseRequestModel model, Guid userId, Guid clientId)
        {
            return await _repository.SaveExpense(model, userId, clientId);
        }

        public byte[] GenerateExpenseListPdf(List<ExpenseResponseModel> model, string path)
        {
            var htmlTemplate = System.IO.File.ReadAllText(path);
            var htmlContent = GenerateHTMLContent(htmlTemplate, model);

            var doc = new HtmlToPdfDocument()
            {
                GlobalSettings = {
                    ColorMode = ColorMode.Color,
                    Orientation = Orientation.Portrait,
                    PaperSize = PaperKind.A4,
                    DocumentTitle = "Expense List"
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

        private string GenerateHTMLContent(string htmlTemplate, List<ExpenseResponseModel> list)
        {
            var sb = new StringBuilder(htmlTemplate);
            sb.Replace("{{ExpenseList}}", "Expense List");
            var itemsHtml = new StringBuilder();
            for (int i = 0; i < list.Count; i++)
            {
                itemsHtml.Append($"<tr><td>{i + 1}.</td>");
                itemsHtml.Append($"<td>{list[i].ExpenseDate.ToString("dd/MM/yyyy")}</td>");
                itemsHtml.Append($"<td> {list[i].ExpenseType}</td>");
                itemsHtml.Append($"<td> {list[i].Amount}</td>");
                itemsHtml.Append($"<td class='{(IsGujarati(list[i].Description) ? "gujarati" : "")}'>{list[i].Description}</td>");
                itemsHtml.Append($"<td class='{(IsGujarati(list[i].SiteName) ? "gujarati" : "")}'>{list[i].SiteName}</td>");
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
