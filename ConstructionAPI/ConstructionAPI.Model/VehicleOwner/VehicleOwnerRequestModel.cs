using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.VehicleOwner
{
    public class VehicleOwnerRequestModel
    {
        public string? VehicleOwnerId { get; set; }
        public string? Remarks { get; set; }
        public string MobileNo { get; set; }
        public string VehicleOwnerName { get; set; }
    }
}
