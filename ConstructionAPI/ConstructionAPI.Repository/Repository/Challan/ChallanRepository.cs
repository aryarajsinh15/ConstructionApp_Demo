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
using ConstructionAPI.Model.VehicleRent;
using static System.Runtime.InteropServices.JavaScript.JSType;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Challan;

namespace ConstructionAPI.Repository.Repository.Challan
{
    public class ChallanRepository : BaseRepository, IChallanRepository
    {
        #region Fields              
        #endregion

        #region Constructor
        public ChallanRepository(IOptions<DataConfig> dataConfig) : base(dataConfig)
        {           
        }
        #endregion

        #region Add, Update, Delete, List Methods 
        public async Task<List<ChallanResponseModel>> GetChallanList(ChallanListRequestModel model, string clientId)
      {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch);
            param.Add("@clientId", clientId);
            param.Add("@siteId", model.SiteId);
            param.Add("@merchantId", model.MerchantId);
            param.Add("@startDate", model.StartDate);
            param.Add("@endDate", model.EndDate);
            var data = await QueryAsync<ChallanResponseModel>(StoreProcedure.GetChallanList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SaveChallan(ChallanRequestModel model, Guid userId, Guid clientId)
        {
            var param = new DynamicParameters();
            param.Add("@ChallanId", model.ChallanId);
            param.Add("@ChallanDate", model.ChallanDate);
            param.Add("@ChallanNo", model.ChallanNo);
            param.Add("@SiteId", model.SiteId);
            param.Add("@MerchantId", model.MerchantId);
            param.Add("@CarNo", model.CarNo);
            param.Add("@Remarks", model.Remarks);
            param.Add("@ClientId", clientId);
            param.Add("@CreatedBy", userId);
            param.Add("@ChallanOriginalFileName", model.ChallanPhotoName);
            param.Add("@ChallanNewFileName", model.ChallanNewPhotoName);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveChallan, param, commandType: CommandType.StoredProcedure);
        }


        public async Task<long> DeleteChallan(System.Guid challanId, System.Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@challanId", challanId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteChallan, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<ChallanResponseModel> ActiveInactiveChallan(string challanId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@ChallanId", challanId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<ChallanResponseModel>(StoreProcedure.ChallanInActive, param, commandType: CommandType.StoredProcedure);
        }


        public async Task<List<MarchantListResponseModel>> GetMarchantList(string ClientId)
        {
            var param = new DynamicParameters();
            param.Add("@ClientId", ClientId);
            var data =  await QueryAsync<MarchantListResponseModel>(StoreProcedure.GetMarchantList,param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<ChallanResponseModel>GetChallanImageName(string challanId)
        {
            var param = new DynamicParameters();
            param.Add("@ChallanId", challanId);
            return await QueryFirstOrDefaultAsync<ChallanResponseModel>(StoreProcedure.GetChallanImage, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<ChallanResponseModel> GetChallanById(Guid challanId)
        {
            var param = new DynamicParameters();
            param.Add("@challanId", challanId);
            return await QueryFirstOrDefaultAsync<ChallanResponseModel>(StoreProcedure.GetChallanById, param, commandType: CommandType.StoredProcedure);
        }
        #endregion

    }
}
