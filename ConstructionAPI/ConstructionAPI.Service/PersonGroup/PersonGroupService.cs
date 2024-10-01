using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.PersonGroup;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Repository.Repository.PersonGroup;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.PersonGroup
{
    public class PersonGroupService : IPersonGroupService
    {
        #region Fields
        private readonly IPersonGroupRepository _personGroupRepository;
        #endregion

        #region Constructor
        public PersonGroupService( IPersonGroupRepository personGroupRepository )
        {
            _personGroupRepository = personGroupRepository;
        }
        #endregion

        #region Methods
        public async Task<List<PersonGroupListResponseModel>> GetGroupList(CommonPaginationModel model, string clientId)
        {
            return await _personGroupRepository.GetGroupList( model, clientId);
        }

        public async Task<ResponseModel> SavePersonGroup(PersonGroupRequestModel model, System.Guid id, System.Guid ClientId)
        {
            return await _personGroupRepository.SavePersonGroup( model, id, ClientId);
        }

        public async Task<int> DeletePersonGroup(System.Guid groupId, System.Guid clientId)
        {
            return await _personGroupRepository.DeletePersonGroup( groupId, clientId);  
        }

        public async Task<ResponseModel> ActiveInactivePersonGroup(string id, System.Guid userId)
        {
            return await _personGroupRepository.ActiveInactivePersonGroup( id, userId);
        }

        #endregion
    }
}
