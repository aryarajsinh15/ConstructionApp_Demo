using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.PersonAttendance
{
    public class PersonAttendanceRequestModel
    {
        public string? AttendanceId { get; set; }
        public DateTime AttendanceDate { get; set; }
        public string? ClientId { get; set; }
        public System.Guid? LoggedId { get; set; }
        public List<PersonAttendanceRequestListModel> AttendanceList { get; set; }
    }
    public class PersonAttendanceByIdRequestModel
    {
        public System.Guid? AttendanceId { get; set; }
        public DateTime AttendanceDate { get; set; }
        public System.Guid? ClientId { get; set; }
        public System.Guid? LoggedId { get; set; }
        public List<PersonAttendanceByIdRequestListModel> AttendanceList { get; set; }
    }
    public class PersonAttendanceRequestListModel
    {
        public string? PersonAttendanceId { get; set; } 
        public string? PersonId { get; set; }
        public decimal? AttendanceStatus { get; set; }
        public string? SiteId { get; set; }
        public int? WithdrawAmount { get; set; }
        public int? OvertimeAmount { get; set; }
        public string? Remarks { get; set; }
    }
    public class PersonAttendanceByIdRequestListModel
    {
        public System.Guid? PersonAttendanceId { get; set; }
        public System.Guid? PersonId { get; set; }
        public string? PersonName { get; set; }
        public decimal? AttendanceStatus { get; set; }
        public System.Guid? SiteId { get; set; }
        public int? WithdrawAmount { get; set; }
        public int? OvertimeAmount { get; set; }
        public string? Remarks { get; set; }
    }
    public class PersonAttendanceResponseModel
    {
        public System.Guid? AttendanceId { get; set; }
        public DateTime AttendanceDate { get; set; }
        public System.Guid? ClientId { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal FullDay {get; set; }
        public decimal HalfDay { get; set; }
        public decimal Absent {  get; set; }
        public decimal Total { get; set; }
        public long SrNo { get; set; }
        public long TotalRecords { get;set; }
    }
    public class PersonAttendancePagationModel : CommonPaginationModel
    {
        public string? ClientId { get; set; }
    }
    public class AttendanceByPersonRequestModel : CommonPaginationModel
    {
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string? StatusIds { get; set; }
        public string? SiteIds { get; set; }
        public string? PersonId { get; set; }
    }
    public class AttendanceByPersonResponseModel 
    {
        public DateTime AttendanceDate { get; set; }
        public decimal? AttendanceStatus { get; set; }
        public System.Guid? SiteId { get; set; }
        public string? SiteName { get; set; }
        public System.Guid? PersonId { get; set; }
        public int? WithdrawAmount { get; set; }
        public int? OvertimeAmount { get; set; }
        public int? PayableAmount { get; set; }
        public string? Remarks { get; set; }
        public long SrNo { get; set; }
        public long TotalRecords { get; set; }
    }
}
