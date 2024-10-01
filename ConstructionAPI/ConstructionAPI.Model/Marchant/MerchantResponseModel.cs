using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Marchant
{
    public class MerchantResponseModel
    {
        public System.Guid MerchantId { get; set; }
        public int SrNo { get; set; }
        public string? MerchantName { get; set; }
        public string? FirmName { get; set; }
        public string? MobileNo { get; set; }
        public string? Address { get; set; }
        public string? ClientName { get; set; }
        public System.Guid ClientId { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }=DateTime.Now;
        public string? status { get; set; }
        public bool IsActive { get; set; }
        public long TotalRecords { get; set; }   
    }
    public class ClientResponseModel
    {
        public System.Guid ClientId { get; set; }
        public string? ClientName { get; set; } 
    }
    public class MerchantListDropDownModel
    {
        public System.Guid MerchantId { get; set; }
        public string? MerchantName { get; set; }
    }
}
