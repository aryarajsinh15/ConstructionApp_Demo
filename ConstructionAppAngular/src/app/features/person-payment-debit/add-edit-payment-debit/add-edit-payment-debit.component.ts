import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-add-edit-payment-debit',
  templateUrl: './add-edit-payment-debit.component.html',
  styleUrl: './add-edit-payment-debit.component.scss'
})
export class AddEditPaymentDebitComponent {

  billId: any;
  PersonId: any;
  AddEditPersonPaymentDebitForm: FormGroup;
  submitted: boolean = false;
  editedBillPaymentDetails: any = {};
  billFile: any;
  selectdFile: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditPaymentDebitComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private toastr: ToastrService,
    private languageService: LanguageService,
    private translate: TranslateService,
    private spinner: NgxSpinnerService) {
    this.billId = data.BillId;
    this.PersonId = data.PersonId;
  }

  ngOnInit() {
    if (this.billId && this.billId != null && this.billId != undefined) {
      this.getBillPaymentDetails();
    }
    this.AddEditPersonPaymentDebitForm = this.fb.group({
      billDate: ['', Validators.required],
      billNumber: ['', Validators.required],
      totalAmount: ['', Validators.required],
      billFile: ['', Validators.required],
      remarks: ['']
    });
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  onFileSelected(event: Event): void {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.billFile = inputElement.files[0];
      const file = inputElement.files[0];
      const maxSize = 10 * 1024 * 1024; // 10 MB in bytes
      if (file.size > maxSize) {
        this.toastr.error('File size exceeds the maximum limit (10 MB)');
        return;
      }
      const reader = new FileReader();
      reader.onload = (e) => {
        this.selectdFile = e.target.result as string;
      };
      reader.readAsDataURL(file);
    } else {
      this.selectdFile = null;
    }
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

  submitPersonPaymentDebitForm() {
    this.submitted = true;
    if (this.AddEditPersonPaymentDebitForm.invalid) {
      return;
    }
    this.spinner.show();
    const formData = new FormData();
    formData.append('PersonBillId', this.billId && this.billId != null && this.billId != undefined ? this.billId : "");
    formData.append('PersonId', this.PersonId);
    formData.append('BillDate', this.formatDate(this.AddEditPersonPaymentDebitForm.value.billDate, "12:00 AM"));
    formData.append('BillNo', this.AddEditPersonPaymentDebitForm.value.billNumber?.trim());
    formData.append('TotalAmount', this.AddEditPersonPaymentDebitForm.value.totalAmount);
    formData.append('Remarks', this.AddEditPersonPaymentDebitForm.value.remarks?.trim());
    formData.append('PersonBillFile', this.billFile);
    const apiUrl = this.apiUrl.apiUrl.PersonPaymentDebit.SavePersonPaymentDebit;
    this.commonService.doPost(apiUrl, formData).pipe().subscribe({
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

  getBillPaymentDetails() {
    const apiUrl = this.apiUrl.apiUrl.PersonPaymentDebit.GetpersonPaymentDebitById.replace('{billId}', this.billId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedBillPaymentDetails = response.data;
        this.AddEditPersonPaymentDebitForm.patchValue({
          billDate: this.editedBillPaymentDetails.billDate,
          billNumber: this.editedBillPaymentDetails.billNo,
          totalAmount: this.editedBillPaymentDetails.totalAmount,
          remarks: this.editedBillPaymentDetails.remarks ? this.editedBillPaymentDetails.remarks : "",
        });
        if (this.editedBillPaymentDetails.siteBillFile != null) {
          this.AddEditPersonPaymentDebitForm.get('billFile').clearValidators();
          this.billFile = null;
          this.AddEditPersonPaymentDebitForm.get('billFile').updateValueAndValidity();
        }
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  cancel() {
    this.dialogRef.close();
  }
}