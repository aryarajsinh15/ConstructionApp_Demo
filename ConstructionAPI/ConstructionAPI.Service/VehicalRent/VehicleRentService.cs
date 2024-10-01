using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Model.VehicleRent;
using ConstructionAPI.Repository.Repository.Merchant;
using ConstructionAPI.Repository.Repository.VehicalRent;
using DinkToPdf.Contracts;
using DinkToPdf;
using iTextSharp.text;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.VehicalRent
{
    public class VehicleRentService : IVehicleRentService
    {
        #region Fields
        private readonly IVehicleRentRepository _vehicleRentRepository;
        private readonly IConverter _converter;
        #endregion

        #region Constructor
        public VehicleRentService(IVehicleRentRepository _vehicleRepository, IConverter converter)
        {
            _vehicleRentRepository = _vehicleRepository;
            _converter = converter;
        }
        #endregion

        #region Methods
        public async Task<List<VehicleRentResponseModel>> GetVehicleRentList(VehileRentListRequestModel model, string clientId)
        {
            return await _vehicleRentRepository.GetVehicleRentList(model, clientId);
        }

        public async Task<List<VehicleOwnerListForRentModel>> GetVehicleOwnerListForRent(string ClientId)
        {
            return await _vehicleRentRepository.GetVehicleOwnerListForRent(ClientId);
        }

        public async Task<ResponseModel> SaveVehicleRent(VehicleRentRequestModel model, Guid id, System.Guid clientId)
        {
            return await _vehicleRentRepository.SaveVehicleRent(model, id, clientId);
        }
        public async Task<VehicalRentResponseModel> GetVehicleRentGetById(string id)
        {
            return await _vehicleRentRepository.GetVehicleRentGetById(id);
        }
        public async Task<ResponseModel> DeleteVehicleRent(string id)
        {
            return await _vehicleRentRepository.DeleteVehicleRent(id);
        }
        public async Task<VehicleRentResponseModel> ActiveInactiveVehicleRent(string VehicleRentId, Guid userId)
        {
            return await _vehicleRentRepository.ActiveInactiveVehicleRent(VehicleRentId, userId);
        }

        public async Task<List<VehicleRentResponseModel>> GetVehicleRentListForExport(VehicleRentExportRequestModel model)
        {
            return await _vehicleRentRepository.GetVehicleRentListForExport(model);
        }

        //public byte[] GenerateVehicleRentListPdf(List<VehicleRentResponseModel> model, string path)
        //{
        //    var htmlTemplate = System.IO.File.ReadAllText(path);
        //    var htmlContent = GenereateHTMLContent(htmlTemplate, model);

        //    var doc = new HtmlToPdfDocument()
        //    {
        //        GlobalSettings = {
        //        ColorMode = ColorMode.Color,
        //        Orientation = Orientation.Portrait,
        //        PaperSize = PaperKind.A4
        //    },
        //        Objects = {
        //            new ObjectSettings() {
        //                 PagesCount = true,
        //                 HtmlContent = htmlContent,
        //                 WebSettings = { DefaultEncoding = "utf-8" },
        //                 HeaderSettings = { FontName = "Arial", FontSize = 9 },
        //                 FooterSettings = { FontName = "Arial", FontSize = 9 }
        //            }
        //        }
        //    };
        //    return _converter.Convert(doc);
        //}

        //private string GenereateHTMLContent(string htmlTemplate, List<VehicleRentResponseModel> list)
        //{
        //    var sb = new StringBuilder(htmlTemplate);
        //    sb.Replace("{{VehicleRentList}}", "Vehicle Rent List");
        //    var itemsHtml = new StringBuilder();
        //    for (int i = 0; i < list.Count; i++)
        //    {
        //        itemsHtml.Append($"<tr><td rowspan=''>{i + 1}.</td>");
        //        itemsHtml.Append($"<td>{list[i].VehicleRentDate.ToString("dd/MM/yyyy")}</td>");
        //        itemsHtml.Append($"<td>{list[i].VehicleOwnerName}</td>");
        //        itemsHtml.Append($"<td>{list[i].FromLocation}</td>");
        //        itemsHtml.Append($"<td>{list[i].ToLocation}</td>");
        //        itemsHtml.Append($"<td>{list[i].VehicleNumber}</td>");
        //        itemsHtml.Append($"<td>{list[i].Amount}</td>");
        //        itemsHtml.Append("</tr>");
        //    }

        //    sb.Replace("{{tableBody}}", itemsHtml.ToString());

        //    return sb.ToString();
        //}

        public byte[] GenerateVehicleRentListPdf(List<VehicleRentResponseModel> model, string path)
        {
            var htmlTemplate = System.IO.File.ReadAllText(path);
            var htmlContent = GenerateHTMLContent(htmlTemplate, model);

            var doc = new HtmlToPdfDocument()
            {
                GlobalSettings = {
                    ColorMode = ColorMode.Color,
                    Orientation = Orientation.Portrait,
                    PaperSize = PaperKind.A4,
                    DocumentTitle = "Vehicle Rent List"
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

        private string GenerateHTMLContent(string htmlTemplate, List<VehicleRentResponseModel> list)
        {
            var sb = new StringBuilder(htmlTemplate);
            sb.Replace("{{VehicleRentList}}", "Vehicle Rent List");
            var itemsHtml = new StringBuilder();
            for (int i = 0; i < list.Count; i++)
            {
                itemsHtml.Append($"<tr><td>{i + 1}.</td>");
                itemsHtml.Append($"<td>{list[i].VehicleRentDate.ToString("dd/MM/yyyy")}</td>");
                itemsHtml.Append($"<td class='{(IsGujarati(list[i].VehicleOwnerName) ? "gujarati" : "")}'>{list[i].VehicleOwnerName}</td>");
                itemsHtml.Append($"<td class='{(IsGujarati(list[i].FromLocation) ? "gujarati" : "")}'>{list[i].FromLocation}</td>");
                itemsHtml.Append($"<td class='{(IsGujarati(list[i].ToLocation) ? "gujarati" : "")}'>{list[i].ToLocation}</td>");
                itemsHtml.Append($"<td>{list[i].VehicleNumber}</td>");
                itemsHtml.Append($"<td>{list[i].Amount}</td>");
                itemsHtml.Append("</tr>");
            }
            sb.Replace("{{tableBody}}", itemsHtml.ToString());
            return sb.ToString();
        }

        private bool IsGujarati(string text)
        {
            return text.Any(c => c >= '\u0A80' && c <= '\u0AFF');
        }
        #endregion
    }
}