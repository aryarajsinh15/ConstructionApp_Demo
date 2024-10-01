using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.PersonFinance;
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

namespace ConstructionAPI.Repository.Repository.PersonFinance
{
    public class PersonFinanceRepository : BaseRepository, IPersonFinanceRepository
    {
        public PersonFinanceRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<List<PersonFinanceListResponseModel>> GetPersonFinanceList(PersonFinanceListRequestModel model)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@personId", model.PersonId);
            var data = await QueryAsync<PersonFinanceListResponseModel>(StoreProcedure.GetPersonFinanceList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
        public async Task<long> DeletePersonFinance(Guid personFinanceId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@personFinanceId", personFinanceId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeletePersonFinance, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<PersonFinanceResponseModel> GetPersonFinanceById(Guid personFinanceId)
        {
            var param = new DynamicParameters();
            param.Add("@personFinanceId", personFinanceId);
            return await QueryFirstOrDefaultAsync<PersonFinanceResponseModel>(StoreProcedure.GetPersonFinanceById, param, commandType: CommandType.StoredProcedure);
        }

       

        public async Task<List<PersonFinanceListResponseModel>> GetPersonFinanceListForExport(string personfinanceId)
        {
            var param = new DynamicParameters();
            param.Add("@personfinanceId", personfinanceId);
            var data = await QueryAsync<PersonFinanceListResponseModel>(StoreProcedure.GetPersonFinanceListForExport, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SavePersonFinance(PersonFinanceRequestModel model, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@personFinanceId", model.PersonFinanceId);
            param.Add("@personId", model.PersonId);
            param.Add("@givenAmountBy", model.UserId);
            param.Add("@selectedDate", model.SelectedDate);
            param.Add("@amount", model.Amount);
            param.Add("@creditOrDebit", model.CreditOrDebit);
            param.Add("@paymentType", model.PaymentType);
            param.Add("@chequeNo", model.ChequeNo);
            param.Add("@bankName", model.BankName);
            param.Add("@chequeFor", model.ChequeFor);
            param.Add("@remarks", model.Remarks);
            param.Add("@createdBy", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SavePersonFinance, param, commandType: CommandType.StoredProcedure);
        }
    }
}
