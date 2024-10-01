import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-add-edit-merchantpayment',
  templateUrl: './add-edit-merchantpayment.component.html',
  styleUrl: './add-edit-merchantpayment.component.scss'
})
export class AddEditMerchantpaymentComponent {

  // Fields
  addEditMerchantPaymentForm: FormGroup;
  submitted: boolean = false;
  merchantPaymentId: string = "";
  editedPaymentDetails: any = {};
  paymentId: any;
  paymentType = [
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
  activeSite: any;
  merchantId: any = "";
  submitMerchantId: any = "";
  merchantDropDownList: any = [];
  IsFromList: any;

  // Constructor
  constructor(
    private dialogRef: MatDialogRef<AddEditMerchantpaymentComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private route: ActivatedRoute,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private translate: TranslateService,
    private languageService: LanguageService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService) {
    this.merchantPaymentId = data.paymentId;
    this.merchantId = data.merchantId;
    this.submitMerchantId = data.merchantId;
    this.IsFromList = data.IsFromList;
  }

  // Init
  ngOnInit(): void {
    this.getActiveSiteDetails();
    this.getMerchantListForDropDown();
    this.addEditMerchantPaymentForm = this.fb.group({
      paymentDate: ['', Validators.required],
      siteId: [[], Validators.required],
      merchantId: [''],
      amount: ['', Validators.required],
      paymentType: [[], Validators.required],
      chequeNumber: ['', Validators.required],
      bankName: ['', Validators.required],
      chequeFor: ['', Validators.required],
      remarks: ['']
    });

    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    if (this.merchantPaymentId && this.merchantPaymentId != null && this.merchantPaymentId != undefined) {
      this.getMerchantPaymentById();
    }
  }

  // Save Merchant Payment
  submitMerchantPaymentForm() {
    this.submitted = true;
    if (this.addEditMerchantPaymentForm.invalid) {
      return;
    }
    this.spinner.show();
    let obj = {
      merchantPaymentId: this.merchantPaymentId ? this.merchantPaymentId : '',
      merchantId: this.IsFromList ? this.submitMerchantId : this.addEditMerchantPaymentForm.value.merchantId,
      paymentDate: this.addEditMerchantPaymentForm.value.paymentDate,
      siteId: this.addEditMerchantPaymentForm.value.siteId,
      amount: this.addEditMerchantPaymentForm.value.amount,
      paymentType: this.addEditMerchantPaymentForm.value.paymentType,
      chequeNo: this.addEditMerchantPaymentForm.value.chequeNumber,
      bankName: this.addEditMerchantPaymentForm.value.bankName,
      chequeFor: this.addEditMerchantPaymentForm.value.chequeFor,
      remarks: this.addEditMerchantPaymentForm.value.remarks
    }
    const apiUrl = this.apiUrl.apiUrl.MerchantPayment.SaveMerchantPayment;
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

  getMerchantPaymentById() {
    const apiUrl = this.apiUrl.apiUrl.MerchantPayment.GetMerchantPaymentById;
    this.commonService.doGet(apiUrl.replace("{id}", this.merchantPaymentId)).pipe().subscribe({
      next: (response) => {
        let data = response.data[0];
        this.addEditMerchantPaymentForm.patchValue({
          paymentDate: data.paymentDate,
          merchantId: data.merchantId,
          siteId: data.siteId,
          amount: data.amount,
          paymentType: data.paymentType,
          chequeNumber: data.chequeNo,
          bankName: data.bankName,
          chequeFor: data.chequeFor,
          remarks: data.remarks ? data.remarks : ""
        })
        if (this.IsFromList) {
          this.addEditMerchantPaymentForm.controls["merchantId"].addValidators([Validators.required]);
        }
        this.onPaymentTypeChange(data.paymentType);
        this.paymentId = data.paymentType;

      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  getMerchantListForDropDown() {
    const apiUrl = this.apiUrl.apiUrl.Merchant.GetMerchantListForDropDown;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.merchantDropDownList = response.data;
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  cancel() {
    this.dialogRef.close();
  }

  onPaymentTypeChange(paymentTypeId: any) {
    this.paymentId = paymentTypeId
    if (paymentTypeId == "Cheque") {
      this.addEditMerchantPaymentForm.controls["bankName"].addValidators([Validators.required]);
      this.addEditMerchantPaymentForm.controls["chequeNumber"].addValidators([Validators.required]);
      this.addEditMerchantPaymentForm.controls["chequeFor"].addValidators([Validators.required]);
    }
    else {
      this.addEditMerchantPaymentForm.get('bankName').clearValidators();
      this.addEditMerchantPaymentForm.get('chequeNumber').clearValidators();
      this.addEditMerchantPaymentForm.get('chequeFor').clearValidators();
      this.addEditMerchantPaymentForm.patchValue({
        bankName: null,
        chequeNumber: null,
        chequeFor: null
      });
    }
    this.addEditMerchantPaymentForm.get('bankName').updateValueAndValidity();
    this.addEditMerchantPaymentForm.get('chequeNumber').updateValueAndValidity();
    this.addEditMerchantPaymentForm.get('chequeFor').updateValueAndValidity();
  }

  getActiveSiteDetails() {
    const apiUrl = this.apiUrl.apiUrl.Site.GetActiveSiteList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.activeSite = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }
}
