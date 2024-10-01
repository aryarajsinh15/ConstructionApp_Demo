using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Profile;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Profile
{
    public class ProfileRepository : BaseRepository, IProfileRepository
    {

        public ProfileRepository(IOptions<DataConfig> dataConfig) : base(dataConfig)
        { }

        public async Task<long> UpdateProfile(ProfileRequestModel model, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@UserId", userId);
            param.Add("@UserEmail", model.UserEmail);
            param.Add("@UserName", model.UserName);
            param.Add("@FirstName", model.FirstName);
            param.Add("@MobileNo", model.MobileNo);
            param.Add("@userPhoto", model.UserPhotoName);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.UpdateProfile, param, commandType: CommandType.StoredProcedure);
        }
    }
}