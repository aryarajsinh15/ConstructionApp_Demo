using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Client
{
    public interface IClientService
    {
        Task<List<ClientResponseModel>> GetClientList(CommonPaginationModel model);
        Task<long> DeleteClient(System.Guid clientId, System.Guid userId);
        Task<ClientResponseModel> GetClientById(System.Guid clientId);
        Task<ClientResponseModel> ActiveInactiveClient(string clientId, System.Guid userId);
        Task<long> SaveClient(ClientRequestModel model, System.Guid userId);
        Task<List<PackageTypeResposeModel>> GetPackageTypeList();


    }
}
