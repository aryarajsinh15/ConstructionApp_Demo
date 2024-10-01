using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.MerchantPayment;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Repository.Repository.Merchant;
using ConstructionAPI.Repository.Repository.MerchantPayment;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.MerchantPayment
{
    public class MerchantPaymentService : IMerchantPaymentService
    {
        #region Fields
        private readonly IMerchantPaymentRepository _merchantPaymentRepository;
        #endregion

        #region Constructor
        public MerchantPaymentService(IMerchantPaymentRepository merchantPaymentRepository)
        {
            _merchantPaymentRepository = merchantPaymentRepository;
        }
        #endregion

        public async Task<ResponseModel> DeleteMerchantPayment(string id)
        {
            return await _merchantPaymentRepository.DeleteMerchantPayment(id);
        }

        public async Task<List<MerchantPaymentResponseModel>> GetMerchantPaymentGetById(string id)
        {
            return await _merchantPaymentRepository.GetMerchantPaymentGetById(id);
        }

        public async Task<List<MerchantPaymentListResponseModel>> GetMerchantPaymentList(MerchantFilterModel model, string clientId)
        {
            return await _merchantPaymentRepository.GetMerchantPaymentList(model, clientId);
        }

        public async Task<ResponseModel> SaveMerchantPayment(MerchantPaymentRequestModel model, string Id, string ClientID)
        {
            return await _merchantPaymentRepository.SaveMerchantPayment(model, Id, ClientID);
        }
    }
}
