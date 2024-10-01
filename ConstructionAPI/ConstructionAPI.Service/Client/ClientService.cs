using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Repository.Repository.Client;
using ConstructionAPI.Repository.Repository.Expense;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Client
{
    public class ClientService : IClientService
    {

        #region Fields
        private readonly IClientRepository _repository;
        #endregion

        #region Construtor
        public ClientService(IClientRepository repository)
        {
            _repository = repository;
        }
        #endregion

        public async Task<ClientResponseModel> ActiveInactiveClient(string clientId, Guid userId)
        {
            return await _repository.ActiveInactiveClient(clientId, userId);
        }

        public async Task<long> DeleteClient(Guid clientId, Guid userId)
        {
            return await _repository.DeleteClient(clientId, userId);
        }

        public async Task<ClientResponseModel> GetClientById(Guid clientId)
        {
            return await _repository.GetClientById(clientId);
        }

        public async Task<List<ClientResponseModel>> GetClientList(CommonPaginationModel model)
        {
            return await _repository.GetClientList(model);
        }

        public async Task<List<PackageTypeResposeModel>> GetPackageTypeList()
        {
            return await _repository.GetPackageTypeList();
        }

        public async Task<long> SaveClient(ClientRequestModel model, Guid userId)
        {
            return await _repository.SaveClient(model, userId);
        }
    }
}
