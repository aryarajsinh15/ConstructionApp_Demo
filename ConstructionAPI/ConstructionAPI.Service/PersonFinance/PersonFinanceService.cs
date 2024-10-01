using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.PersonFinance;
using ConstructionAPI.Repository.Repository.Client;
using ConstructionAPI.Repository.Repository.NewFolder;
using ConstructionAPI.Repository.Repository.PersonFinance;
using ConstructionAPI.Service.PersonFinance;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.PersonFinance
{
    public class PersonFinanceService : IPersonFinanceService
    {

        #region Fields
        private readonly IPersonFinanceRepository _repository;
        #endregion

        #region Construtor
        public PersonFinanceService(IPersonFinanceRepository repository)
        {
            _repository = repository;
        }
        #endregion
        public async Task<List<PersonFinanceListResponseModel>> GetPersonFinanceList(PersonFinanceListRequestModel model)
        {
            return await _repository.GetPersonFinanceList(model);
        }

        public async Task<long> DeletePersonFinance(Guid personFinanceId, Guid userId)
        {
            return await _repository.DeletePersonFinance(personFinanceId, userId);
        }

        public async Task<PersonFinanceResponseModel> GetPersonFinanceById(Guid personFinanceId)
        {
            return await _repository.GetPersonFinanceById(personFinanceId);
        }

        public async Task<List<PersonFinanceListResponseModel>> GetPersonFinanceListForExport(string personfinanceId)
        {
            return await _repository.GetPersonFinanceListForExport(personfinanceId);
        }

        public async Task<long> SavePersonFinance(PersonFinanceRequestModel model, Guid userId)
        {
            return await _repository.SavePersonFinance(model, userId);
        }
    }
}
