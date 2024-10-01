using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Marchant
{
    public class MerchantRequestModel
    {
        public string? MerchantId { get; set; }
        public string? MerchantName { get; set; }
        public string? FirmName { get; set; }
        public string? MobileNo { get; set; }
        public string? Address { get; set; }
        public Guid ClientId { get; set; }        
    }
}
