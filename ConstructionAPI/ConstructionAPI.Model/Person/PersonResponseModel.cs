using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Person
{
    public class PersonResponseModel
    {
        public System.Guid? PersonId { get; set; }
        public string? PersonFirstName { get; set; }
        public string? PersonAddress { get; set; }
        public string? MobileNo { get; set; }
        public string? PersonPhoto { get; set; }
        public int? DailyRate { get; set; }
        public int? Id { get; set; }
        public string? PersonType { get; set; }
        public bool? IsAttendancePerson { get; set; }
        public int? OrderNo { get; set; }
        public System.Guid? ClientId { get; set; }
        public string? ClientName { get; set; }
        public string? CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public string? Status { get; set; }
        public bool? IsActive { get; set; }
        public long TotalRecords { get; set; }
        public decimal CreditAmount { get; set; }
        public decimal BillAmount { get; set; }
        public decimal Remaining { get; set; }
    }
    public class PersonTypeResponseModel
    {
        public int? Id { get; set; }
        public string? PersonType { get; set; }
    }
    public class PersonDropDownModel
    {
        public System.Guid? PersonId { get; set; }
        public string? PersonFirstName { get; set; }
        public int? UsageStatus { get; set; }
    }

    public class PersonRequestFilterModel : CommonPaginationModel
    {
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string? ActiveInActiveStatus { get; set; }
    }

    public class PersonAttedanceRequestFilterModel : CommonPaginationModel
    {
       public string? ActiveInActiveStatus { get; set; }
    }
}
