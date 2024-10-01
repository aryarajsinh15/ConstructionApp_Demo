using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.SiteBill
{
    public class SiteBillResponseModel  
    {
        public System.Guid BillId { get; set; }
        public DateTime BillDate { get; set; }
        public string BillNo { get; set; }
        public decimal TotalAmount { get; set; }
        public string? Remarks { get; set; }
        public string? SiteBillFile { get; set; }

    }
    public class SiteBillListResponseModel
    {
        public System.Guid BillId { get; set; }
        public DateTime BillDate { get; set; }
        public string BillNo { get; set; }
        public System.Guid SiteId { get; set; }
        public string SiteName { get; set; }
        public decimal TotalAmount { get; set; }
        public string BillType { get; set; }
        public string? Remarks { get; set; }
        public string? SiteBillFile { get; set; }
        public long TotalRecords { get; set; }

    }
}
