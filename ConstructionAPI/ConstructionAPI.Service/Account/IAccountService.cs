using ConstructionAPI.Model.Login;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Account
{
    public interface IAccountService
    {
        Task<LoginResponseModel> LoginUser(LoginRequestModel model);
        Task<long> UpdateLoginToken(string Token, System.Guid UserId);
        Task<long> UpdateUserPassword(ChangePasswordRequestModel model, System.Guid UserId);
        Task<long> ValidateUserTokenData(string Id, string jwtToken);


    }
}
