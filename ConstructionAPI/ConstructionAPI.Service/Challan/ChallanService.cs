using ConstructionAPI.Model.Challan;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Model.VehicleRent;
using ConstructionAPI.Repository.Repository.Challan;
using ConstructionAPI.Repository.Repository.Merchant;
using ConstructionAPI.Repository.Repository.VehicalRent;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Challan
{
    public class ChallanService : IChallanService
    {
        #region Fields
        private readonly IChallanRepository _challanRepository;
        #endregion

        #region Constructor
        public ChallanService(IChallanRepository challanRepository)
        {
            _challanRepository = challanRepository;
        }
        #endregion

        #region Methods
        public async Task<List<ChallanResponseModel>> GetChallanList(ChallanListRequestModel model, string clientId)
        {
            return await _challanRepository.GetChallanList(model, clientId);
        }

        public async Task<long> SaveChallan(ChallanRequestModel model, Guid userId, Guid clientId)
        {
            return await _challanRepository.SaveChallan(model, userId, clientId);
        }

        public async Task<long> DeleteChallan(System.Guid challanId, System.Guid userId)
        {
            return await _challanRepository.DeleteChallan(challanId, userId);
        }

        public async Task<ChallanResponseModel> GetChallanById(Guid challanId)
        {
            return await _challanRepository.GetChallanById(challanId);
        }
        public async Task<ChallanResponseModel> ActiveInactiveChallan(string challanId, Guid userId)
        {
            return await _challanRepository.ActiveInactiveChallan(challanId, userId);
        }

        public async Task<List<MarchantListResponseModel>> GetMarchantList(string ClientId)
        {
            return await _challanRepository.GetMarchantList(ClientId);
        }

        public async Task<ChallanResponseModel> GetChallanImageName(string challanId)
        {
            return await _challanRepository.GetChallanImageName(challanId);
        }
        #endregion
    }
}
