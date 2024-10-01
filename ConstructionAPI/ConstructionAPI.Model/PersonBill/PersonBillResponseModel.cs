using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.PersonBill
{
    public class PersonBillResponseModel  
    {
        public System.Guid BillId { get; set; }
        public DateTime BillDate { get; set; }
        public string BillNo { get; set; }
        public decimal TotalAmount { get; set; }
        public string Remarks { get; set; }
        public string? SiteBillFile { get; set; }

    }
    public class PersonBillListResponseModel
    {
        public System.Guid BillId { get; set; }
        public DateTime BillDate { get; set; }
        public string BillNo { get; set; }
        public System.Guid PersonId { get; set; }
        public string PersonName { get; set; }
        public decimal TotalAmount { get; set; }
        public string BillType { get; set; }
        public string Remarks { get; set; }
        public string? PersonBillFile { get; set; }
        public long TotalRecords { get; set; }

    }
}
