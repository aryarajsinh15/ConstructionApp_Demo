using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.PersonFinance
{
    public class PersonFinanceRequestModel
    {
        public string? PersonFinanceId { get; set;}
        public string PersonId { get; set;}
        public string UserId { get; set;}
        public DateTime SelectedDate { get; set;}
        public Decimal Amount { get; set;}
        public string? CreditOrDebit { get; set;}
        public string PaymentType { get; set;}
        public string? ChequeNo { get; set;}
        public string? BankName { get; set;}
        public string? ChequeFor { get; set;}
        public string? Remarks { get; set;}
    }
}
