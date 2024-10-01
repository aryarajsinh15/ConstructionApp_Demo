using ConstructionAPI.Model.PersonBill;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.PersonBill
{
    public interface IPersonBillService
    {
        Task<List<PersonBillListResponseModel>> GetPersonBillList(PersonBillListRequestModel model);
        Task<long> DeletePersonBill(System.Guid PersonBillId, System.Guid userid);
        Task<PersonBillResponseModel> GetPersonBillById(System.Guid PersonBillId);
        Task<long> SavePersonBill(PersonBillRequestModel model, System.Guid userId);
    }
}
