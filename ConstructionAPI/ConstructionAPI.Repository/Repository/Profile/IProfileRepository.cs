using ConstructionAPI.Model.Profile;
using ConstructionAPI.Model.Site;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Profile
{
    public interface IProfileRepository
    {
        Task<long> UpdateProfile(ProfileRequestModel model, System.Guid userId);
    }
}
