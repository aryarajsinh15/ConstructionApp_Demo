using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.PersonBill;
using ConstructionAPI.Model.SiteBill;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.PersonBill
{
    public class PersonBillRepository : BaseRepository, IPersonBillRepository
    {
        public PersonBillRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<long> DeletePersonBill(Guid siteBillId, Guid userid)
        {
            var param = new DynamicParameters();
            param.Add("@billId", siteBillId);
            param.Add("@userId", userid);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeletePersonBill, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<PersonBillResponseModel> GetPersonBillById(Guid siteBillId)
        {
            var param = new DynamicParameters();
            param.Add("@billId", siteBillId);
            return await QueryFirstOrDefaultAsync<PersonBillResponseModel>(StoreProcedure.GetPersonBillById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<PersonBillListResponseModel>> GetPersonBillList(PersonBillListRequestModel model)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@personId", model.PersonId) ;
            var data = await QueryAsync<PersonBillListResponseModel>(StoreProcedure.GetPersonBillList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SavePersonBill(PersonBillRequestModel model, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@billId", model.PersonBillId);
            param.Add("@personId", model.PersonId);
            param.Add("@billDate", model.BillDate);
            param.Add("@billNo", model.BillNo);
            param.Add("@totalAmount", model.TotalAmount);
            param.Add("@remarks", model.Remarks);
            param.Add("@billOriginalFileName", model.PersonBillFileName);
            param.Add("@billNewFileName", model.PersonBillNewFileName);
            param.Add("@createdBy", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SavePersonBill, param, commandType: CommandType.StoredProcedure);
        }
    }
}
