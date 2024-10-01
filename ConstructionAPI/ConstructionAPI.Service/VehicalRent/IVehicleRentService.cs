using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.ContractorFinance;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.ReqResponse;
using ConstructionAPI.Model.VehicleRent;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.VehicalRent
{
    public interface IVehicleRentService
    {
        Task<List<VehicleRentResponseModel>> GetVehicleRentList(VehileRentListRequestModel model, string clientId);
        Task<ResponseModel> SaveVehicleRent(VehicleRentRequestModel model, Guid id, System.Guid clientId);
        Task<VehicalRentResponseModel> GetVehicleRentGetById(string id);
        Task<ResponseModel> DeleteVehicleRent(string id);
        Task<List<VehicleOwnerListForRentModel>> GetVehicleOwnerListForRent(string ClientId);
        Task<VehicleRentResponseModel> ActiveInactiveVehicleRent(string VehicleRentId, Guid userId);
        Task<List<VehicleRentResponseModel>> GetVehicleRentListForExport(VehicleRentExportRequestModel model);
        byte[] GenerateVehicleRentListPdf(List<VehicleRentResponseModel> model, string path);
    }
}
