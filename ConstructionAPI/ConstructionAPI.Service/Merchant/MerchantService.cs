using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Repository.Repository.Merchant;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Merchant
{
    public class MerchantService :IMerchantService
    {
        #region Fields
        private readonly IMerchantRepository _merchantRepository;
        #endregion

        #region Constructor
        public MerchantService(IMerchantRepository tbl_merchantRepository)
        {
            _merchantRepository = tbl_merchantRepository;
        }
        #endregion

        #region Methods
        public async Task<List<MerchantResponseModel>> GetMerchantList(CommonPaginationModel model, string clientId)
        {
            return await _merchantRepository.GetMerchantList(model, clientId);
        }

        public async Task<List<MerchantListDropDownModel>> GetMerchantListForDropDown(string clientId)
        {
            return await _merchantRepository.GetMerchantListForDropDown(clientId);
        }

        public async Task<ResponseModel> SaveMerchant(MerchantRequestModel model, Guid id, string ClientId)
        {
            return await _merchantRepository.SaveMerchant(model,id, ClientId);
        }

        public async Task<List<MerchantResponseModel>> GetMerchantGetById(string id)
        {
            return await _merchantRepository.GetMerchantGetById(id);
        }

        public async Task<ResponseModel> DeleteMerchant(string id)
        {
            return await _merchantRepository.DeleteMerchant(id);
        }

        public async Task<List<ClientResponseModel>> GetClientList()
        {
            return await _merchantRepository.GetClientList();
        }

        public async Task<MerchantResponseModel> ActiveInactiveMerchant(string marchantId, Guid userId)
        {
            return await _merchantRepository.ActiveInactiveMerchant(marchantId, userId);
        }
        #endregion
    }
}
