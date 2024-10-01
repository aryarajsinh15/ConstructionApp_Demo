using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Common
{
    public class CommonActiveModel
    {
        public Guid UserId { get; set; }
        public string Id { get; set; }
        public bool IsActive { get; set; } 
    }
}
