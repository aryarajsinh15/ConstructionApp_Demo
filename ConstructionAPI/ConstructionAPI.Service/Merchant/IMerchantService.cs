using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.ReqResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Merchant
{
    public interface IMerchantService
    {
        Task<List<MerchantResponseModel>> GetMerchantList(CommonPaginationModel model, string clientId);

        Task<List<MerchantListDropDownModel>> GetMerchantListForDropDown(string clientId);

        Task<ResponseModel> SaveMerchant(MerchantRequestModel model, Guid id, string clientId);

        Task<List<MerchantResponseModel>> GetMerchantGetById(string id);

        Task<ResponseModel> DeleteMerchant(string id);

        Task<List<ClientResponseModel>> GetClientList();

        Task<MerchantResponseModel> ActiveInactiveMerchant(string merchantId, System.Guid userId);
    }
}
