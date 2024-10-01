using ConstructionAPI.Model.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.MerchantPayment
{
    public class MerchantPaymentRequestModel
    {
        public string? MerchantPaymentId { get; set; }
        public DateTime PaymentDate { get; set; }
        public string? SiteId { get; set; }
        public string? MerchantId { get; set; }
        public decimal Amount { get; set; }
        public string? PaymentType { get; set; }
        public string? ChequeNo { get; set; }
        public string? BankName { get; set; }   
        public string? ChequeFor { get; set; }
        public string? Remarks { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string? Status { get; set; }
    }

    public class MerchantFilterModel : CommonPaginationModel
    {
        public DateTime? startDate { get; set; }
        public DateTime? endDate { get; set; }
        public string? siteId { get; set; }
        public string? paymentType { get; set; }
        public string? merchantId { get; set; }
    }
}
