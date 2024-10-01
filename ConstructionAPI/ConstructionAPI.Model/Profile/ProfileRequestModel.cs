using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Profile
{
    public class ProfileRequestModel
    {
        public string? UserId { get; set; }
        public string? UserEmail { get; set; }
        public string? UserName { get; set; }
        public string? FirstName { get; set; }
        public string? MobileNo { get; set; }
        public IFormFile? UserPhoto { get; set; }
        public string? UserPhotoName { get; set; }
    }
}
