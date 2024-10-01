using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Client
{
    public class ClientResponseModel
    {
        public System.Guid ClientId { get; set; }  
        public string ClientName { get; set; }
        public string FirmName { get; set; }
        public string PackageType { get; set; }
        public long PackageTypeId { get; set; }
        public DateTime ExpireDate {  get; set; }
        public string Address { get; set; }
        public string Remarks { get; set; }
        public bool IsActive { get; set; }
        public long TotalRecords { get; set; }
        public long UserCount { get; set; }
        public string? HeaderImageLetterPage { get; set; }
        public string? FooterImageLetterPage { get; set; }
    }
}
