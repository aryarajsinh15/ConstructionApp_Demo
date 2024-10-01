using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Login;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Account
{
    public class AccountRepository : BaseRepository, IAccountRepository
    {
        public AccountRepository(IOptions<DataConfig> dataConfig) :base(dataConfig)
        { }
        public async Task<LoginResponseModel> LoginUser(LoginRequestModel model)
        {

            var param = new DynamicParameters();
            param.Add("@UserName", model.UserName);
            param.Add("@Password", model.Password);
            return await QueryFirstOrDefaultAsync<LoginResponseModel>(StoreProcedure.LoginUser, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> UpdateLoginToken(string Token, System.Guid UserId)
        {
            var param = new DynamicParameters();
            param.Add("@Token", Token);
            param.Add("@UserId", UserId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.UpdateLoginToken, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> UpdateUserPassword(ChangePasswordRequestModel model, Guid UserId)
        {
            var param = new DynamicParameters();
            param.Add("@oldPassword", model.OldPassword);
            param.Add("@newPassword", model.NewPassword);
            param.Add("@UserId", UserId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.UpdateUserPassword, param, commandType: CommandType.StoredProcedure);

        }

        public async Task<long> ValidateUserTokenData(string Id, string jwtToken)
        {
            var param = new DynamicParameters();
            param.Add("@Id", Id);
            param.Add("@jwtToken", jwtToken);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.ValidateToken, param, commandType: CommandType.StoredProcedure);
        }
    }
}
