using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.MerchantPayment;
using ConstructionAPI.Model.ReqResponse;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.MerchantPayment
{
    public class MerchantPaymentRepository:BaseRepository, IMerchantPaymentRepository
    {
        #region Fields        
        #endregion

        #region Constructor
        public MerchantPaymentRepository(IOptions<DataConfig> dataConfig) : base(dataConfig)
        {
        }
        #endregion

        #region Add, Update, Delete, List Methods 
        public async Task<List<MerchantPaymentListResponseModel>> GetMerchantPaymentList(MerchantFilterModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch);
            param.Add("@startDate", model.startDate);
            param.Add("@endDate", model.endDate);
            param.Add("@siteId", model.siteId);
            param.Add("@paymentType", model.paymentType);
            param.Add("@merchantId", model.merchantId);
            param.Add("@clientId", clientId);
            var data = await QueryAsync<MerchantPaymentListResponseModel>(StoreProcedure.GetMerchantPaymentList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
        public async Task<List<MerchantPaymentResponseModel>> GetMerchantPaymentGetById(string id)
        {
            var param = new DynamicParameters();
            param.Add("@Id", id);
            var data = await QueryAsync<MerchantPaymentResponseModel>(StoreProcedure.GetMerchantPaymentById, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
        public async Task<ResponseModel> SaveMerchantPayment(MerchantPaymentRequestModel model, string Id, string ClientID)
        {
            var param = new DynamicParameters();
            param.Add("@MerchantPaymentId", model.MerchantPaymentId);
            param.Add("@PaymentDate", model.PaymentDate);
            param.Add("@ClientId", ClientID);
            param.Add("@SiteId", model.SiteId);
            param.Add("@MerchantId", model.MerchantId);
            param.Add("@Amount", model.Amount);
            param.Add("@PaymentType", model.PaymentType);
            param.Add("@ChequeNo", model.ChequeNo);
            param.Add("@BankName", model.BankName);
            param.Add("@ChequeFor", model.ChequeFor);
            param.Add("@Remarks", model.Remarks);
            param.Add("@CreatedBy", Id);          
            var data = await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.SaveMerchantPayment, param, commandType: CommandType.StoredProcedure);
            return data;
        }
        public async Task<ResponseModel> DeleteMerchantPayment(string id)
        {
            var param = new DynamicParameters();
            param.Add("@Id", id);
            return await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.DeleteMerchantPayment, param, commandType: CommandType.StoredProcedure);
        }
        #endregion
    }
}
