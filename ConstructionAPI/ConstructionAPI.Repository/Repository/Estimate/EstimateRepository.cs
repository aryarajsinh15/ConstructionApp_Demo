using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Estimate;
using ConstructionAPI.Model.SiteBill;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Estimate
{
    public class EstimateRepository : BaseRepository, IEstimateRepository
    {
        public EstimateRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<List<EstimateListResponseModel>> GetEstimateList(EstimatePaginationModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@clientId", clientId);
            param.Add("@startDate", model.StartDate);
            param.Add("@endDate", model.EndDate);
            param.Add("@clientId", clientId);
            var data = await QueryAsync<EstimateListResponseModel>(StoreProcedure.GetEstimateList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<EstimateListResponseModel> ActiveInactiveEstimate(string EstimateId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@EstimateId", EstimateId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<EstimateListResponseModel>(StoreProcedure.ActiveInActiveEstimate, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> DeleteEstimate(Guid EstimateId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@EstimateId", EstimateId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteEstimate, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<EstimateListResponseModel> GetEstimateById(string EstimateId)
        {
            var param = new DynamicParameters();
            param.Add("@EstimateId", EstimateId);
            return await QueryFirstOrDefaultAsync<EstimateListResponseModel>(StoreProcedure.GetEstimateById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> SaveEstimate(EstimateRequestModel model, Guid userId, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@EstimateId", model.EstimateId);
            param.Add("@EstimateDate", model.EstimateDate);
            param.Add("@PartyName", model.PartyName);
            param.Add("@TotalAmount", model.TotalAmount);
            param.Add("@Remarks", model.Remarks);
            param.Add("@ClientId", clientId);
            param.Add("@CreatedBy", userId);
            param.Add("@EstimateOriginalFileName", model.EstimatePhotoName);
            param.Add("@EstimateNewFileName", model.EstimateNewPhotoName);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveEstimate, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> SaveEstimateBillWithoutFile(EstimateWithoutFileRequestModel model, Guid userId, string ClientId)
        {
            var param = new DynamicParameters();
            param.Add("@estimateId", model.estimateId);
            param.Add("@estimateBillDate", model.estimateBillDate);
            param.Add("@partyName", model.PartyName);
            param.Add("@remarks", model.Remarks);
            param.Add("@itemTotal", model.finalTotal);
            param.Add("@clientId", ClientId);
            param.Add("@createdBy", userId);

            DataTable itemsDetail = new DataTable("tbl_BillEstimateItemDetails");
            itemsDetail.Columns.Add("BillEstimateItemId");
            itemsDetail.Columns.Add("Name");
            itemsDetail.Columns.Add("Nos");
            itemsDetail.Columns.Add("Quantity");
            itemsDetail.Columns.Add("Rate");
            itemsDetail.Columns.Add("TotalAmount");
            if (model.ItemsDetails != null && model.ItemsDetails.Count > 0)
            {
                foreach (var item in model.ItemsDetails)
                {
                        DataRow dtRow = itemsDetail.NewRow();   
                        dtRow["BillEstimateItemId"] = item.BillEstimateItemId;
                        dtRow["Name"] = item.Name;
                        dtRow["Nos"] = item.Nos;
                        dtRow["Quantity"] = item.Nos;
                        dtRow["Rate"] = item.Rate;
                        dtRow["TotalAmount"] = item.total;
                    itemsDetail.Rows.Add(dtRow);
                }
            }

            param.Add("@billEstimateItemDetails", itemsDetail.AsTableValuedParameter("[dbo].[tbl_BillEstimateItemDetails]"));
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveEstimateBillWithoutFile, param, commandType: CommandType.StoredProcedure);
        }



        public async Task<EstimateBillWithoutFileResponseModel> GetWithoutFileEstimateBillById(string estimateBillId)
        {
            EstimateBillWithoutFileResponseModel result = new EstimateBillWithoutFileResponseModel();
            var param = new DynamicParameters();
            param.Add("@EstimateBillId", estimateBillId);
            string DecryptedConn = EncryptionDecryption.GetDecrypt(_connectionString.Value.DefaultConnection);
            SqlConnection con = new SqlConnection(DecryptedConn);
            using (var multi = await con.QueryMultipleAsync(StoreProcedure.GetEstimateBillWithoutFileDetail, param, commandType: CommandType.StoredProcedure))
            {
                result = multi.Read<EstimateBillWithoutFileResponseModel>().FirstOrDefault();
                if (result != null)
                {
                    result.ItemsDetails = multi.Read<ItemDetailsRes>().ToList();
                    for (int i = 0; i < result.ItemsDetails.Count; i++)
                    {
                        result.ItemsDetails.Where(x => x.estimateId == result.ItemsDetails[i].BillEstimateItemId).ToList();
                    }
                }


            }
            return result;
        }
    }
}
