using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.VehicleOwner
{
    public class VehicleOwnerListModel
    {
        public System.Guid VehicleOwnerId { get; set; }
        public string? Remarks { get; set; }
        public string MobileNo { get; set; }
        public string VehicleOwnerName { get; set;}
        public bool IsActive { get; set;}
        public long TotalRecords{ get; set;}
    }
    public class VehicleOwnerResponseModel
    {
        public System.Guid VehicleOwnerId { get; set; }
        public string? Remarks { get; set; }
        public string MobileNo { get; set; }
        public string VehicleOwnerName { get; set; }
        public bool IsActive { get; set; }
    }
}
