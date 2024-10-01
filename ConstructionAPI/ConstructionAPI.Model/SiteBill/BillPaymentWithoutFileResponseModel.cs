using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.SiteBill
{
    public class BillPaymentWithoutFileResponseModel
    {
        public System.Guid BillId { get; set; }
        public System.Guid SiteId { get; set; }
        public DateTime BillDate { get; set; }
        public string BillNo { get; set; }
        public string BillType { get; set; }
        public string? Remarks { get; set; }
        public string SiteName { get; set; }
        public decimal TotalAmount { get; set; }

        public List<Items> items { get; set; }

    }

    public class Items
    {
        public System.Guid BillSiteItemId { get; set; }
        public string Description { get; set; }
        public decimal Rate { get; set; }
        public List<ItemDetailResponse> itemDetails { get; set; }

    }
    public class ItemDetailResponse
    {
        public System.Guid BillSiteItemId { get; set; }
        public System.Guid MainItemPKId { get; set; }
        public string ItemCategory { get; set; }
        public string ItemType { get; set; }
        public string Type { get; set; }
        public string ItemName { get; set; }
        public decimal Quantity { get; set; }
        public decimal? Length { get; set; }
        public decimal? Height { get; set; }
        public decimal? Width { get; set; }
        public decimal Area { get; set; }
    }

}
