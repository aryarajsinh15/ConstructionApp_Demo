using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Settings
{
    public class AppSettings
    {
        public string? JWT_Secret { get; set; }
        public int JWT_Validity_Mins { get; set; }
        public string ErrorSendToEmail { get; set; }


    }
}
