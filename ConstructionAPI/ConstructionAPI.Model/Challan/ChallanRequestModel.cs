using ConstructionAPI.Model.Common;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Challan
{
    public class ChallanRequestModel
    {
        public string? ChallanId { get; set; }
        public string? SiteId { get; set; }
        public string? MerchantId { get; set; }
        public DateTime? ChallanDate { get; set; }
        public string? ChallanNo { get; set; }
        public string? CarNo { get; set; }
        public IFormFile? ChallanPhoto { get; set; }
        public string? ChallanPhotoName { get; set; }
        public string? ChallanNewPhotoName { get; set; }
        public string? Remarks { get; set; }
    }
    public class ChallanListRequestModel : CommonPaginationModel
    {
        public string? SiteId { get; set;}
        public string? MerchantId { get; set;}
        public DateTime? StartDate { get; set;}
        public DateTime? EndDate { get; set;}
    }
}
