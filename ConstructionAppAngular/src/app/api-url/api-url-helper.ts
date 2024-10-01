import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})

export class ApiUrlHelper {
  public apiUrl = {
    Login: {
      UserLogin: 'account/login',
    },
    ChangePassword: {
      ChangePassword: 'account/change-password',
    },
    Profile: {
      UpdateProfile: 'profile/update-profile',
      GetUserDetails: 'profile/get-user-details'
    },
    Dashboard:{
      DashboardInfo:'dashboard/info'
    },
    Site: {
      GetSiteList: 'site/list',
      DeleteSite: 'site/delete/{siteId}',
      SaveSite: 'site/save',
      GetSiteById: 'site/{siteId}',
      ActiveInActiveSite: 'site/active-inactive/{siteId}',
      GetActiveSiteList: 'site/active-site-list',
      SaveSiteCategoryImage: 'site/save-site-image',
      GetSiteCategoryImageList: 'site/site-image-list/{siteId}',
      DeleteIamgeBySitePhotoId: 'site/delete-site-photo/{sitePhotoId}'
    },
    Expense: {
      GetExpenseList: 'expense/list',
      DeleteExpense: 'expense/delete/{expenseId}',
      SaveExpense: 'expense/save',
      GetExpenseById: 'expense/{expenseId}',
      ActiveInActiveExpense: 'expense/active-inactive/{expenseId}',
      GetExpenseTypeList: 'expense/expense-type-list',
      ExportExcelExpense:'expense/export-excel',
      ExportPDFExpense:'expense/export-pdf'
    },
    Merchant: {
      GetMerchantList: 'merchant/list',
      GetMerchantListForDropDown: 'merchant/dropdown-list',
      SaveMerchant: 'merchant/save',
      GetActiveClientList: 'merchant/client-list',
      GetMerchantById: 'merchant/{id}',
      DeleteMerchant: 'merchant/delete/{id}',
      ActiveInActiveMerchant: 'merchant/active-inactive/{merchantId}',
    },
    Client: {
      GetClientList: 'client/list',
      DeleteClient: 'client/delete/{clientId}',
      SaveClient: 'client/save',
      GetClientById: 'client/{clientId}',
      ActiveInActiveClient: 'client/active-inactive/{clientId}',
      GetPackageTypeList: 'client/package-type-list'
    },
    VehicleOwner: {
      GetVehicleOwnerList: 'vehicle-owner/list',
      DeleteVehicleOwner: 'vehicle-owner/delete/{vehicleOwnerId}',
      SaveVehicleOwner: 'vehicle-owner/save',
      GetVehicleOwnerById: 'vehicle-owner/{vehicleOwnerId}',
      ActiveInActiveVehicleOwner: 'vehicle-owner/active-inactive/{vehicleOwnerId}',
    },
    VehicleRent: {
      GetVehicleRentList: 'vehicle-rent/list',
      DeleteVehicleRent: 'vehicle-rent/delete/{vehicleRentId}',
      SaveVehicleRent: 'vehicle-rent/save',
      GetVehicleRentById: 'vehicle-rent/{vehicleRentId}',
      ActiveInActiveVehicleRent: 'vehicle-rent/active-inactive/{vehicleRentId}',
      VehicleOwnerlist: 'vehicle-rent/vehicle-owner-rent',
      ExportExcelVehicleRent:'vehicle-rent/export-excel',
      ExportPDFVehicleRent:'vehicle-rent/export-pdf'
    },
    Persons: {
      GetPerosnList: 'person/list',
      GetPerosnlistForDropDown: 'person/dropdown-list/{id}',
      SavePerson: 'person/save',
      GetPersonById: 'person/{id}',
      DeletePerson: 'person/delete/{id}',
      GetActivePersonType: 'person/persontype-list',
      ActiveInActivePerson: 'person/active-inactive/{personId}',
      GetPerosnAttedanceList: 'person/attendant-list',
      SaveAttedancePerson: 'person/attendant-save',
    },
    User: {
      GetUserlist: 'user/list',
      SaveUser: 'user/save',
      DeleteUser: 'user/delete/{userId}',
      GetUserById: 'user/{userId}',
      ActiveInActiveUser: 'user/active-inactive/{userId}',
      GetActiveUserList: 'user/active-user-list',
    },
    SitePayment: {
      GetSitePaymentlist: 'contractor-finance/list',
      SaveSitePayment: 'contractor-finance/save',
      DeleteSitePayment: 'contractor-finance/delete/{contractorFinanceId}',
      GetSitePaymentById: 'contractor-finance/{contractorFinanceId}',
      ExportExcelSitePaymnet:'contractor-finance/export-excel/{siteId}',
      ExportPDFSitePaymnet:'contractor-finance/export-pdf/{siteId}'
    },
    SitePaymentDebit: {
      GetSitePaymentDebitlist: 'site-bill/list',
      SaveSitePaymentDebit: 'site-bill/save',
      DeleteSitePaymentDebit: 'site-bill/delete/{billId}',
      GetSitePaymentDebitById: 'site-bill/{billId}',
      ExportExcelBillPayment:'site-bill/generate-excel/{billId}',
      ExportPDFBillPayment:'site-bill/generate/{billId}',
      SaveSiteBillWithOutFile:'site-bill/without-file-save',
      GetSiteBillDetails:'site-bill/without-file-bill-detail/{billId}'
    },
    MerchantPayment: {
      GetMerchantPaymentList: 'merchantpayment/list',
      SaveMerchantPayment: 'merchantpayment/save',      
      GetMerchantPaymentById: 'merchantpayment/{id}',
      DeleteMerchantPayment: 'merchantpayment/delete/{id}',
      ActiveInActiveMerchantPayment: 'merchantpayment/active-inactive/{merchantId}',
    },
    Challan:{
      GetChallanlist: 'challan/list',
      SaveChallan: 'challan/save',
      DeleteChallan: 'challan/delete/{challanId}',
      GetChallanById: 'challan/{challanId}',
      ActiveInActivechallan: 'challan/active-inactive/{challanId}',
      MerchantList: 'challan/merchant-list',
    },
    SiteCategory:{
      GetSiteCategoryList: 'site-photo-category/list',
      DeleteSiteCategory: 'site-photo-category/delete/{sitePhotoCategoryId}',
      GetSiteCategoryById: 'site-photo-category/{sitePhotoCategoryId}',
      GetActiveSiteCategory: 'site-photo-category/active-category-list',
      SaveSiteCategory: 'site-photo-category/save',
    },
    Estimate:{
      GetEstimateList: 'estimate/list',
      DeleteEstimate: 'estimate/delete/{estimateId}',
      GetEstimateById: 'estimate/{estimateId}',
      SaveEstimate: 'estimate/save',
      ActiveInActiveEstimate: 'estimate/active-inactive/{estimateId}',
      GetSiteBillDetails:'estimate/without-file-bill-detail/{estimateBillId}',
      SaveEstimateBillWithOutFile:'estimate/without-file-save',

    },
    PersonPayment: {
      GetPersonPaymentlist: 'person-finance/list',
      SavePersonPayment: 'person-finance/save',
      DeletePersonPayment: 'person-finance/delete/{personFinanceId}',
      GetPersonPaymentById: 'person-finance/{personFinanceId}',
      ExportExcelPersonPaymnet:'person-finance/export-excel/{personfinanceId}',
      ExportPDFPersonPaymnet:'person-finance/export-pdf'
    },
    PersonPaymentDebit: {
      GetPersonPaymentDebitlist: 'person-bill/list',
      SavePersonPaymentDebit: 'person-bill/save',
      DeletePersonPaymentDebit: 'person-bill/delete/{billId}',
      GetpersonPaymentDebitById: 'person-bill/{billId}',
      ExportExcelBillPayment:'person-bill/export-excel',
      ExportPDFBillPayment:'person-bill/export-pdf'
    },
    PersonGroup : {
      GetPersonGroupList : 'person-group/list',
      DeletePersonGroup: 'person-group/delete/{groupId}',
      ActiveInActiveGroup: 'person-group/active-inactive/{groupId}',
      SavePersonGroup : 'person-group/save'
    },
    PersonAttendance:{
      GetPersonAttendance : 'person-attendance/list',
      DeletePersonAttendance:'person-attendance/delete/{attendanceId}',
      SavePersonAttendance : 'person-attendance/save',
      GetPersonAttendanceDetails : 'person-attendance/detail/{id}',
      GetAttendanceByPerson : 'person-attendance/attendance-by-person'
    }
  }
}
