using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Estimate
{
    public class EstimateWithoutFileRequestModel
    {
        public string? estimateId { get; set; }
        public DateTime estimateBillDate { get; set; }
        public string? PartyName { get; set; }
        public string? Remarks { get; set; }
        public decimal? finalTotal { get; set; }
        public List<ItemDetails>? ItemsDetails { get; set; }
    }
    
    public class ItemDetails
    {
        public string? BillEstimateItemId { get; set; }
        public string? Name { get; set; }
        public string? Nos { get; set; }
        public decimal? Quantity { get; set; }
        public decimal? Rate { get; set; }
        public decimal? total { get; set; }
    }
}
