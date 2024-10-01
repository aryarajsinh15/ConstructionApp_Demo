using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.VehicleOwner;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.VehicleOwner
{
    public class VehicleOwnerRepository : BaseRepository, IVehicleOwnerRepository
    {
        public VehicleOwnerRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<VehicleOwnerResponseModel> ActiveInactiveVehicleOwner(string vehicleOwnerId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@vehicleOwnerId", vehicleOwnerId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<VehicleOwnerResponseModel>(StoreProcedure.ActiveInActiveVehicleOwner, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> DeleteVehicleOwner(Guid vehicleOwnerId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@VehicleOwnerId", vehicleOwnerId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteVehicleOwnerList, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<VehicleOwnerResponseModel> GetVehicleOwnerById(Guid vehicleOwnerId)
        {
            var param = new DynamicParameters();
            param.Add("@vehicleOwnerId", vehicleOwnerId);
            return await QueryFirstOrDefaultAsync<VehicleOwnerResponseModel>(StoreProcedure.GetVehicleOwnerById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<VehicleOwnerListModel>> GetVehicleOwnerList(CommonPaginationModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@clientId", clientId);
            var data = await QueryAsync<VehicleOwnerListModel>(StoreProcedure.GetVehicleOwnerList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SaveVehicleOwner(VehicleOwnerRequestModel model, Guid userId, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@VehicleOwnerId", model.VehicleOwnerId);
            param.Add("@ClientId", clientId);
            param.Add("@VehicleOwnerName", model.VehicleOwnerName);
            param.Add("@MobileNo", model.MobileNo);
            param.Add("@Remarks", model.Remarks);
            param.Add("@CreatedBy", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveVehicleOwner, param, commandType: CommandType.StoredProcedure);
        }
    }
}
