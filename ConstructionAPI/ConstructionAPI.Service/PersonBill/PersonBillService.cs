using ConstructionAPI.Model.PersonBill;
using ConstructionAPI.Model.SiteBill;
using ConstructionAPI.Repository.Repository.Expense;
using ConstructionAPI.Repository.Repository.PersonBill;
using ConstructionAPI.Repository.Repository.SiteBill;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.PersonBill
{
    public class PersonBillService : IPersonBillService
    {
        #region Fields
        private readonly IPersonBillRepository _repository;
        #endregion

        #region Construtor
        public PersonBillService(IPersonBillRepository repository)
        {
            _repository = repository;
        }
        #endregion


        public async Task<List<PersonBillListResponseModel>> GetPersonBillList(PersonBillListRequestModel model)
        {
            return await _repository.GetPersonBillList(model);
        }

        public async Task<long> SavePersonBill(PersonBillRequestModel model, Guid userId)
        {
            return await _repository.SavePersonBill(model, userId);
        }

        public async Task<long> DeletePersonBill(Guid personBillId, Guid userid)
        {
            return await _repository.DeletePersonBill(personBillId, userid);
        }

        public async Task<PersonBillResponseModel> GetPersonBillById(Guid personBillId)
        {
            return await _repository.GetPersonBillById(personBillId);
        }
    }
}
