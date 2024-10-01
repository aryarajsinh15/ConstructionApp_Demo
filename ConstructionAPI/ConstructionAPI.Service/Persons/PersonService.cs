using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Person;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Repository.Repository.Merchant;
using ConstructionAPI.Repository.Repository.Person;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Persons
{
    public class PersonService : IPersonService
    {
        #region Fields
        private readonly IPersonRepository _personRepository;
        #endregion

        #region Constructor
        public PersonService(IPersonRepository personRepository)
        {
            _personRepository = personRepository;
        }
        #endregion
        public async Task<List<PersonResponseModel>> GetPersonList(PersonRequestFilterModel model, string clientId)
        {
            return await _personRepository.GetPersonList(model,clientId);
        }
        public async Task<List<PersonResponseModel>> GetAttendancePersonList(PersonAttedanceRequestFilterModel model, string clientId)
        {
            return await _personRepository.GetAttendancePersonList(model, clientId);
        }

        public async Task<List<PersonDropDownModel>> GetPersonListForDropDown(string clientId, string id)
        {
            return await _personRepository.GetPersonListForDropDown(clientId, id);
        }

        public async Task<PersonResponseModel> GetPersonById(System.Guid id)
        {
            return await _personRepository.GetPersonById(id);
        }

        public async Task<ResponseModel> SavePerson(PersonRequestModel model, string id, string userId)
        {
            return await _personRepository.SavePerson(model, id, userId);
        }

        public async Task<long> DeletePersons(System.Guid id, System.Guid userId)
        {
            return await _personRepository.DeletePersons(id,userId);
        }

        public async Task<List<PersonTypeResponseModel>> GetPersonTypeList()
        {
            return await _personRepository.GetPersonTypeList();
        }

        public async Task<long> ActiveInactivePerson(CommonActiveModel model)
        {
           return await _personRepository.ActiveInactivePerson(model);
        }

        public async Task<ResponseModel> SaveAttendantPerson(AttendantPersonRequestModel model, string id, string userId)
        {
            return await _personRepository.SaveAttendantPerson(model, id, userId);
        }
    }
}
