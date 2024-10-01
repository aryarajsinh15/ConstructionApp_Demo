using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Common.Helper
{
    public class StoreProcedure
    {
        #region Common
        public const string ActiveInactiveRecord = "SP_ActiveInactiveRecord";
        #endregion
        #region Login
        public const string LoginUser = "SP_UserLogin";
        public const string UpdateLoginToken = "SP_UpdateLoginToken";
        public const string UpdateUserPassword = "SP_ChangePassword";
        public const string ValidateToken = "Sp_validatetoken";

        #endregion

        #region Site
        public const string SaveSite = "SP_AddEditSite";
        public const string SaveSitePhoto = "SP_SaveSiteImages";
        public const string GetSitePhoto = "SP_GetCategoryListForSite";
        public const string DeleteSitePhoto = "SP_DeleteSitePhoto";
        public const string GetSiteById = "SP_GetSiteById";
        public const string DeleteSite = "SP_DeleteSite";
        public const string ActiveInActiveSite = "SP_ActiveInactiveSite";
        public const string ActiveSiteList = "SP_ActiveSiteList";
        public const string GetSiteList = "SP_SiteList_V2";
        #endregion

        #region Merchant
        public const string SaveMerchant = "SP_AddEditMerchant";
        public const string GetMerchantById = "SP_GetMerchantById";
        public const string DeleteMerchant = "SP_DeleteMerchant";
        public const string GetMerchantList = "SP_MerchantList";
        public const string GetMerchantListForDropDown = "SP_MerchantListForDropDown";
        public const string GetActiveClientList = "SP_GetActiveClient";
        public const string ActiveInActiveExpense = "SP_ActiveInactiveExpense";
        public const string ActiveInActiveMerchant = "SP_ActiveInactiveMerchant";
        #endregion

        #region VehicleRent
        public const string SaveVehicleRent = "SP_AddEditVehicleRent";
        public const string GetVehicleRentById = "SP_GetVehicleRentById";
        public const string DeleteVehicleRent = "SP_DeleteVehicleRent";
        public const string GetVehicleRentList = "SP_VehicleRentList";
        public const string GetVehicleOwnerRentList = "SP_VehicleOwnerListForRent";
        public const string VehicleRentInActive = "SP_VehicleRentActiveInActive";
        public const string GetVehicleRentListForExport = "SP_VehicleRentListForExport";
        #endregion

        #region Challan
        public const string SaveChallan = "SP_AddEdit_Challan";
        public const string GetChallanById = "SP_GetChallanDetailById";
        public const string DeleteChallan = "SP_DeleteChallan";
        public const string GetChallanList = "SP_Challan_List";
        public const string ChallanInActive = "SP_ActiveInActive_Challan";
        public const string GetMarchantList = "SP_GetMarchantList";
        public const string GetChallanImage = "SP_GetChallanImageName";
        #endregion

        #region Expense
        public const string GetExpenseTypeList = "SP_GetSiteTypeList";
        public const string GetExpenseList = "SP_GetExpenseList";
        public const string DeleteExpense = "SP_DeleteExpense";
        public const string SaveExpense = "SP_SaveExpense";
        public const string GetExpenseById = "SP_GetExpenseDetailById";
        public const string GetExpenseListForExport = "SP_ExpenseListForExport";
        #endregion

        #region Client
        public const string GetClientList = "SP_ClientList";
        public const string DeleteClientList = "SP_DeleteClient";
        public const string GetClientById = "SP_GetClientDetailById";
        public const string ActiveInActiveClient = "SP_ActiveInactiveClient";
        public const string SaveClient = "SP_SaveClient";
        public const string GetPackageTypeList = "SP_GetPackageTypeList";

        #endregion

        #region Person
        public const string SavePerson = "SP_AddEditPerson";
        public const string SaveAttendantPerson = "SP_AddEditAttendantPerson";
        public const string GetPersonById = "SP_GetPersonById";
        public const string DeletePerson = "SP_DeletePerson";
        public const string GetPersontList = "SP_GetPersonList";
        public const string GetAttendancePersontList = "SP_GetAttendedPersonList";
        public const string GetPersontListForDropDown = "SP_GetPersonListForDropDown";
        public const string GetActivePersonTypeList = "SP_GetActivePersonTypeList";
        public const string ActiveInActivePerson = "SP_ActiveInactivePerson";
        #endregion

        #region VehicleOwner
        public const string GetVehicleOwnerList = "SP_VehicleOwnerList";
        public const string DeleteVehicleOwnerList = "SP_DeleteVehicleOwner";
        public const string GetVehicleOwnerById = "SP_GetVehicleOwnerDetailById";
        public const string ActiveInActiveVehicleOwner = "SP_ActiveInactiveVehicleOwner";
        public const string SaveVehicleOwner = "SP_SaveVehicleOwner";
        #endregion

        #region Estimate
        public const string GetEstimateList = "SP_EstimateList";
        public const string SaveEstimate = "SP_AddEditEstimate";
        public const string GetEstimateById = "SP_GetEstimateById";
        public const string DeleteEstimate = "SP_DeleteEstimate";
        public const string ActiveInActiveEstimate = "SP_ActiveInactiveEstimate";
        public const string SaveEstimateBillWithoutFile = "SP_AddEstimateBillWithoutFile";
        public const string GetEstimateBillWithoutFileDetail = "SP_GetWithoutFileEstimateBillDetail";

        #endregion

        #region User
        public const string GetUserList = "SP_UserList";
        public const string ActiveInActiveUser = "SP_ActiveInactiveUser";
        public const string DeleteUser = "SP_DeleteUser";
        public const string GetUserById = "SP_GetUserDetailById";
        public const string SaveUser = "SP_SaveUser";
        public const string ActiveUserList = "SP_GetActiveUserList";

        #endregion

        #region ContractorFinance
        public const string GetContractorFinanceList = "SP_ContractorFinaceList";
        public const string GetContractorFinanceListForExport = "SP_ContractorFinaceListForExport";
        public const string DeleteContractorFinance = "SP_DeleteContractFinance";
        public const string GetContractorFinanceById = "SP_GetContractorFinaceById";
        public const string SaveContractorFinance = "SP_SaveContractorFinance";

        #endregion

        #region Person Finance
        public const string GetPersonFinanceList = "SP_PersonFinaceList";
        public const string GetPersonFinanceListForExport = "SP_PersonFinaceListForExport";
        public const string DeletePersonFinance = "SP_DeletePersonFinance";
        public const string GetPersonFinanceById = "SP_GetPersonFinanceById";
        public const string SavePersonFinance = "SP_SavePersonFinance";
        #endregion

        #region MerchantPayment
        public const string SaveMerchantPayment = "SP_AddEditMerchantPayment";
        public const string GetMerchantPaymentById = "SP_GetMerchantPaymentById";
        public const string DeleteMerchantPayment = "SP_DeleteMerchantPayment";
        public const string GetMerchantPaymentList = "SP_MerchantListPayment";
        #endregion

        #region SiteBill
        public const string GetSiteBillList = "SP_GetSiteBillList";
        public const string DeleteSiteBill = "SP_DeleteSiteBill";
        public const string GetSiteBillById = "SP_GetSiteBillDetailById";
        public const string SaveSiteBill = "SP_SaveSiteBill";
        public const string SaveSiteBillWithoutFile = "SP_AddBillWithoutFile";
        public const string GetSiteBillWithoutFileDetail = "SP_GetWithoutFileSiteBillDetail";

        #endregion

        #region PersonBill
        public const string GetPersonBillList = "SP_GetPersonBillList";
        public const string DeletePersonBill = "SP_DeletePersonBill";
        public const string GetPersonBillById = "SP_GetPersonBillDetailById";
        public const string SavePersonBill = "SP_SavePersonBill";
        #endregion

        #region SitePhotoCategory
        public const string DeleteSitePhotoCategory = "SP_DeleteSitePhotoCategory";
        public const string SaveSitePhotoCategory = "SP_SaveSitePhotoCategory";
        public const string GetSitePhotoCategoryById = "SP_GetSitePhotoCategoryDetailById";
        public const string GetSitePhotoCategoryList = "SP_GetSitePhotoCategoryList";
        public const string GetActiveSitePhotoCategoryList = "SP_GetActiveSitePhotoCategoryList";
        #endregion

        #region Dashboard
        public const string DashboardInfo = "SP_DashboardInfo";
        #endregion

        #region Profile
        public const string UpdateProfile = "SP_UpdteProfile";
        #endregion

        #region PersonGroup
        public const string GetPersonGroupList = "SP_GetPersonGroupList";
        public const string SavePersonGroup = "SP_SavePersonGroup";
        public const string ActiveInActivePersonGroup = "SP_ActiveInactivePersonGroup";
        public const string DeletePersonGroup = "SP_DeletePersonGroup";
        #endregion

        #region PersonAttendance
        public const string SavePersonAttendance = "SP_SavePersonAttendance";
        public const string PersonAttendanceList = "SP_PersonAttendanceList";
        public const string DeletePersonAttendance = "SP_DeletePersonAttendance";
        public const string GetPersonAttendanceById = "SP_GetPersonAttendanceById";
        public const string GetAttendanceByPerson = "SP_GetAttendanceByPerson";
        #endregion
    }
}
