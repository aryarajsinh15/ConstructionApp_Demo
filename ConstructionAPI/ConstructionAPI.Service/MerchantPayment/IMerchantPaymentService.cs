using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.MerchantPayment;
using ConstructionAPI.Model.ReqResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.MerchantPayment
{
    public interface IMerchantPaymentService
    {
        public Task<List<MerchantPaymentListResponseModel>> GetMerchantPaymentList(MerchantFilterModel model, string clientId);
        public Task<List<MerchantPaymentResponseModel>> GetMerchantPaymentGetById(string id);
        public Task<ResponseModel> SaveMerchantPayment(MerchantPaymentRequestModel model, string Id, string ClientID);
        public Task<ResponseModel> DeleteMerchantPayment(string id);
    }
}
