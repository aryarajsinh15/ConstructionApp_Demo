using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Login
{
    public class LoginResponseModel
    {
        public System.Guid UserId { get; set; }
        public string UserName { get; set; }
        public string EmailId { get; set; }
        public System.Guid? ClientId { get; set; }
        public string UserPhoto { get; set; }
        public long RoleId { get; set; }
        public string FullName { get; set; } 
        public string JWTToken { get; set; }
        public string FirmName { get; set; }
        public string RoleName { get; set; }
        public int? Status { get; set; }

    }
}
