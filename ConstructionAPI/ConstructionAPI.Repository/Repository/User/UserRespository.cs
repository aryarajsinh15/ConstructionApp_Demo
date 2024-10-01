using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.User;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.User
{
    public class UserRespository : BaseRepository, IUserRepository
    {
        public UserRespository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<UserResponseModel> ActiveInactiveUser(string userId)
        {
            var param = new DynamicParameters();
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<UserResponseModel>(StoreProcedure.ActiveInActiveUser, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<ActiveUserResponseModel>> ActiveUserList(Guid clientId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", clientId);
            var data = await QueryAsync<ActiveUserResponseModel>(StoreProcedure.ActiveUserList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> DeleteUser(Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteUser, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<UserResponseModel> GetUserById(Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<UserResponseModel>(StoreProcedure.GetUserById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<UserListResponseModel>> GetUserList(UserListRequestModel model)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@clientId", model.ClientId);
            var data = await QueryAsync<UserListResponseModel>(StoreProcedure.GetUserList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SaveUser(UserRequestModel model)
        {
            var param = new DynamicParameters();
            param.Add("@userId", model.UserId);
            param.Add("@userName", model.UserName);
            param.Add("@password", model.Password);
            param.Add("@clientId", model.clientId);
            param.Add("@name", model.Name);
            param.Add("@email", model.Email);
            param.Add("@mobileNumber", model.MobileNumber);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveUser, param, commandType: CommandType.StoredProcedure);
        }
    }
}
