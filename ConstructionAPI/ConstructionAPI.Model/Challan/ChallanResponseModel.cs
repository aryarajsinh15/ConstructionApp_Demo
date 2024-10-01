using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Challan
{
    public class ChallanResponseModel
    {
        public System.Guid ChallanId { get; set; }
        public System.Guid SiteId { get; set; }
        public System.Guid MerchantId { get; set; }
        public DateTime ChallanDate { get; set; }
        public string? ChallanNo { get; set; }
        public string? CarNo { get; set; }
        public string? SiteName { get; set; }
        public string? MerchantName { get; set; }
        public string? ChallanPhoto { get; set; }
        public string? Remarks { get; set; }
        public bool IsActive { get; set; }
        public System.Guid ClientId { get; set; }
        public long? totalRecords { get; set; }
    }

}
