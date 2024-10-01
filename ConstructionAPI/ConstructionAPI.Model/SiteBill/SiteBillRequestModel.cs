using ConstructionAPI.Model.Common;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.SiteBill
{
    public class SiteBillRequestModel
    {
        public string? SiteBillId { get; set; }
        public DateTime BillDate { get; set; }
        public string BillNo { get; set; }
        public decimal TotalAmount { get; set; }
        public string SiteId { get; set; }
        public string? Remarks { get; set; }
        public IFormFile? SiteBillFile { get; set; }
        public string? SiteBillFileName { get; set; }
        public string? SiteBillNewFileName { get; set; }
    }
    public class SiteBillListRequestModel : CommonPaginationModel
    {
       public string SiteId { get; set;}
    }
}
