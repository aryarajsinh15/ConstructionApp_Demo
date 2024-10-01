using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Dashboard
{
    public class DashboardResponseModel
    {
        public long UserCount { get; set; }
        public long MerchantCount { get; set; }
        public long SiteCount { get; set; }
        public long PersonCount { get; set; }
        public long VehicleOwnerCount { get; set; }
        public long ClientCount { get; set; }
    }
}