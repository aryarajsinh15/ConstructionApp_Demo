using ConstructionAPI.Model.Common;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.PersonBill
{
    public class PersonBillRequestModel
    {
        public string? PersonBillId { get; set; }
        public DateTime BillDate { get; set; }
        public string BillNo { get; set; }
        public decimal TotalAmount { get; set; }
        public string PersonId { get; set; }
        public string? Remarks { get; set; }
        public IFormFile? PersonBillFile { get; set; }
        public string? PersonBillFileName { get; set; }
        public string? PersonBillNewFileName { get; set; }
    }
    public class PersonBillListRequestModel : CommonPaginationModel
    {
       public string PersonId { get; set;}
    }
}
