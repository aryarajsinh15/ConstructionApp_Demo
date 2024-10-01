using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.PersonFinance;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.PersonFinance
{
    public interface IPersonFinanceRepository
    {
        Task<List<PersonFinanceListResponseModel>> GetPersonFinanceList(PersonFinanceListRequestModel model);
        Task<List<PersonFinanceListResponseModel>> GetPersonFinanceListForExport(string personfinanceId);

        Task<long> DeletePersonFinance(System.Guid personFinanceId, System.Guid userId);
        Task<PersonFinanceResponseModel> GetPersonFinanceById(System.Guid personFinanceId);
        Task<long> SavePersonFinance(PersonFinanceRequestModel model, System.Guid userId);

    }
}
