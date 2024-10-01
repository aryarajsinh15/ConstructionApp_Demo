using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Estimate;
using ConstructionAPI.Model.SiteBill;
using ConstructionAPI.Repository.Repository.Client;
using ConstructionAPI.Repository.Repository.Estimate;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Estimate
{
    public class EstimateService : IEstimateService
    {
        #region Fields
        private readonly IEstimateRepository _repository;
        #endregion

        #region Construtor
        public EstimateService(IEstimateRepository repository)
        {
            _repository = repository;
        }
        #endregion
  

        public async Task<List<EstimateListResponseModel>> GetEstimateList(EstimatePaginationModel model, string clientId)
        {
            return await _repository.GetEstimateList(model, clientId);
        }

        public async Task<long> SaveEstimate(EstimateRequestModel model, Guid userId, string clientId)
        {
            return await _repository.SaveEstimate(model, userId, clientId);
        }


        public async Task<long> SaveEstimateBillWithoutFile(EstimateWithoutFileRequestModel model, Guid userId,string ClientId)
        {
            return await _repository.SaveEstimateBillWithoutFile(model, userId, ClientId);
        }

        public async Task<EstimateBillWithoutFileResponseModel> GetWithoutFileEstimateBillById(string estimateBillId)
        {
            return await _repository.GetWithoutFileEstimateBillById(estimateBillId);
        }


        public async Task<EstimateListResponseModel> ActiveInactiveEstimate(string estimateId, Guid userId)
        {
            return await _repository.ActiveInactiveEstimate(estimateId, userId);
        }

        public async Task<long> DeleteEstimate(Guid EstimateId, Guid userId)
        {
            return await _repository.DeleteEstimate(EstimateId, userId);
        }

        public async Task<EstimateListResponseModel> GetEstimateById(string EstimateId)
        {
            return await _repository.GetEstimateById(EstimateId);
        }



    }
}
