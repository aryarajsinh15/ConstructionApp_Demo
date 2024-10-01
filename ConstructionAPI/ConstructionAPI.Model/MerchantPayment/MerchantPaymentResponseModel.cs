using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.MerchantPayment
{
    public class MerchantPaymentResponseModel
    {
        public System.Guid MerchantPaymentId {get; set;}
        public DateTime PaymentDate { get; set; }       
        public System.Guid? SiteId { get; set; }
        public System.Guid MerchantId { get; set; }
        public decimal Amount { get; set; }
        public string? PaymentType { get; set; }
        public string? ChequeNo { get; set; }
        public string? BankName { get; set; }
        public string? ChequeFor { get; set; }
        public string? Remarks { get; set; }
        public string? CreatedBy { get; set; }
        public string? CreatedDate { get; set; }
        public string? Status { get; set; }
    }
    public class MerchantPaymentListResponseModel
    {
        public System.Guid MerchantPaymentId { get; set; }
        public DateTime PaymentDate { get; set; }
        public string SiteName { get; set; }
        public string? MerchantName { get; set; }
        public decimal Amount { get; set; }
        public string PaymentType { get; set; }
        public string ChequeNo { get; set; }
        public string ChequeFor { get; set; }
        public string BankName { get; set; }
        public long TotalRecords { get; set; } 
        public long SrNo { get; set; }
    }
}
