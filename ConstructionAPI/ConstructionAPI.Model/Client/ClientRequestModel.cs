using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Client
{
    public class ClientRequestModel
    {
        public string? ClientId { get; set; }
        public string ClientName { get; set; }
        public string FirmName { get; set; }
        public long PackageTypeId { get; set; }
        public DateTime ExpireDate { get; set; }
        public string? Address { get; set; }
        public string? Remarks { get; set; }
        public IFormFile? HeaderImage { get; set; }
        public IFormFile? FooterImage { get; set; }
        public string? HeaderImageLetterPage { get; set; }
        public string? FooterImageLetterPage { get; set; }
    }
}
