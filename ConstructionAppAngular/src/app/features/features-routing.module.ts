import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { SiteComponent } from "./sites/site/site.component";
import { ExpenseComponent } from "./expense/expense/expense.component";
import { MerchantListComponent } from "./merchant/merchant-list/merchant-list.component";
import { ClientComponent } from "./client/client/client.component";
import { DashboardComponent } from "./dashboard/dashboard.component";
import { AuthGuard } from "app/guard/auth-guard/auth.guard";
import { SuperAuthGuard } from "app/guard/super-admin-auth-guard/superauth,guard";
import { VehicleOwnerComponent } from "./vehicle-owner/vehicle-owner/vehicle-owner.component";
import { VehicleRentComponent } from "./vehicle-rent/vehicle-rent/vehicle-rent.component";
import { PersonsListComponent } from "./Persons/persons-list/persons-list.component";
import { UserComponent } from "./user/user/user.component";
import { SitePaymentComponent } from "./site-payment/site-payment/site-payment.component";
import { SitePaymentDebitComponent } from "./site-payment-debit/site-payment-debit/site-payment-debit.component";
import { ChallanComponent } from "./Challan/challan/challan.component";
import { ChangePasswordComponent } from "./change-password/change-password/change-password.component";
import { PhotoGalleryComponent } from "./photo-gallery/photo-gallery.component";
import { MerchantpaymentListComponent } from "./merchantPayment/merchantpayment-list/merchantpayment-list.component";
import { SitePhotoCategoryComponent } from "./site-photo-category/site-photo-category/site-photo-category.component";
import { SitePaymentDebitWithoutFileComponent } from "./site-payment-debit/site-payment-debit-without-file/site-payment-debit-without-file.component";
import { EstimateComponent } from "./Estimate/estimate/estimate.component";
import { UpdateProfileComponent } from "./profile/update-profile/update-profile.component";
import { PersonPaymentComponent } from "./person-payment/person-payment/person-payment.component";
import { PersonPaymentDebitComponent } from "./person-payment-debit/person-payment-debit/person-payment-debit.component";
import { AddEditPersonGroupComponent } from "./person-group/add-edit-person-group/add-edit-person-group.component";
import { PersonGroupListComponent } from "./person-group/person-group-list/person-group-list.component";
import { AddEditEstimateBillPaymentComponent } from "./Estimate-Bill-Payment/add-edit-estimate-bill-payment/add-edit-estimate-bill-payment/add-edit-estimate-bill-payment.component";
import { PersonAttedanceComponent } from "./Persons/person-attedance/person-attedance.component";
import { PersonAttendanceListComponent } from "./Person-Attendance/person-attendance-list/person-attendance-list.component";
import { AddEditPersonAttendanceComponent } from "./Person-Attendance/add-edit-person-attendance/add-edit-person-attendance.component";
import { AttendanceByPersonComponent } from "./Person-Attendance/attendance-by-person/attendance-by-person.component";

const routes: Routes = [
  {
    path: "dashboard",
    component: DashboardComponent,
  },
  {
    path: "user",
    component: UserComponent,
  },
  {
    path: "change-password",
    component: ChangePasswordComponent,
  },
  {
    path: "client",
    component: ClientComponent,
    canActivate: [AuthGuard]
  },
  {
    path: "user/:clientid",
    component: UserComponent,
    canActivate: [AuthGuard]
  },
  {
    path: "site",
    component: SiteComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "expense",
    component: ExpenseComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "merchant",
    component: MerchantListComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "vehicle-owner",
    component: VehicleOwnerComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "vehicle-rent",
    component: VehicleRentComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "person",
    component: PersonsListComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "challan",
    component: ChallanComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "estimate",
    component: EstimateComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "site-payment/:siteid",
    component: SitePaymentComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "bill-payment/:siteid",
    component: SitePaymentDebitComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "photo-gallery/:siteid",
    component: PhotoGalleryComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "nofile-bill-payment/:siteid",
    component: SitePaymentDebitWithoutFileComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "site-image-category",
    component: SitePhotoCategoryComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "profile",
    component: UpdateProfileComponent
  },
  {
    path: "merchant-payment/:merchantid",
    component: MerchantpaymentListComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "merchant-payment",
    component: MerchantpaymentListComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "person-payment/:personid",
    component: PersonPaymentComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "person-bill-payment/:personid",
    component: PersonPaymentDebitComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "person-group",
    component: PersonGroupListComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "person-group/:persongroupid",
    component: AddEditPersonGroupComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "estimate-bill-payment",
    component: AddEditEstimateBillPaymentComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "estimate-bill-payment/:id",
    component: AddEditEstimateBillPaymentComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "attedance/person",
    component: PersonAttedanceComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "attendance",
    component: PersonAttendanceListComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "attendance-by-person/:person",
    component: AttendanceByPersonComponent,
    canActivate: [SuperAuthGuard]
  },
  {
    path: "attendance/add-edit/:attendanceId",
    component: AddEditPersonAttendanceComponent,
    canActivate: [SuperAuthGuard]
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class FeaturesRoutingModule { }
