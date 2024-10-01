using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Person;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Model.Site;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Persons
{
    public interface IPersonService
    {
        Task<List<PersonResponseModel>> GetPersonList(PersonRequestFilterModel model,string clientId);
        Task<List<PersonResponseModel>> GetAttendancePersonList(PersonAttedanceRequestFilterModel model,string clientId);
        Task<List<PersonDropDownModel>> GetPersonListForDropDown(string clientId, string id);
        Task<PersonResponseModel> GetPersonById(System.Guid id);
        Task<ResponseModel> SavePerson(PersonRequestModel model, string id, string userId);
        Task<ResponseModel> SaveAttendantPerson(AttendantPersonRequestModel model, string id, string userId);
        Task<long> DeletePersons(System.Guid id, System.Guid userId);
        Task<List<PersonTypeResponseModel>> GetPersonTypeList();
        Task<long> ActiveInactivePerson(CommonActiveModel model);
    }
}
