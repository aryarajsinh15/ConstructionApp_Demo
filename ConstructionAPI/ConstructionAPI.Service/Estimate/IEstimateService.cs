using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Estimate;
using ConstructionAPI.Model.SiteBill;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Estimate
{
    public interface IEstimateService
    {
        Task<List<EstimateListResponseModel>> GetEstimateList(EstimatePaginationModel model, string clientId);

        Task<long> SaveEstimate(EstimateRequestModel model, Guid userId, string clientId);

        Task<EstimateListResponseModel> GetEstimateById(string EstimateId);

        Task<long> DeleteEstimate(Guid EstimateId, Guid userId);

        Task<EstimateListResponseModel> ActiveInactiveEstimate(string estimateId, Guid userId);

        Task<long> SaveEstimateBillWithoutFile(EstimateWithoutFileRequestModel model, Guid userId, string ClientId);

        Task<EstimateBillWithoutFileResponseModel> GetWithoutFileEstimateBillById(string estimateBillId);

    }
}
