using ConstructionAPI.Model.Profile;
using ConstructionAPI.Repository.Repository.Profile;
using ConstructionAPI.Repository.Repository.Site;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Profile
{
    public class ProfileService : IProfileService
    {

        #region Fields
        private readonly IProfileRepository _repository;
        #endregion

        #region Construtor
        public ProfileService(IProfileRepository repository)
        {
            _repository = repository;
        }

        #endregion

        #region Methods

        public async Task<long> UpdateProfile(ProfileRequestModel model, Guid userId)
        {
            var result = await _repository.UpdateProfile(model, userId); ;
            return result;
        }

        #endregion
    }
}