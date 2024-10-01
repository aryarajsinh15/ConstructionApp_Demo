using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.PersonFinance
{
    public class PersonFinanceListRequestModel : CommonPaginationModel
    {
        public string? PersonId { get; set; }
    }
}
