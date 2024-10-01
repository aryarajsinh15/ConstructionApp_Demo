import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";
import { FeaturesRoutingModule } from "./features-routing.module";
import { SiteComponent } from "./sites/site/site.component";
import { TranslateLoader, TranslateModule } from "@ngx-translate/core";
import { HttpClient } from "@angular/common/http";
import { TranslateHttpLoader } from "@ngx-translate/http-loader";
import { MatTableModule } from "@angular/material/table";
import { MatPaginatorModule } from "@angular/material/paginator";
import { MatMenuModule } from "@angular/material/menu";
import { MatIconModule } from "@angular/material/icon";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatInputModule } from "@angular/material/input";
import { AddEditSiteModalComponent } from "./sites/add-edit-site-modal/add-edit-site-modal.component";
import { MatDialogModule } from "@angular/material/dialog";
import { MatButtonModule } from "@angular/material/button";
import { MatSortModule } from "@angular/material/sort";
import { ExpenseComponent } from "./expense/expense/expense.component";
import { AddEditExpenseComponent } from "./expense/add-edit-expense/add-edit-expense.component";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatSelectModule } from "@angular/material/select";
import { MatNativeDateModule, MatRippleModule } from "@angular/material/core";
import { MerchantListComponent } from './merchant/merchant-list/merchant-list.component';
import { ClientComponent } from "./client/client/client.component";
import { AddEditClientComponent } from "./client/add-edit-client/add-edit-client.component";
import { AddEditMerchantComponent } from "./merchant/add-edit-merchant/add-edit-merchant.component";
import { NgxMatFileInputModule } from '@angular-material-components/file-input';
import { DashboardComponent } from "./dashboard/dashboard.component";
import { VehicleOwnerComponent } from "./vehicle-owner/vehicle-owner/vehicle-owner.component";
import { AddEditVehicleOwnerComponent } from "./vehicle-owner/add-edit-vehicle-owner/add-edit-vehicle-owner.component";
import { NgxSpinnerModule } from "ngx-spinner";
import { VehicleRentComponent } from "./vehicle-rent/vehicle-rent/vehicle-rent.component";
import { AddEditVehicleRentComponent } from "./vehicle-rent/add-edit-vehicle-rent/add-edit-vehicle-rent.component";
import { ToastrModule } from 'ngx-toastr';
import { PersonsListComponent } from "./Persons/persons-list/persons-list.component";
import { PersonAttendanceListComponent } from "./Person-Attendance/person-attendance-list/person-attendance-list.component";
import { AddEditUserComponent } from "./user/add-edit-user/add-edit-user.component";
import { UserComponent } from "./user/user/user.component";
import { PageLayoutModule } from "@vex/components/page-layout/page-layout.module";
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { BreadcrumbsModule } from '../../@vex/components/breadcrumbs/breadcrumbs.module';
import { SitePaymentComponent } from "./site-payment/site-payment/site-payment.component";
import { AddEditSitePaymentComponent } from "./site-payment/add-edit-site-payment/add-edit-site-payment.component";
import { AddEditPersonComponent } from "./Persons/add-edit-person/add-edit-person.component";
import { SitePaymentDebitComponent } from "./site-payment-debit/site-payment-debit/site-payment-debit.component";
import { AddEditSitePaymentDebitComponent } from "./site-payment-debit/add-edit-site-payment-debit/add-edit-site-payment-debit.component";
import { AddEditChallanComponent } from "./Challan/add-edit-challan/add-edit-challan.component";
import { ChallanComponent } from "./Challan/challan/challan.component";
import { ChangePasswordComponent } from "./change-password/change-password/change-password.component";
import { UplaodPhotoGalleryComponent } from "./uplaod-photo-gallery/uplaod-photo-gallery.component";
import { PhotoGalleryComponent } from "./photo-gallery/photo-gallery.component";
import { SitePhotoCategoryComponent } from "./site-photo-category/site-photo-category/site-photo-category.component";
import { MatExpansionModule } from '@angular/material/expansion';
import { AddEditSitePhotoCategoryComponent } from "./site-photo-category/add-edit-site-photo-category/add-edit-site-photo-category.component";
import { AddEditMerchantpaymentComponent } from "./merchantPayment/add-edit-merchantpayment/add-edit-merchantpayment.component";
import { MerchantpaymentListComponent } from "./merchantPayment/merchantpayment-list/merchantpayment-list.component";
import { SitePaymentDebitWithoutFileComponent } from "./site-payment-debit/site-payment-debit-without-file/site-payment-debit-without-file.component";
import { EstimateComponent } from "./Estimate/estimate/estimate.component";
import { AddEditEstimateComponent } from "./Estimate/add-edit-estimate/add-edit-estimate.component";
import { UpdateProfileComponent } from "./profile/update-profile/update-profile.component";
import { MatCardModule } from '@angular/material/card';
import { PersonPaymentComponent } from "./person-payment/person-payment/person-payment.component";
import { AddEditPersonPaymentComponent } from "./person-payment/add-edit-person-payment/add-edit-person-payment.component";
import { PersonPaymentDebitComponent } from "./person-payment-debit/person-payment-debit/person-payment-debit.component";
import { AddEditPaymentDebitComponent } from "./person-payment-debit/add-edit-payment-debit/add-edit-payment-debit.component";
import { PersonGroupListComponent } from "./person-group/person-group-list/person-group-list.component";
import { AddEditPersonGroupComponent } from "./person-group/add-edit-person-group/add-edit-person-group.component";
import { AddEditEstimateBillPaymentComponent } from "./Estimate-Bill-Payment/add-edit-estimate-bill-payment/add-edit-estimate-bill-payment/add-edit-estimate-bill-payment.component";
import { WidgetTableModule } from "../../@vex/components/widgets/widget-table/widget-table.module";
import { WidgetLargeGoalChartModule } from "../../@vex/components/widgets/widget-large-goal-chart/widget-large-goal-chart.module";
import { ChartModule } from "../../@vex/components/chart/chart.module";
import { WidgetQuickValueCenterModule } from "../../@vex/components/widgets/widget-quick-value-center/widget-quick-value-center.module";
import { WidgetLargeChartModule } from "../../@vex/components/widgets/widget-large-chart/widget-large-chart.module";
import { WidgetQuickLineChartModule } from "../../@vex/components/widgets/widget-quick-line-chart/widget-quick-line-chart.module";
import { WidgetAssistantModule } from "../../@vex/components/widgets/widget-assistant/widget-assistant.module";
import { AddEditPersonAttedanceComponent } from "./Persons/add-edit-person-attedance/add-edit-person-attedance.component";
import { AddEditPersonAttendanceComponent } from "./Person-Attendance/add-edit-person-attendance/add-edit-person-attendance.component";
import { PersonAttedanceComponent } from "./Persons/person-attedance/person-attedance.component";
import { DatePipe } from '@angular/common';
import { CurrencyFormat } from "app/services/custom-pipe/currency-format.pipe";
import { AttendanceByPersonComponent } from "./Person-Attendance/attendance-by-person/attendance-by-person.component";

export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/json/', '.json');
}
@NgModule({
    declarations: [
        SiteComponent,
        AddEditSiteModalComponent,
        ExpenseComponent,
        AddEditExpenseComponent,
        MerchantListComponent,
        AddEditClientComponent,
        ClientComponent,
        AddEditMerchantComponent,
        DashboardComponent,
        VehicleOwnerComponent,
        AddEditVehicleOwnerComponent,
        VehicleRentComponent,
        AddEditVehicleRentComponent,
        PersonsListComponent,
        AddEditPersonComponent,
        AddEditUserComponent,
        UserComponent,
        MerchantListComponent,
        SitePaymentComponent,
        AddEditSitePaymentComponent,
        SitePaymentDebitComponent,
        AddEditSitePaymentDebitComponent,
        AddEditChallanComponent,
        ChallanComponent,
        ChangePasswordComponent,
        PhotoGalleryComponent,
        UplaodPhotoGalleryComponent,
        SitePhotoCategoryComponent,
        AddEditSitePhotoCategoryComponent,
        SitePaymentDebitWithoutFileComponent,
        UpdateProfileComponent,
        MerchantpaymentListComponent,
        AddEditMerchantpaymentComponent,
        SitePaymentDebitWithoutFileComponent,
        EstimateComponent,
        AddEditEstimateComponent,
        PersonPaymentComponent,
        AddEditPersonPaymentComponent,
        PersonPaymentDebitComponent,
        AddEditPaymentDebitComponent,
        PersonGroupListComponent,
        AddEditPersonGroupComponent,
        AddEditEstimateBillPaymentComponent,
        PersonsListComponent,
        AddEditPersonAttedanceComponent,
        PersonAttedanceComponent,
        PersonAttendanceListComponent,
        AddEditPersonAttendanceComponent,
        AttendanceByPersonComponent,
        CurrencyFormat
    ],
    exports: [TranslateModule],
    imports: [
        CommonModule,
        FeaturesRoutingModule,
        FormsModule,
        MatTableModule,
        MatMenuModule,
        MatIconModule,
        ReactiveFormsModule,
        MatInputModule,
        MatDialogModule,
        MatButtonModule,
        MatFormFieldModule,
        MatDatepickerModule,
        BreadcrumbsModule,
        MatSortModule,
        MatSelectModule,
        MatNativeDateModule,
        MatPaginatorModule,
        PageLayoutModule,
        NgxMatFileInputModule,
        MatButtonToggleModule,
        MatCardModule,
        MatRippleModule,
        MatExpansionModule,
        ToastrModule.forRoot({ closeButton: true }),
        NgxSpinnerModule.forRoot({ type: 'ball-scale-multiple' }),
        TranslateModule.forRoot({
            loader: {
                provide: TranslateLoader,
                useFactory: HttpLoaderFactory,
                deps: [HttpClient]
            }
        }),
        WidgetTableModule,
        WidgetLargeGoalChartModule,
        ChartModule,
        WidgetQuickValueCenterModule,
        WidgetLargeChartModule,
        WidgetQuickLineChartModule,
        WidgetAssistantModule
    ],
    providers:[DatePipe, CurrencyFormat]
})
export class FeaturesModule { }
