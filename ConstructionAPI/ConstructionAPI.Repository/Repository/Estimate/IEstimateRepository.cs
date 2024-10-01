using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Estimate;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Estimate
{
    public interface IEstimateRepository
    {
        Task<List<EstimateListResponseModel>> GetEstimateList(EstimatePaginationModel model, string clientId);

        Task<long> SaveEstimate(EstimateRequestModel model, Guid userId, string clientId);

        Task<EstimateListResponseModel> ActiveInactiveEstimate(string EstimateId, Guid userId);
        
        Task<long> DeleteEstimate(Guid EstimateId, Guid userId);
        
        Task<EstimateListResponseModel> GetEstimateById(string EstimateId);

        Task<long> SaveEstimateBillWithoutFile(EstimateWithoutFileRequestModel model, Guid userId,string ClientId);

        Task<EstimateBillWithoutFileResponseModel> GetWithoutFileEstimateBillById(string estimateBillId);

    }
}
