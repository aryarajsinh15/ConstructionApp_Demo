using ConstructionAPI.Repository.Repository.Expense;
using ConstructionAPI.Service.Account;
using ConstructionAPI.Service.Challan;
using ConstructionAPI.Service.Client;
using ConstructionAPI.Service.ContractorFinance;
using ConstructionAPI.Service.Dashboard;
using ConstructionAPI.Service.Estimate;
using ConstructionAPI.Service.Expense;
using ConstructionAPI.Service.JWTAuthentication;
using ConstructionAPI.Service.Merchant;
using ConstructionAPI.Service.MerchantPayment;
using ConstructionAPI.Service.PersonAttendance;
using ConstructionAPI.Service.PersonBill;
using ConstructionAPI.Service.PersonFinance;
using ConstructionAPI.Service.PersonGroup;
using ConstructionAPI.Service.Persons;
using ConstructionAPI.Service.Profile;
using ConstructionAPI.Service.Site;
using ConstructionAPI.Service.SiteBill;
using ConstructionAPI.Service.SitePhotoCategory;
using ConstructionAPI.Service.User;
using ConstructionAPI.Service.VehicalRent;
using ConstructionAPI.Service.VehicleOwner;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service
{
    public class ServiceRegister
    {
        public static Dictionary<Type, Type> GetTypes()
        {
            var dataDictionary = new Dictionary<Type, Type>
            {
                {typeof(IAccountService),typeof(AccountService) },
                {typeof(IJWTAuthenticationService),typeof(JWTAuthenticationService) },
                {typeof(IExpenseService),typeof(ExpenseService) },
                {typeof(ISiteService),typeof(SiteService) },
                {typeof(IClientService),typeof(ClientService) },
                {typeof(IMerchantService),typeof(MerchantService) },
                {typeof(IMerchantPaymentService),typeof(MerchantPaymentService) },
                {typeof(IVehicleOwnerService),typeof(VehicleOwnerService) },
                {typeof(IPersonService),typeof(PersonService) },
                {typeof(IVehicleRentService),typeof(VehicleRentService) },
                {typeof(IUserService),typeof(UserService) },
                {typeof(IContractorFinanceService),typeof(ContractorFinanceService) },
                {typeof(IChallanService),typeof(ChallanService) },
                {typeof(ISiteBillService),typeof(SiteBillService) },
                {typeof(ISitePhotoCategoryService),typeof(SitePhotoCategoryService) },
                {typeof(IDashboardService),typeof(DashboardService) },
                {typeof(IPersonGroupService),typeof(PersonGroupService) },
                {typeof(IProfileService),typeof(ProfileService) },
                {typeof(IEstimateService),typeof(EstimateService) },
                {typeof(IPersonFinanceService),typeof(PersonFinanceService) },
                {typeof(IPersonBillService),typeof(PersonBillService) },
                {typeof(IPersonAttendanceService),typeof(PersonAttendanceService) },
            };
            return dataDictionary;
        }
    }
}
