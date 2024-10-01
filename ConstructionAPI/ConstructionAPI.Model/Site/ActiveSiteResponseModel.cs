using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Site
{
    public class ActiveSiteResponseModel
    {
        public System.Guid SiteId { get; set; }
        public string? SiteName { get; set; }
        public bool IsActive { get; set; }

    }
}
