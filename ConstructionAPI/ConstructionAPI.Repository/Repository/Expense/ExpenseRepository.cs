using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.VehicleRent;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Expense
{
    public class ExpenseRepository : BaseRepository, IExpenseRepository
    {
        public ExpenseRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<List<ExpenseTypeResponseModel>> GetExpenseTypeList()
        {
            var data = await QueryAsync<ExpenseTypeResponseModel>(StoreProcedure.GetExpenseTypeList, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
        public async Task<List<ExpenseResponseModel>> GetExpenseList(ExpensePaginationModel model, string clientId)
        {
            try
            {
                var param = new DynamicParameters();
                param.Add("@pageIndex", model.PageNumber);
                param.Add("@pageSize", model.PageSize);
                param.Add("@orderBy", model.SortColumn);
                param.Add("@sortOrder", model.SortOrder);
                param.Add("@strSearch", model.StrSearch?.Trim());
                param.Add("@clientId", clientId);
                param.Add("@startDate", model.StartDate);
                param.Add("@endDate", model.EndDate);
                param.Add("@expenseTypeId", model.ExpenseTypeIds);
                param.Add("@siteId", model.SiteIds);
                param.Add("@activeInActiveStatus", model.ActiveInActiveStatus);
                var data = await QueryAsync<ExpenseResponseModel>(StoreProcedure.GetExpenseList, param, commandType: CommandType.StoredProcedure);
                return data.ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public async Task<long> DeleteExpense(System.Guid expenseId, System.Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@expenseId", expenseId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteExpense, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<ExpenseResponseModel> GetExpenseById(Guid expenseId)
        {
            var param = new DynamicParameters();
            param.Add("@expenseId", expenseId);
            return await QueryFirstOrDefaultAsync<ExpenseResponseModel>(StoreProcedure.GetExpenseById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> SaveExpense(ExpenseRequestModel model, Guid userId, Guid clientId)
        {
            var param = new DynamicParameters();
            param.Add("@ExpenseId", model.ExpenseId);
            param.Add("@ExpenseDate", model.ExpenseDate);
            param.Add("@ExpenseTypeId", model.ExpenseType);
            param.Add("@Description", model.Description);
            param.Add("@SiteId", model.SiteId);
            param.Add("@Amount", model.Amount);
            param.Add("@CreatedBy", userId);
            param.Add("@ClientId", clientId);
            param.Add("@ExpenseOriginalFileName", model.ExpenseFileName);
            param.Add("@ExpenseNewFileName", model.ExpenseNewFileName);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveExpense, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<ExpenseResponseModel> ActiveInactiveExpense(string expenseId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@ExpenseId", expenseId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<ExpenseResponseModel>(StoreProcedure.ActiveInActiveExpense, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<ExpenseResponseModel>> GetExpenseListForExport(ExpenseExportRequestModel model,string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@ClientId", clientId);
            param.Add("@ExpenseTypeId", model.ExpenseTypeId);
            param.Add("@SiteId", model.SiteId);
            param.Add("@StatusId", model.StatusId);
            var data = await QueryAsync<ExpenseResponseModel>(StoreProcedure.GetExpenseListForExport,param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
    }
}
