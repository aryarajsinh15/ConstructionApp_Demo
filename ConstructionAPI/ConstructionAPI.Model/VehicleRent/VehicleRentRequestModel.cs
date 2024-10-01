using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.VehicleRent
{
    public class VehicleRentRequestModel
    {
        public string? VehicleRentId { get; set; }
        public string? VehicleOwnerId { get; set; }
        public DateTime VehicleRentDate { get; set; }
        public string? FromLocation { get; set; }
        public string? ToLocation { get; set; }
        public string? VehicleNumber { get; set; }
        public decimal Amount { get; set; }
        public bool IsPaid { get; set; }
        public string? Remarks { get; set; }
        public bool IsActive { get; set; }
    }

    public class VehicleRentExportRequestModel
    {
        public string? VehicleOwnerId { get; set; }
    }
}
