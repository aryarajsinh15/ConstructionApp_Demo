using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.VehicleRent
{
    public class VehicleRentResponseModel
    {
        public System.Guid VehicleRentId { get; set; }
        public System.Guid VehicleOwnerId { get; set; }
        public DateTime VehicleRentDate { get; set; }
        public string? FromLocation { get; set; }
        public string? VehicleOwnerName { get; set; }
        public string? ToLocation { get; set; }
        public string VehicleNumber { get; set; }
        public decimal Amount { get; set; }
        public bool IsPaid { get; set; }
        public string? Remarks { get; set; }
        public bool IsActive { get; set; }
        public System.Guid ClientId { get; set; }
        public long? totalRecords { get; set; }

    }

    public class VehicalRentResponseModel
    {
        public System.Guid VehicleRentId { get; set; }
        public System.Guid VehicleOwnerId { get; set; }
        public DateTime VehicleRentDate { get; set; }
        public string? FromLocation { get; set; }
        public string? ToLocation { get; set; }
        public string VehicleNumber { get; set; }
        public decimal Amount { get; set; }
        public bool IsPaid { get; set; }
        public string? Remarks { get; set; }
        public bool IsActive { get; set; }
        public System.Guid ClientId { get; set; }
    }

    public class VehileRentListRequestModel : CommonPaginationModel
    {
        public DateTime? startDate { get; set; }
        public DateTime? endDate { get; set; }
        public string? vehicleOwnerId { get; set; }
    }
}
