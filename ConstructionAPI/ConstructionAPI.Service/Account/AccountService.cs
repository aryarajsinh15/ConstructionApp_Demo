using ConstructionAPI.Model.Login;
using ConstructionAPI.Repository.Repository.Account;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Account
{
    public class AccountService : IAccountService
    {
        #region Fields
        private readonly IAccountRepository _repository;
        #endregion

        public AccountService(IAccountRepository repository)
        {
            _repository = repository;
        }

        public async Task<LoginResponseModel> LoginUser(LoginRequestModel model)
        {
            return await _repository.LoginUser(model);
        }

        public async Task<long> UpdateLoginToken(string Token, System.Guid UserId)
        {
            return await _repository.UpdateLoginToken(Token, UserId);
        }

        public async Task<long> UpdateUserPassword(ChangePasswordRequestModel model, Guid UserId)
        {
            return await _repository.UpdateUserPassword(model, UserId);
        }

        public async Task<long> ValidateUserTokenData(string Id, string jwtToken)
        {
            return await _repository.ValidateUserTokenData(Id, jwtToken);
        }
    }
}
