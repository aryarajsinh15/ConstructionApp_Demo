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
using ConstructionAPI.Model.ContractorFinance;
using System.ComponentModel.Design;
using System.Reflection;

namespace ConstructionAPI.Repository.Repository.VehicalRent
{
    public class VehicleRentRepository : BaseRepository, IVehicleRentRepository
    {
        #region Fields              
        #endregion

        #region Constructor
        public VehicleRentRepository(IOptions<DataConfig> dataConfig) : base(dataConfig)
        {
        }
        #endregion

        #region Methods 
        public async Task<List<VehicleRentResponseModel>> GetVehicleRentList(VehileRentListRequestModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch);
            param.Add("@startDate", model.startDate);
            param.Add("@endDate", model.endDate);
            param.Add("@vehicleOwnerId", model.vehicleOwnerId);
            param.Add("@clientId", clientId);
            var data = await QueryAsync<VehicleRentResponseModel>(StoreProcedure.GetVehicleRentList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<List<VehicleOwnerListForRentModel>> GetVehicleOwnerListForRent(string ClientId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", ClientId);
            var data = await QueryAsync<VehicleOwnerListForRentModel>(StoreProcedure.GetVehicleOwnerRentList,param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<VehicalRentResponseModel> GetVehicleRentGetById(string id)
        {
            var param = new DynamicParameters();
            param.Add("@VehicleRentId", id);
            var result = await QueryFirstOrDefaultAsync<VehicalRentResponseModel>(StoreProcedure.GetVehicleRentById, param, commandType: CommandType.StoredProcedure);
            return result;
        }

        public async Task<ResponseModel> SaveVehicleRent(VehicleRentRequestModel model, Guid id, System.Guid clientId)
        {
            var param = new DynamicParameters();
            param.Add("@VehicleRentId", model.VehicleRentId);
            param.Add("@VehicleOwnerId", model.VehicleOwnerId);
            param.Add("@VehicleRentDate", model.VehicleRentDate);
            param.Add("@FromLocation", model.FromLocation);
            param.Add("@ToLocation", model.ToLocation);
            param.Add("@VehicleNumber", model.VehicleNumber);
            param.Add("@Amount", model.Amount);
            param.Add("@IsPaid", model.IsPaid);
            param.Add("@Remarks", model.Remarks);
            param.Add("@ClientId", clientId);
            param.Add("@CreatedBy", id);
            var data = await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.SaveVehicleRent, param, commandType: CommandType.StoredProcedure);
            return data;
        }

        public async Task<ResponseModel> DeleteVehicleRent(string id)
        {
            var param = new DynamicParameters();
            param.Add("@VehicleRentId", id);
            return await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.DeleteVehicleRent, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<VehicleRentResponseModel> ActiveInactiveVehicleRent(string VehicleRentId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@VehicleRentId", VehicleRentId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<VehicleRentResponseModel>(StoreProcedure.VehicleRentInActive, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<VehicleRentResponseModel>> GetVehicleRentListForExport(VehicleRentExportRequestModel model)
        {
            var param = new DynamicParameters();
            param.Add("@VehicleOwnerId", model.VehicleOwnerId);
            var data = await QueryAsync<VehicleRentResponseModel>(StoreProcedure.GetVehicleRentListForExport, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
        #endregion
    }
}
