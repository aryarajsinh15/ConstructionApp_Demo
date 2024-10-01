using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Estimate
{
    public class EstimateRequestModel
    {
        public string? EstimateId { get; set; }
        public DateTime EstimateDate { get; set; }
        public string PartyName { get; set; }
        public decimal TotalAmount { get; set; }
        public string? Remarks { get; set; }
        public IFormFile? EstimatePhoto { get; set; }
        public string? EstimatePhotoName { get; set; }
        public string? EstimateNewPhotoName { get; set; }
        public string? CreatedBy { get; set; }
    }
}
