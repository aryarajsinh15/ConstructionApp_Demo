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
  selector: 'vex-add-edit-person-payment',
  templateUrl: './add-edit-person-payment.component.html',
  styleUrl: './add-edit-person-payment.component.scss'
})
export class AddEditPersonPaymentComponent {

  paymentType: any = [];
  AddEditPersonPaymentForm: FormGroup;
  submitted: boolean = false;
  personFinanceId: any;
  editedPersonFinanceDetails: any;
  paymentId: any = 0;
  activePerson: any[] = [];
  userList: any[] = [];
  personid: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditPersonPaymentComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private toastr: ToastrService,
    private languageService: LanguageService,
    private translate: TranslateService,
    private spinner: NgxSpinnerService) {
    this.personFinanceId = data.PersonFinanceId;
    this.personid = data.PersonId;
  }

  ngOnInit() {
    this.getActiveUserList();
    this.AddEditPersonPaymentForm = this.fb.group({
      userName: ['', Validators.required],
      paymentName: ['', Validators.required],
      selectDate: ['', Validators.required],
      bankName: [null],
      chequeNumber: [null],
      chequeFor: [null],
      amount: ['', Validators.required],
      remarks: ['']
    });
    if (this.personFinanceId && this.personFinanceId != null && this.personFinanceId != undefined) {
      this.getPersonFinanceDetails();
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

  submitPersonPaymentForm() {
    this.submitted = true;
    if (this.AddEditPersonPaymentForm.invalid) {
      return;
    }
    this.spinner.show();
    const obj = {
      PersonFinanceId: this.personFinanceId && this.personFinanceId != null && this.personFinanceId != undefined ? this.personFinanceId : null,
      PersonId: this.personid,
      UserId: this.AddEditPersonPaymentForm.value.userName,
      paymentType: this.AddEditPersonPaymentForm.value.paymentName,
      selectedDate: this.formatDate(this.AddEditPersonPaymentForm.value.selectDate, "12:00 AM"),
      bankName: this.AddEditPersonPaymentForm.value.bankName ? this.AddEditPersonPaymentForm.value.bankName : null,
      chequeNo: this.AddEditPersonPaymentForm.value.chequeNumber ? this.AddEditPersonPaymentForm.value.chequeNumber : null,
      chequeFor: this.AddEditPersonPaymentForm.value.chequeFor ? this.AddEditPersonPaymentForm.value.chequeFor : null,
      amount: this.AddEditPersonPaymentForm.value.amount,
      remarks: this.AddEditPersonPaymentForm.value.remarks?.trim(),
    };
    const apiUrl = this.apiUrl.apiUrl.PersonPayment.SavePersonPayment;
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

  getPersonFinanceDetails() {
    const apiUrl = this.apiUrl.apiUrl.PersonPayment.GetPersonPaymentById.replace('{personFinanceId}', this.personFinanceId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedPersonFinanceDetails = response.data;
        this.AddEditPersonPaymentForm.patchValue({
          personFinanceId: this.editedPersonFinanceDetails.personFinanceId,
          PersonId: this.editedPersonFinanceDetails.PersonId,
          userName: this.editedPersonFinanceDetails.userId,
          paymentName: this.editedPersonFinanceDetails.paymentType,
          selectDate: this.editedPersonFinanceDetails.selectedDate,
          bankName: this.editedPersonFinanceDetails.bankName,
          chequeNumber: this.editedPersonFinanceDetails.chequeNo,
          chequeFor: this.editedPersonFinanceDetails.chequeFor,
          amount: this.editedPersonFinanceDetails.amount,
          remarks: this.editedPersonFinanceDetails.remarks ? this.editedPersonFinanceDetails.remarks : ""
        });
        this.paymentId = this.editedPersonFinanceDetails.paymentType;
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
      this.AddEditPersonPaymentForm.controls["bankName"].addValidators([Validators.required]);
      this.AddEditPersonPaymentForm.controls["chequeNumber"].addValidators([Validators.required]);
      this.AddEditPersonPaymentForm.controls["chequeFor"].addValidators([Validators.required]);
    }
    else {
      this.AddEditPersonPaymentForm.get('bankName').clearValidators();
      this.AddEditPersonPaymentForm.get('chequeNumber').clearValidators();
      this.AddEditPersonPaymentForm.get('chequeFor').clearValidators();
      this.AddEditPersonPaymentForm.patchValue({
        bankName: null,
        chequeNumber: null,
        chequeFor: null
      });
    }
    this.AddEditPersonPaymentForm.get('bankName').updateValueAndValidity();
    this.AddEditPersonPaymentForm.get('chequeNumber').updateValueAndValidity();
    this.AddEditPersonPaymentForm.get('chequeFor').updateValueAndValidity();
  }

  cancel() {
    this.dialogRef.close();
  }
}