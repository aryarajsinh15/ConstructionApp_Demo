using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.SiteBill;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.SiteBill
{
    public interface ISiteBillRepository
    {
        Task<List<SiteBillListResponseModel>> GetSiteBillList(SiteBillListRequestModel model);
        Task<long> DeleteSiteBill(System.Guid siteBillId, System.Guid userid);
        Task<SiteBillResponseModel> GetSiteBillById(System.Guid siteBillId);
        Task<long> SaveSiteBill(SiteBillRequestModel model, System.Guid userId);
        Task<long> SaveSiteBillWithoutFile(BillPaymentWithoutFileRequestModel model, Guid userId);
        Task<BillPaymentWithoutFileResponseModel> GetWithoutFileSiteBillById(System.Guid siteBillId);

    }
}
