using ConstructionAPI.Model.Challan;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Model.VehicleRent;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Challan
{
    public interface IChallanService
    {
        Task<List<ChallanResponseModel>> GetChallanList(ChallanListRequestModel model, string clientId);

        Task<long> SaveChallan(ChallanRequestModel model, Guid userId, Guid clientId);

        Task<ChallanResponseModel> ActiveInactiveChallan(string challanId, Guid userId);

        Task<long> DeleteChallan(System.Guid challanId, System.Guid userId);

        Task<ChallanResponseModel> GetChallanById(Guid challanId);

        Task<List<MarchantListResponseModel>> GetMarchantList(string ClientId);

        Task<ChallanResponseModel> GetChallanImageName(string challanId);
    }
}
