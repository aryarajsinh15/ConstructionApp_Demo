using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.PersonGroup;
using ConstructionAPI.Model.ReqResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.PersonGroup
{
    public interface IPersonGroupRepository
    {
        Task<List<PersonGroupListResponseModel>> GetGroupList(CommonPaginationModel model, string clientId);
        Task<ResponseModel> SavePersonGroup(PersonGroupRequestModel model, System.Guid id, System.Guid clientId);
        Task<int> DeletePersonGroup(System.Guid groupId, System.Guid clientId);
        Task<ResponseModel> ActiveInactivePersonGroup(string id, System.Guid userId);
    }
}
