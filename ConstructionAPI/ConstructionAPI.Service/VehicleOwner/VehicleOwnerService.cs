using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.VehicleOwner;
using ConstructionAPI.Repository.Repository.Client;
using ConstructionAPI.Repository.Repository.VehicleOwner;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.VehicleOwner
{
    public class VehicleOwnerService : IVehicleOwnerService
    {
        #region Fields
        private readonly IVehicleOwnerRepository _repository;
        #endregion

        #region Construtor
        public VehicleOwnerService(IVehicleOwnerRepository repository)
        {
            _repository = repository;
        }
        #endregion
        public async Task<VehicleOwnerResponseModel> ActiveInactiveVehicleOwner(string vehicleOwnerId, Guid userId)
        {
            return await _repository.ActiveInactiveVehicleOwner(vehicleOwnerId, userId);
        }

        public async Task<long> DeleteVehicleOwner(Guid vehicleOwnerId, Guid userId)
        {
            return await _repository.DeleteVehicleOwner(vehicleOwnerId, userId);
        }

        public async Task<VehicleOwnerResponseModel> GetVehicleOwnerById(Guid vehicleOwnerId)
        {
            return await _repository.GetVehicleOwnerById(vehicleOwnerId);
        }

        public async Task<List<VehicleOwnerListModel>> GetVehicleOwnerList(CommonPaginationModel model, string clientId)
        {
            return await _repository.GetVehicleOwnerList(model, clientId);
        }

        public async Task<long> SaveVehicleOwner(VehicleOwnerRequestModel model, Guid userId, string clientId)
        {
            return await _repository.SaveVehicleOwner(model, userId, clientId);
        }
    }
}
