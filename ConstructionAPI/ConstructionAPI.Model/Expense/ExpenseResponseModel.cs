using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Expense
{
    public class ExpenseResponseModel
    {
        public System.Guid ExpenseId { get; set; }
        public DateTime ExpenseDate { get; set; }
        public long ExpenseTypeId { get; set; }
        public System.Guid ClientId { get; set; }
        public decimal Amount { get; set; }
        public string Description { get; set; }
        public System.Guid SiteId { get; set; }
        public string SiteName { get; set; }
        public string ExpenseType { get; set; }
        public bool IsActive { get; set; }
        public string? ExpenseFile { get; set; }
        public long TotalRecords { get; set; }
    }

    public class ExpensePaginationModel : CommonPaginationModel
    {
        public string? ExpenseTypeIds { get; set; }
        public string? SiteIds{ get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string? ActiveInActiveStatus { get; set; }
    }
}
