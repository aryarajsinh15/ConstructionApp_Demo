using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Token
{
    public class TokenModel
    {
        public System.Guid UserId { get; set; } 
        public string ClientId { get; set; }
        public long RoleId { get; set; }
        public string FullName { get; set; }
        public string UserName { get; set; }
        public DateTime TokenValidTo { get; set; }
        public System.Guid ClientIdGuid { get; set; }

    }
}
