using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.User
{
    public interface IUserRepository
    {
        Task<List<UserListResponseModel>> GetUserList(UserListRequestModel model);
        Task<long> DeleteUser(System.Guid userId);
        Task<UserResponseModel> GetUserById(System.Guid userId);
        Task<UserResponseModel> ActiveInactiveUser(string userId);
        Task<long> SaveUser(UserRequestModel model);
        Task<List<ActiveUserResponseModel>> ActiveUserList(System.Guid clientId);

    }
}
