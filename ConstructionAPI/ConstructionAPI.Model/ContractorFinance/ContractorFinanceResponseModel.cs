using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.ContractorFinance
{
    public class ContractorFinanceResponseModel
    {
        public System.Guid ContractorFinanceId { get; set; }
        public System.Guid SiteId { get; set; }
        public string SiteName { get; set; }
        public System.Guid UserId { get; set; }
        public DateTime SelectedDate { get; set; }
        public Decimal Amount { get; set; }
        public string CreditOrDebit { get; set; }
        public string PaymentType { get; set; }
        public string ChequeNo { get; set; }
        public string BankName { get; set; }
        public string ChequeFor { get; set; }
        public string Remarks { get; set; }
        public string UserName { get; set; }
        public bool IsActive { get; set; }
    }
    public class ContractorFinanceListResponseModel
    {
        public System.Guid ContractorFinanceId { get; set;}
        public System.Guid SiteId { get; set;}
        public string SiteName { get; set;}
        public System.Guid UserId { get; set;}
        public DateTime SelectedDate { get; set;}
        public Decimal Amount { get; set;}
        public string CreditOrDebit { get; set;}
        public string PaymentType { get; set;}
        public string ChequeNo { get; set;}
        public string BankName { get; set;}
        public string ChequeFor { get; set;}
        public string Remarks { get; set;}
        public string UserName { get; set;}
        public bool IsActive { get; set; }
        public long TotalRecords { get; set;}
        public decimal? TotalAmount { get;set;}
    }
}
