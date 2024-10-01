using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Estimate
{
    public class EstimateListResponseModel
    {
        public System.Guid EstimateId {  get; set; }
        public bool HasItems { get; set; }
        public string? PartyName {  get; set; } 
        public bool IsActive {  get; set; } 
        public long? TotalAmount {  get; set; } 
        public long? TotalRecords {  get; set; } 
        public string? Remarks {  get; set; }
        public string? EstimateFile { get; set; }
        public DateTime EstimateDate {  get; set; } 
    }

    public class EstimatePaginationModel : CommonPaginationModel
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
    }

}
