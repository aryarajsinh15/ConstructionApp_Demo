using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Common.Helper
{
    public class ErrorMessage
    {
        #region Common
        public const string Success = "Success";
        public const string SomethingWentWrong = "Something went wrong, Please try again later";
        public const string NoParametersPassed = "No parameters passed.";
        #endregion

        #region Login
        public const string LoginSuccess = "Logged in successfully.";
        public const string InvalidEmailId = "Email address or password is not valid.";
        public const string UserNotExists = "User does not exists.";
        public const string UserDeactived = "User is deactivated, Please contact to admin.";
        public const string CompanyDeactived = "Company is deactivated, Please contact to admin.";
        public const string CompanyPackageExpired = "Your company package has been expired, Please contact to admin.";                                                    
        public const string NewPasswordConfirmPasswordNotMatch = "New password and confirm password does not match";                                                    
        public const string WorngOldPassword = "Please enter valid old password.";
        public const string ChangePasswordSuccess = "Password changed successfully.";
        public const string ChangePasswordError = "Error occurs in change password.";
        public const string OldPasswordNewPassowordNotSame = "Old password and new password can not be same.";

        #endregion

        #region Site
        public const string SiteDeleteSuccess = "Site deleted successfully.";
        public const string SitePhotoDeleteSuccess = "Site photo deleted successfully.";
        public const string SitePhotoUploadSuccess = "Site photo upload successfully.";
        public const string SiteDeleteError = "Some error occurs in site delete.";
        public const string SitePhotoDeleteError = "Some error occurs in site photo delete.";
        public const string SiteUpdateSuccess = "Site updated successfully.";
        public const string SiteNameAlreadyExists = "Site name already exists.";
        public const string SiteAddSuccess = "Site added successfully.";
        public const string SiteAddEditError = "Some error occurs in site addedit.";
        public const string SiteDeactivated = "Site inactivated successfully.";
        public const string SiteActivated = "Site activated successfully.";
        #endregion

        #region Expense
        public const string ExpenseDeleteSuccess = "Expense deleted successfully.";
        public const string ExpenseDeleteError = "Some error occurs in expense delete.";
        public const string ExpenseUpdateSuccess = "Expense updated successfully.";
        public const string ExpenseAddSuccess = "Expense added successfully.";
        public const string ExpenseAddEditError = "Some error occurs in expense addedit.";
        public const string ExpenseDeactivated = "Expense inactivated successfully.";
        public const string ExpenseActivated = "Expense activated successfully.";
        #endregion

        #region Challan
        public const string ChallanDeleteSuccess = "Challan deleted successfully.";
        public const string ChallanDeleteError = "Some error occurs in challan delete.";
        public const string ChallanUpdateSuccess = "Challan updated successfully.";
        public const string ChallanAddSuccess = "Challan added successfully.";
        public const string ChallanAddEditError = "Some error occurs in challan addedit.";
        public const string ChallanDeactivated = "Challan inactivated successfully.";
        public const string ChallanActivated = "Challan activated successfully.";
        #endregion


        #region VehicleRent

        public const string VehicleRentDeactivated = "Vehicle rent inactivated successfully.";
        public const string VehicleRentActivated = "Vehicle rent activated successfully.";
        public const string VehicleRentDeleteSuccess = "Vehicle rent deleted successfully.";
        public const string VehicleRentDeleteError = "Some error occurs in vehicle rent delete.";

        #endregion


        #region Client
        public const string ClientDeactivated = "Client inactivated successfully.";
        public const string ClientActivated = "Client activated successfully.";
        public const string ClientDeleteSuccess = "Client deleted successfully.";
        public const string ClientDeleteError = "Some error occurs in client delete.";
        public const string ClientUpdateSuccess = "Client updated successfully.";
        public const string ClientAddSuccess = "Client added successfully.";
        public const string ClientFirmNameAlreadyExists = "Client firm name already exists.";
        public const string ClientAddEditError = "Some error occurs in client addedit.";
        #endregion

        #region VehicleOwner
        public const string VehicleOwnerDeactivated = "Vehicle owner inactivated successfully.";
        public const string VehicleOwnerActivated = "Vehicle owner activated successfully.";
        public const string VehicleOwnerDeleteSuccess = "Vehicle owner deleted successfully.";
        public const string VehicleOwnerDeleteError = "Some error occurs in vehicle owner delete.";
        public const string VehicleOwnerUpdateSuccess = "Vehicle owner updated successfully.";
        public const string VehicleOwnerAddSuccess = "Vehicle owner added successfully.";
        public const string VehicleOwnerAddEditError = "Some error occurs in vehicle owner addedit.";

        #endregion


        #region Estimate
        public const string EstimateDeactivated = "Estimate inactivated successfully.";
        public const string EstimateActivated = "Estimate activated successfully.";
        public const string EstimateDeleteSuccess = "Estimate deleted successfully.";
        public const string EstimateDeleteError = "Some error occurs in Estimate delete.";
        public const string EstimateUpdateSuccess = "Estimate updated successfully.";
        public const string EstimateAddSuccess = "Estimate added successfully.";
        public const string EstimateAddEditError = "Some error occurs in Estimate addedit.";
        #endregion

        #region Users
        public const string UserDeactivated = "User inactivated successfully.";
        public const string UserActivated = "User activated successfully.";
        public const string UserAddSuccess = "User added successfully.";
        public const string UserAddEditError = "Some error occurs in user addedit.";
        public const string UserUpdateSuccess = "User updated successfully.";
        public const string UserEmailAlreadyExists = "User email is already exists.";
        public const string UserNameAlreadyExists = "User name is already exists.";
        public const string UserDeleteSuccess = "User deleted successfully.";
        public const string UserDeleteError = "Some error occurs in user delete.";
        #endregion

        #region Merchant
        public const string MerchantDeactivated = "Merchant inactivated successfully.";
        public const string MerchantActivated = "Merchant activated successfully.";
        public const string MerchantPaymentDeleteSuccess = "Merchant payment deleted successfully.";
        public const string MerchantPaymentAddSuccess = "Merchant payment added successfully.";
        public const string MerchantPaymentUpdateSuccess = "Merchant payment updated successfully.";
        #endregion

        #region SiteBill
        public const string SiteBillDeleteSuccess = "Site bill deleted successfully.";
        public const string SiteBillDeleteError = "Some error occurs in site bill delete.";
        public const string SiteBillUpdateSuccess = "Site bill updated successfully.";
        public const string SiteBillAddSuccess = "Site bill added successfully.";
        public const string SiteBillAddEditError = "Some error occurs in site bill addedit.";
        #endregion

        #region Person Bill
        public const string PersonBillDeleteSuccess = "Person bill deleted successfully.";
        public const string PersonBillDeleteError = "Some error occurs in Person bill delete.";
        public const string PersonBillUpdateSuccess = "Person bill updated successfully.";
        public const string PersonBillAddSuccess = "Person bill added successfully.";
        public const string PersonBillAddEditError = "Some error occurs in Person bill addedit.";
        #endregion

        #region SitePhotoCategory
        public const string SitePhotoCategoryDeleteSuccess = "Site image category deleted successfully.";
        public const string SitePhotoCategoryDeleteError = "Some error occurs in site image category delete.";
        public const string SitePhotoCategoryUpdateSuccess = "Site image category updated successfully.";
        public const string SitePhotoCategoryAddSuccess = "Site image category  added successfully.";
        public const string SitePhotoCategoryAddEditError = "Some error occurs in site image category addedit.";

        #endregion

        #region Person
        public const string PersonDeactivated = "Person inactivated successfully.";
        public const string PersonActivated = "Person activated successfully.";
        public const string PersonDeleteSuccess = "Person deleted successfully.";
        public const string PersonAlreadyBeingUsed = "Person is already in use.";
        public const string PersonDeleteError = "Some error occurs in person delete.";
        public const string PersonUpdateSuccess = "Person updated successfully.";
        public const string PersonAddSuccess = "Person added successfully.";
        public const string PersonAddEditError = "Some error occurs in person addedit.";
        #endregion

        #region Profile
        public const string UpdateProflieSuccess = "Proflie Updated successfully.";
        public const string UpdateProflieError = "Some error occurs in profile update.";
        #endregion

        #region PersonGroup
        public const string PersonGroupDeleteSuccess = "Person group deleted successfully.";
        public const string PersonGroupDeleteError = "Some error occurs in person group delete.";
        public const string PersonGroupUpdateSuccess = "Person group updated successfully.";
        public const string PersonGroupAddSuccess = "Person group added successfully.";
        public const string PersonGroupAddEditError = "Some error occurs in person group add/edit.";
        public const string PersonGroupDeactivated = "Person group inactivated successfully.";
        public const string PersonGroupActivated = "Person group activated successfully.";
        #endregion

        #region ContractorFinace
        public const string ContractorFinaceDeleteSuccess = "Site payment delete successfully.";
        public const string ContractorFinaceDeleteError = "Some error occurs in site payment delete.";
        public const string ContractorFinaceUpdateSuccess = "Site payment updated successfully.";
        public const string ContractorFinaceAddSuccess = "Site payment added successfully.";
        public const string ContractorFinaceAddEditError = "Some error occurs in site payment addedit.";
        #endregion

        #region Person Finace
        public const string PersonFinaceDeleteSuccess = "Person payment delete successfully.";
        public const string PersonFinaceDeleteError = "Some error occurs in person payment delete.";
        public const string PersonFinaceUpdateSuccess = "Person payment updated successfully.";
        public const string PersonFinaceAddSuccess = "Person payment added successfully.";
        public const string PersonFinaceAddEditError = "Some error occurs in person payment addedit.";
        #endregion

        #region SavePersonAttendance
        public const string SavePersonAttendanceSuccess = "Person attendance added successfully.";
        public const string UpdatePersonAttendanceSuccess = "Person attendance updated successfully.";
        public const string PersonAttendanceExists = "Person attendance for this date exits.";
        public const string PersonAttendanceDeleteSuccess = "Person attendance deleted successfully.";
        #endregion
    }
}
