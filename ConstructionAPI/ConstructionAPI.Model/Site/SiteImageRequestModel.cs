using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Site
{
    public class SiteImageRequestModel
    {
        public string SiteId { get; set; }
        public string SiteCategoryId { get; set; } 
        public List<IFormFile> Photo { get; set; }
        public List<SiteImageNameModel>? SiteImage {  get; set; }
    }

    public class SiteImageNameModel
    {

        public string? ImageFileOriginalName { get; set; }
        public string? ImageFileEncryptedName { get; set;}
    }



}
