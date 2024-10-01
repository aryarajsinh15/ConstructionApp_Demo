using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.ContractorFinance
{
    public class ContractorFinanceListRequestModel : CommonPaginationModel
    {
        public string SiteId { get; set; }
    }
}
