using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Site
{
    public class SiteImageResponseModel
    {
        public System.Guid SitePhotoCategoryId { get; set; }
        public string CategoryName { get; set; }

        public List<SiteImage> Images { get; set; }
    }
    public class SiteImage
    {
        public string? PhotoName { get; set; }
        public System.Guid SitePhotoId { get; set; }
        public System.Guid SitePhotoCategoryId { get; set; }
        public System.Guid SiteId { get; set; }

    }
}
