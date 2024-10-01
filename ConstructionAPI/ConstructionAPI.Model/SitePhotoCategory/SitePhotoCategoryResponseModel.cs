using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.SitePhotoCategory
{
    public class SitePhotoCategoryResponseModel
    {
        public System.Guid SitePhotoCategoryId { get; set; }
        public string CategoryName { get; set; }
    }
    public class SitePhotoCategoryListResponseModel
    {
        public System.Guid SitePhotoCategoryId { get; set; }
        public string CategoryName { get; set; }
        public long TotalRecords { get; set; }
    }
}
