using ConstructionAPI.Model.User;
using ConstructionAPI.Repository.Repository.Client;
using ConstructionAPI.Repository.Repository.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.User
{
    public class UserService : IUserService
    {
        #region Fields
        private readonly IUserRepository _repository;
        #endregion

        #region Construtor
        public UserService(IUserRepository repository)
        {
            _repository = repository;
        }

        public async Task<UserResponseModel> ActiveInactiveUser(string userId)
        {
            return await _repository.ActiveInactiveUser(userId);
        }

        public async Task<List<ActiveUserResponseModel>> ActiveUserList(Guid clientId)
        {
            return await _repository.ActiveUserList(clientId);
        }

        public async Task<long> DeleteUser(Guid userId)
        {
            return await _repository.DeleteUser(userId);
        }

        public async Task<UserResponseModel> GetUserById(Guid userId)
        {
            return await _repository.GetUserById(userId);
        }
        #endregion

        public async Task<List<UserListResponseModel>> GetUserList(UserListRequestModel model)
        {
            return await _repository.GetUserList(model);
        }

        public async Task<long> SaveUser(UserRequestModel model)
        {
            return await _repository.SaveUser(model);
        }
    }
}
