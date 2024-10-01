using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Repository.Repository.NewFolder;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.ContractorFinance
{
    public class ContractorFinanceRepository : BaseRepository, IContractorFinanceRepository
    {
        public ContractorFinanceRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<long> DeleteContractorFinance(Guid contractorFinanceId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@contractorFinanceId", contractorFinanceId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteContractorFinance, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<ContractorFinanceResponseModel> GetContractorFinanceById(Guid contractorFinanceId)
        {
            var param = new DynamicParameters();
            param.Add("@contractorFinanceId", contractorFinanceId);
            return await QueryFirstOrDefaultAsync<ContractorFinanceResponseModel>(StoreProcedure.GetContractorFinanceById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<ContractorFinanceListResponseModel>> GetContractorFinanceList(ContractorFinanceListRequestModel model)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@siteId", model.SiteId);
            var data = await QueryAsync<ContractorFinanceListResponseModel>(StoreProcedure.GetContractorFinanceList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<List<ContractorFinanceListResponseModel>> GetContractorFinanceListForExport(string siteId)
        {
            var param = new DynamicParameters();
            param.Add("@siteId", siteId);
            var data = await QueryAsync<ContractorFinanceListResponseModel>(StoreProcedure.GetContractorFinanceListForExport, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SaveContractorFinance(ContractorFinanceRequestModel model, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@contractorFinanceId", model.ContractorFinanceId);
            param.Add("@siteId", model.SiteId);
            param.Add("@userId", model.UserId);
            param.Add("@selectedDate", model.SelectedDate);
            param.Add("@amount", model.Amount);
            param.Add("@creditOrDebit", model.CreditOrDebit);
            param.Add("@paymentType", model.PaymentType);
            param.Add("@chequeNo", model.ChequeNo);
            param.Add("@bankName", model.BankName);
            param.Add("@chequeFor", model.ChequeFor);
            param.Add("@remarks", model.Remarks);
            param.Add("@createdBy", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveContractorFinance, param, commandType: CommandType.StoredProcedure);
        }
    }
}
