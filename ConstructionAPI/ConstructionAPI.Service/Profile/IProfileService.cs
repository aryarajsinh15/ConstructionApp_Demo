using ConstructionAPI.Model.Profile;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Profile
{
    public interface IProfileService
    {
        Task<long> UpdateProfile(ProfileRequestModel model, System.Guid userId);
    }
}
