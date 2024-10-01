using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Model.Expense;

namespace ConstructionAPI.Repository.Repository.Merchant
{
    public class MerchantRepository : BaseRepository, IMerchantRepository
    {
        #region Fields              
        #endregion

        #region Constructor
        public MerchantRepository(IOptions<DataConfig> dataConfig) : base(dataConfig)
        {           
        }
        #endregion

        #region Methods 
        public async Task<List<MerchantResponseModel>> GetMerchantList(CommonPaginationModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch);
            param.Add("@clientId", clientId);
            var data = await QueryAsync<MerchantResponseModel>(StoreProcedure.GetMerchantList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<List<MerchantListDropDownModel>> GetMerchantListForDropDown( string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", clientId);
            var data = await QueryAsync<MerchantListDropDownModel>(StoreProcedure.GetMerchantList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<List<MerchantResponseModel>> GetMerchantGetById(string id)
        {          
            var param = new DynamicParameters();
            param.Add("@Id", id);
            var data = await QueryAsync<MerchantResponseModel>(StoreProcedure.GetMerchantById, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<ResponseModel> SaveMerchant(MerchantRequestModel model, Guid id, string ClientId)
        {
            var param = new DynamicParameters();
            param.Add("@MerchantId", model.MerchantId);
            param.Add("@MerchantName", model.MerchantName);
            param.Add("@FirmName", model.FirmName);
            param.Add("@MobileNo", model.MobileNo);
            param.Add("@Address", model.Address);
            param.Add("@ClientId", ClientId);          
            param.Add("@CreatedBy", id);
            var data = await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.SaveMerchant, param, commandType: CommandType.StoredProcedure);
            return data;
        }

        public async Task<ResponseModel> DeleteMerchant(string id)
        {
            var param = new DynamicParameters();
            param.Add("@Id", id);
            return await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.DeleteMerchant, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<ClientResponseModel>> GetClientList()
        {            
            var data = await QueryAsync<ClientResponseModel>(StoreProcedure.GetActiveClientList, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<MerchantResponseModel> ActiveInactiveMerchant(string merchantId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@MerchantId", merchantId);
            param.Add("@UserId", userId);
            return await QueryFirstOrDefaultAsync<MerchantResponseModel>(StoreProcedure.ActiveInActiveMerchant, param, commandType: CommandType.StoredProcedure);
        }
        #endregion
    }
}
