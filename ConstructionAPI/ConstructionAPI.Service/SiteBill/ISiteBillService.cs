using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.SiteBill;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.SiteBill
{
    public interface ISiteBillService
    {
        Task<List<SiteBillListResponseModel>> GetSiteBillList(SiteBillListRequestModel model);
        Task<long> DeleteSiteBill(System.Guid siteBillId, System.Guid userid);
        Task<SiteBillResponseModel> GetSiteBillById(System.Guid siteBillId);
        Task<long> SaveSiteBill(SiteBillRequestModel model, System.Guid userId);
        Task<long> SaveSiteBillWithoutFile(BillPaymentWithoutFileRequestModel model, Guid userId);
        Task<BillPaymentWithoutFileResponseModel> GetWithoutFileSiteBillById(System.Guid siteBillId);
        byte[] GeneratePdf(BillPaymentWithoutFileResponseModel model,string path, ClientResponseModel detail);
    }
}
