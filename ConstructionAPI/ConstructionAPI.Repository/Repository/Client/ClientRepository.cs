using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Expense;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Client
{
    public class ClientRepository : BaseRepository, IClientRepository
    {
        public ClientRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<ClientResponseModel> ActiveInactiveClient(string clientId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", clientId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<ClientResponseModel>(StoreProcedure.ActiveInActiveClient, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> DeleteClient(Guid clientId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", clientId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteClientList, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<ClientResponseModel> GetClientById(Guid clientId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", clientId);
            return await QueryFirstOrDefaultAsync<ClientResponseModel>(StoreProcedure.GetClientById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<ClientResponseModel>> GetClientList(CommonPaginationModel model)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            var data = await QueryAsync<ClientResponseModel>(StoreProcedure.GetClientList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<List<PackageTypeResposeModel>> GetPackageTypeList()
        {
            var data = await QueryAsync<PackageTypeResposeModel>(StoreProcedure.GetPackageTypeList, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SaveClient(ClientRequestModel model, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@ClientId", model.ClientId);
            param.Add("@ClientName", model.ClientName);
            param.Add("@FirmName", model.FirmName);
            param.Add("@PackageTypeId", model.PackageTypeId);
            param.Add("@ExpireDate", model.ExpireDate);
            param.Add("@Address", model.Address);
            param.Add("@Remarks", model.Remarks);
            param.Add("@HeaderImageLetterPage", model.HeaderImageLetterPage);
            param.Add("@FooterImageLetterPage", model.FooterImageLetterPage);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveClient, param, commandType: CommandType.StoredProcedure);

        }
    }
}
