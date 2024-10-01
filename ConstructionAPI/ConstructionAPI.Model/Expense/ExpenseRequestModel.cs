using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Expense
{
    public class ExpenseRequestModel
    {
        public string? ExpenseId { get; set; }
        public DateTime ExpenseDate { get; set; }
        public long ExpenseType { get; set; }
        public decimal Amount { get; set; }
        public string? SiteId { get; set; }
        public string? Description { get; set; }
        public IFormFile? ExpenseFile { get; set; }
        public string? ExpenseFileName { get; set; }
        public string? ExpenseNewFileName { get; set; }
    }

    public class ExpenseExportRequestModel
    {
        public string? ExpenseTypeId { get; set; }
        public string? SiteId { get; set; }
        public string? StatusId { get; set; }
    }
}