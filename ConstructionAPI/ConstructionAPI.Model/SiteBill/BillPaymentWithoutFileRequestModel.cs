using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.SiteBill
{
    public class BillPaymentWithoutFileRequestModel
    {
        public string? BillPaymentId { get; set; }
        public DateTime BillDate { get; set; }
        public string BillNumber { get; set; }
        public string SiteId { get; set; }
        public string? Remarks { get; set; }
        public List<Item> Items { get; set; }
    }

    public class Item
    {
        public string? BillSiteItemId { get; set; }
        public string Description { get; set; }
        public decimal Rate { get; set; }
        public List<ItemDetail> ItemDetail { get; set; }
    }
    public class ItemDetail
    {
        public string? BillSiteItemId { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public decimal? Quantity { get; set; }
        public decimal? Length { get; set; }
        public decimal? Height { get; set; }
        public decimal? Width { get; set; }
        public decimal ItemDetailTotal { get; set; }

    }
}
