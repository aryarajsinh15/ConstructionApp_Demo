using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.Expense;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Expense
{
    public interface IExpenseService
    {
        Task<List<ExpenseTypeResponseModel>> GetExpenseTypeList();
        Task<List<ExpenseResponseModel>> GetExpenseList(ExpensePaginationModel model, string clientId);
        Task<long> DeleteExpense(System.Guid expenseId, System.Guid userId);
        Task<ExpenseResponseModel> GetExpenseById(System.Guid expenseId);
        Task<long> SaveExpense(ExpenseRequestModel model, System.Guid userId, System.Guid clientId);
        Task<ExpenseResponseModel> ActiveInactiveExpense(string expenseId, System.Guid userId);
        Task<List<ExpenseResponseModel>> GetExpenseListForExport(ExpenseExportRequestModel model,string clientId);
        byte[] GenerateExpenseListPdf(List<ExpenseResponseModel> model, string path);
    }
}
