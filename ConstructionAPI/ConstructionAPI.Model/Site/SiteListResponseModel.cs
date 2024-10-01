using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Site
{
    public class SiteListResponseModel
    {
        public System.Guid SiteId { get; set; }
        public string? SiteName { get; set; }
        public string SiteDescription { get; set; }
        public decimal CreditAmount { get; set; }
        public decimal BillAmount { get; set; }
        public decimal Remaining { get; set; }
        public bool IsActive { get; set; }
        public long TotalRecords { get; set; }
    }

    public class SiteListRequestModel : CommonPaginationModel
    {
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string? ActiveInActiveStatus { get; set; }
    }
}
