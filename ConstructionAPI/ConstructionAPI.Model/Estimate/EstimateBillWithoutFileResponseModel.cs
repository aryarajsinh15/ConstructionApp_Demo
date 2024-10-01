using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Estimate
{
    public class EstimateBillWithoutFileResponseModel
    {
        public System.Guid EstimateId { get; set; }
        public DateTime estimateBillDate { get; set; }
        public string? PartyName { get; set; }
        public string? Remarks { get; set; }
        public decimal? TotalAmount { get; set; }
        public List<ItemDetailsRes>? ItemsDetails { get; set; }

    }

    public class ItemDetailsRes
    {
        public System.Guid BillEstimateItemId { get; set; }
        public System.Guid estimateId { get; set; }
        public string? Name { get; set; }
        public string? Nos { get; set; }
        public decimal? Quantity { get; set; }
        public decimal? Rate { get; set; }
        public decimal? Total { get; set; }

    }
}
