using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.PersonFinance
{
    public class PersonFinanceResponseModel
    {
        public System.Guid FinanceId { get; set; }
        public System.Guid PersonId { get; set; }
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
    public class PersonFinanceListResponseModel
    {
        public System.Guid PersonFinanceId { get; set;}
        public System.Guid PersonId { get; set;}
        public string PersonName { get; set;}
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
    }
}
