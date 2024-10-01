import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-add-edit-site-payment',
  templateUrl: './add-edit-site-payment.component.html',
  styleUrl: './add-edit-site-payment.component.scss'
})
export class AddEditSitePaymentComponent {

  paymentType: any = [];
  AddEditSitePaymentForm: FormGroup;
  submitted: boolean = false;
  contractorFinanceId: any;
  editedContractorFinanceDetails: any;
  paymentId: any = 0;
  activeSite: any[] = [];
  userList: any[] = [];
  siteId: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditSitePaymentComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private toastr: ToastrService,
    private languageService: LanguageService,
    private translate: TranslateService,
    private spinner: NgxSpinnerService) {
    this.contractorFinanceId = data.ContractorFinanceId;
    this.siteId = data.SiteId;
  }

  ngOnInit() {
    this.getActiveUserList();
    this.AddEditSitePaymentForm = this.fb.group({
      userName: ['', Validators.required],
      paymentName: ['', Validators.required],
      selectDate: ['', Validators.required],
      bankName: [null],
      chequeNumber: [null],
      chequeFor: [null],
      amount: ['', Validators.required],
      remarks: ['']
    });
    if (this.contractorFinanceId && this.contractorFinanceId != null && this.contractorFinanceId != undefined) {
      this.getContractorFinanceDetails();
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    this.paymentType = [
      {
        paymentId: "Cash",
        PaymentName: "Cash"
      },
      {
        paymentId: "Cheque",
        PaymentName: "Cheque"
      },
      {
        paymentId: "UPI",
        PaymentName: "UPI"
      },
      {
        paymentId: "RTGS",
        PaymentName: "RTGS"
      },
      {
        paymentId: "NEFT",
        PaymentName: "NEFT"
      },
    ];
  }

  formatDate(dateString: string, timeString: string): string {
    const date = new Date(dateString);
    const timeParts = timeString.split(":");
    let hours = parseInt(timeParts[0]);
    const minutes = parseInt(timeParts[1].split(" ")[0]);
    const meridian = timeParts[1].split(" ")[1];
    if (meridian === "PM" && hours !== 12) {
      hours += 12;
    } else if (meridian === "AM" && hours === 12) {
      hours = 0;
    }
    date.setHours(hours, minutes);
    const localDate = new Date(date.getTime() - (date.getTimezoneOffset() * 60000));
    return localDate.toISOString();
  }

  submitSitePaymentForm() {
    this.submitted = true;
    if (this.AddEditSitePaymentForm.invalid) {
      return;
    }
    this.spinner.show();
    const obj = {
      ContractorFinanceId: this.contractorFinanceId && this.contractorFinanceId != null && this.contractorFinanceId != undefined ? this.contractorFinanceId : null,
      SiteId: this.siteId,
      UserId: this.AddEditSitePaymentForm.value.userName,
      paymentType: this.AddEditSitePaymentForm.value.paymentName,
      selectedDate: this.formatDate(this.AddEditSitePaymentForm.value.selectDate, "12:00 AM"),
      bankName: this.AddEditSitePaymentForm.value.bankName ? this.AddEditSitePaymentForm.value.bankName : null,
      chequeNo: this.AddEditSitePaymentForm.value.chequeNumber ? this.AddEditSitePaymentForm.value.chequeNumber : null,
      chequeFor: this.AddEditSitePaymentForm.value.chequeFor ? this.AddEditSitePaymentForm.value.chequeFor : null,
      amount: this.AddEditSitePaymentForm.value.amount,
      remarks: this.AddEditSitePaymentForm.value.remarks?.trim(),
    };
    const apiUrl = this.apiUrl.apiUrl.SitePayment.SaveSitePayment;
    this.commonService.doPost(apiUrl, obj).pipe().subscribe({
      next: (response) => {
        if (response.success) {
          this.spinner.hide();
          this.toastr.success(response.message);
          this.dialogRef.close(true);
        } else {
          this.spinner.hide();
          this.toastr.error(response.message);
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  getContractorFinanceDetails() {
    const apiUrl = this.apiUrl.apiUrl.SitePayment.GetSitePaymentById.replace('{contractorFinanceId}', this.contractorFinanceId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedContractorFinanceDetails = response.data;
        this.AddEditSitePaymentForm.patchValue({
          siteName: this.editedContractorFinanceDetails.siteId,
          userName: this.editedContractorFinanceDetails.userId,
          paymentName: this.editedContractorFinanceDetails.paymentType,
          selectDate: this.editedContractorFinanceDetails.selectedDate,
          bankName: this.editedContractorFinanceDetails.bankName,
          chequeNumber: this.editedContractorFinanceDetails.chequeNo,
          chequeFor: this.editedContractorFinanceDetails.chequeFor,
          amount: this.editedContractorFinanceDetails.amount,
          remarks: this.editedContractorFinanceDetails.remarks ? this.editedContractorFinanceDetails.remarks : ""
        });
        this.paymentId = this.editedContractorFinanceDetails.paymentType;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  getActiveUserList() {
    const apiUrl = this.apiUrl.apiUrl.User.GetActiveUserList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.userList = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  onPaymentTypeChange(paymentTypeId: any) {
    this.paymentId = paymentTypeId
    if (paymentTypeId == 2) {
      this.AddEditSitePaymentForm.controls["bankName"].addValidators([Validators.required]);
      this.AddEditSitePaymentForm.controls["chequeNumber"].addValidators([Validators.required]);
      this.AddEditSitePaymentForm.controls["chequeFor"].addValidators([Validators.required]);
    }
    else {
      this.AddEditSitePaymentForm.get('bankName').clearValidators();
      this.AddEditSitePaymentForm.get('chequeNumber').clearValidators();
      this.AddEditSitePaymentForm.get('chequeFor').clearValidators();
      this.AddEditSitePaymentForm.patchValue({
        bankName: null,
        chequeNumber: null,
        chequeFor: null
      });
    }
    this.AddEditSitePaymentForm.get('bankName').updateValueAndValidity();
    this.AddEditSitePaymentForm.get('chequeNumber').updateValueAndValidity();
    this.AddEditSitePaymentForm.get('chequeFor').updateValueAndValidity();
  }

  cancel() {
    this.dialogRef.close();
  }
}