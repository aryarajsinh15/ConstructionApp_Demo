using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Expense;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Model.SiteBill;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.SiteBill
{
    public class SiteBillRepository : BaseRepository, ISiteBillRepository
    {
        public SiteBillRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<long> DeleteSiteBill(Guid siteBillId, Guid userid)
        {
            var param = new DynamicParameters();
            param.Add("@billId", siteBillId);
            param.Add("@userId", userid);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteSiteBill, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<SiteBillResponseModel> GetSiteBillById(Guid siteBillId)
        {
            var param = new DynamicParameters();
            param.Add("@billId", siteBillId);
            return await QueryFirstOrDefaultAsync<SiteBillResponseModel>(StoreProcedure.GetSiteBillById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<SiteBillListResponseModel>> GetSiteBillList(SiteBillListRequestModel model)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@siteId", model.SiteId);
            var data = await QueryAsync<SiteBillListResponseModel>(StoreProcedure.GetSiteBillList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SaveSiteBill(SiteBillRequestModel model, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@billId", model.SiteBillId);
            param.Add("@billDate", model.BillDate);
            param.Add("@billNo", model.BillNo);
            param.Add("@siteId", model.SiteId);
            param.Add("@totalAmount", model.TotalAmount);
            param.Add("@remarks", model.Remarks);
            param.Add("@billOriginalFileName", model.SiteBillFileName);
            param.Add("@billNewFileName", model.SiteBillNewFileName);
            param.Add("@createdBy", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveSiteBill, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> SaveSiteBillWithoutFile(BillPaymentWithoutFileRequestModel model, Guid userId)
        {
            DataTable items = new DataTable("tbl_BillSiteItem");
            items.Columns.Add("BillSiteItemId");
            items.Columns.Add("ItemName");
            items.Columns.Add("Rate");
            if (model.Items != null && model.Items.Count > 0)
            {
                foreach (var item in model.Items)
                {
                    DataRow dtRow = items.NewRow();
                    if (item.Description != null || item.Description != "")
                    {
                        dtRow["BillSiteItemId"] = item.BillSiteItemId;
                        dtRow["ItemName"] = item.Description;
                        dtRow["Rate"] = item.Rate;
                    }
                    items.Rows.Add(dtRow);
                }
            }
            DataTable itemsDetail = new DataTable("tbl_BillSiteItemDetails");
            itemsDetail.Columns.Add("BillSiteItemId");
            itemsDetail.Columns.Add("Description");
            itemsDetail.Columns.Add("IsSubItem");
            itemsDetail.Columns.Add("IsTotalItem");
            itemsDetail.Columns.Add("MainItemPKId");
            itemsDetail.Columns.Add("ItemCategory");
            itemsDetail.Columns.Add("ItemName");
            itemsDetail.Columns.Add("ItemType");
            itemsDetail.Columns.Add("Qty");
            itemsDetail.Columns.Add("Length");
            itemsDetail.Columns.Add("Height");
            itemsDetail.Columns.Add("Width");
            itemsDetail.Columns.Add("Area");
            if (model.Items != null && model.Items.Count > 0)
            {
                foreach (var item in model.Items)
                {
                    
                    foreach (var detail in item.ItemDetail)
                    {
                        DataRow dtRow = itemsDetail.NewRow();
                        dtRow["BillSiteItemId"] = detail.BillSiteItemId;
                        dtRow["Description"] = item.Description;
                        dtRow["IsSubItem"] = true;
                        dtRow["IsTotalItem"] = false;
                        dtRow["MainItemPKId"] = null;
                        dtRow["ItemCategory"] = detail.Type.Contains("+") ? "Plus" : "Less";
                        dtRow["ItemName"] = detail.Name;
                        dtRow["ItemType"] = detail.Type.Split("(")[0];
                        dtRow["Qty"] = detail.Quantity;
                        dtRow["Length"] = detail.Length;
                        dtRow["Height"] = detail.Height;
                        dtRow["Width"] = detail.Width;
                        dtRow["Area"] = detail.ItemDetailTotal;
                        itemsDetail.Rows.Add(dtRow);
                    }
                }
            }


            var param = new DynamicParameters();
            param.Add("@billId", model.BillPaymentId);
            param.Add("@billDate", model.BillDate);
            param.Add("@billNo", model.BillNumber);
            param.Add("@siteId", model.SiteId);
            param.Add("@remarks", model.Remarks);
            param.Add("@billSiteItem", items.AsTableValuedParameter("[dbo].[tbl_BillSiteItem]"));
            param.Add("@billSiteItemDetails", itemsDetail.AsTableValuedParameter("[dbo].[tbl_BillSiteItemDetails]"));
            param.Add("@createdBy", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveSiteBillWithoutFile, param, commandType: CommandType.StoredProcedure);

        }

        public async Task<BillPaymentWithoutFileResponseModel> GetWithoutFileSiteBillById(Guid siteBillId)
        {
            BillPaymentWithoutFileResponseModel result = new BillPaymentWithoutFileResponseModel();
            var param = new DynamicParameters();
            param.Add("@billId", siteBillId);
            string DecryptedConn = EncryptionDecryption.GetDecrypt(_connectionString.Value.DefaultConnection);
            SqlConnection con = new SqlConnection(DecryptedConn);
            using (var multi = await con.QueryMultipleAsync(StoreProcedure.GetSiteBillWithoutFileDetail, param, commandType: CommandType.StoredProcedure))
            {
                result = multi.Read<BillPaymentWithoutFileResponseModel>().FirstOrDefault();
                if(result != null)
                {
                    result.items = multi.Read<Items>().ToList();
                    var itemDetail = multi.Read<ItemDetailResponse>().ToList();
                    for (int i = 0; i < result.items.Count; i++)
                    {
                        result.items[i].itemDetails = itemDetail.Where(x => x.MainItemPKId == result.items[i].BillSiteItemId).ToList();
                    }
                }
                 

            }
            return result;
        }
    }
}
