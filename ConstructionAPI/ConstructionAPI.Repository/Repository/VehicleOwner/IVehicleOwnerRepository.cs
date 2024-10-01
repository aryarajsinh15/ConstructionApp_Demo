using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.VehicleOwner;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.VehicleOwner
{
    public interface IVehicleOwnerRepository
    {
        Task<List<VehicleOwnerListModel>> GetVehicleOwnerList(CommonPaginationModel model, string clientId);
        Task<long> DeleteVehicleOwner(System.Guid vehicleOwnerId, System.Guid userId);
        Task<VehicleOwnerResponseModel> GetVehicleOwnerById(System.Guid vehicleOwnerId);
        Task<VehicleOwnerResponseModel> ActiveInactiveVehicleOwner(string vehicleOwnerId, System.Guid userId);
        Task<long> SaveVehicleOwner(VehicleOwnerRequestModel model, System.Guid userId, string clientId);

    }
}
