import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-add-edit-merchant',
  templateUrl: './add-edit-merchant.component.html',
  styleUrl: './add-edit-merchant.component.scss'
})
export class AddEditMerchantComponent {
  merchantId: any;
  AddEditMerchantForm: FormGroup;
  submitted: boolean = false;
  activeClient: any[] = [];
  editedMerchantDetails: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditMerchantComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private spinner: NgxSpinnerService,
    private toastr: ToastrService) {
    this.merchantId = data.MerchantId;
  }

  ngOnInit(): void {
    this.getActiveClientList();
    this.AddEditMerchantForm = this.fb.group({
      merchantName: ['', Validators.required],
      firmName: ['', Validators.required],
      mobileNo: ['', [Validators.required]],
      address: [''],
      clientId: ['']
    });

    if (this.merchantId && this.merchantId != null && this.merchantId != undefined && this.merchantId != 0) {
      this.getMerchantDetails();
    }
  }

  getActiveClientList() {
    const apiUrl = this.apiUrl.apiUrl.Merchant.GetActiveClientList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.activeClient = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  submitMerchantForm() {
    this.submitted = true;
    if (this.AddEditMerchantForm.invalid) {
      return;
    }
    const obj = {
      merchantId: this.merchantId && this.merchantId != null && this.merchantId != undefined ? this.merchantId : null,
      merchantname: this.AddEditMerchantForm.get('merchantName').value?.trim(),
      firmname: this.AddEditMerchantForm.get('firmName').value?.trim(),
      mobileno: this.AddEditMerchantForm.get('mobileNo').value?.trim(),
      address: this.AddEditMerchantForm.get('address').value?.trim()
    };
    const apiUrl = this.apiUrl.apiUrl.Merchant.SaveMerchant;
    this.spinner.show();
    this.commonService.doPost(apiUrl, obj).pipe().subscribe({
      next: (response) => {
        this.spinner.hide();
        if (response.success) {
          this.toastr.success(response.message);
          this.dialogRef.close(true);
        } else {
          this.toastr.error(response.message);
        }
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  getMerchantDetails() {
    const apiUrl = this.apiUrl.apiUrl.Merchant.GetMerchantById.replace('{id}', this.merchantId.toString());
    this.spinner.show();
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.spinner.hide();
        this.editedMerchantDetails = response.data[0];
        this.AddEditMerchantForm.patchValue({
          merchantName: this.editedMerchantDetails.merchantName,
          firmName: this.editedMerchantDetails.firmName,
          mobileNo: this.editedMerchantDetails.mobileNo,
          address: this.editedMerchantDetails.address ? this.editedMerchantDetails.address : ""
        });
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