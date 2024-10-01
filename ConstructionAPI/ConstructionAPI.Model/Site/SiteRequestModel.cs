using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Site
{
    public class SiteRequestModel
    {
        public string? SiteId { get; set; }
        public string SiteName { get; set; }
        public string SiteDescription { get; set; }
    }
}
