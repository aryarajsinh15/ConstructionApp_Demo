using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.PersonBill;
using ConstructionAPI.Model.SiteBill;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.PersonBill
{
    public interface IPersonBillRepository
    {
        Task<List<PersonBillListResponseModel>> GetPersonBillList(PersonBillListRequestModel model);
        Task<long> DeletePersonBill(System.Guid personBillId, System.Guid userid);
        Task<PersonBillResponseModel> GetPersonBillById(System.Guid personBillId);
        Task<long> SavePersonBill(PersonBillRequestModel model, System.Guid userId);
    }
}
