using ConstructionAPI.Repository.Repository.Account;
using ConstructionAPI.Repository.Repository.Challan;
using ConstructionAPI.Repository.Repository.Client;
using ConstructionAPI.Repository.Repository.ContractorFinance;
using ConstructionAPI.Repository.Repository.Dashboard;
using ConstructionAPI.Repository.Repository.Estimate;
using ConstructionAPI.Repository.Repository.Expense;
using ConstructionAPI.Repository.Repository.Merchant;
using ConstructionAPI.Repository.Repository.MerchantPayment;
using ConstructionAPI.Repository.Repository.NewFolder;
using ConstructionAPI.Repository.Repository.Person;
using ConstructionAPI.Repository.Repository.PersonAttendance;
using ConstructionAPI.Repository.Repository.PersonBill;
using ConstructionAPI.Repository.Repository.PersonFinance;
using ConstructionAPI.Repository.Repository.PersonGroup;
using ConstructionAPI.Repository.Repository.Profile;
using ConstructionAPI.Repository.Repository.Site;
using ConstructionAPI.Repository.Repository.SiteBill;
using ConstructionAPI.Repository.Repository.SitePhotoCategory;
using ConstructionAPI.Repository.Repository.User;
using ConstructionAPI.Repository.Repository.VehicalRent;
using ConstructionAPI.Repository.Repository.VehicleOwner;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository
{
    public class RepositoryRegister
    {
        public static Dictionary<Type, Type> GetTypes()
        {
            var dataDictionary = new Dictionary<Type, Type>
            {
                {typeof(IAccountRepository),typeof(AccountRepository) },
                {typeof(ISiteRepository),typeof(SiteRepository) },
                {typeof(IExpenseRepository),typeof(ExpenseRepository) },
                {typeof(IClientRepository),typeof(ClientRepository) },                
                {typeof(IMerchantRepository),typeof(MerchantRepository) },
                {typeof(IMerchantPaymentRepository),typeof(MerchantPaymentRepository) },
                {typeof(IVehicleRentRepository),typeof(VehicleRentRepository) },      
                {typeof(IVehicleOwnerRepository),typeof(VehicleOwnerRepository) },      
                {typeof(IPersonRepository),typeof(PersonsRepository) },
                {typeof(IUserRepository),typeof(UserRespository) },
                {typeof(IContractorFinanceRepository),typeof(ContractorFinanceRepository) }, 
                {typeof(IChallanRepository),typeof(ChallanRepository) },
                {typeof(ISiteBillRepository),typeof(SiteBillRepository) } ,
                {typeof(ISitePhotoCategoryRepository),typeof(SitePhotoCategoryRepository) } ,
                {typeof(IEstimateRepository),typeof(EstimateRepository) } ,
                {typeof(IDashboardRepository),typeof(DashboardRepository) } ,
                {typeof(IProfileRepository),typeof(ProfileRepository) },
                {typeof(IPersonFinanceRepository),typeof(PersonFinanceRepository) },
                {typeof(IPersonBillRepository),typeof(PersonBillRepository) },
                {typeof(IPersonGroupRepository),typeof(PersongroupRepository) },
                {typeof(IPersonAttendanceRepository),typeof(PersonAttendanceRepository) },
            };
            return dataDictionary;
        }
    }
}
