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
  selector: 'vex-add-edit-challan',
  templateUrl: './add-edit-challan.component.html',
  styleUrl: './add-edit-challan.component.scss'
})
export class AddEditChallanComponent {

  AddEditChallanForm: FormGroup;
  submitted: boolean = false;
  challanId: any;
  editedChallanDetails: any = {};
  expenseType: any[] = [];
  activeSite: any[] = [];
  merchantList: any[] = [];
  challanTypeId: number = 0;
  minDate: any = new Date();
  challanFile: any;
  selectdFile: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditChallanComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private translate: TranslateService,
    private languageService: LanguageService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService) {
    this.challanId = data.challanId;
  }

  ngOnInit(): void {
    this.getActiveSiteDetails();
    this.getMerchantList();
    this.AddEditChallanForm = this.fb.group({
      challanDate: ['', Validators.required],
      merchantId: ['', Validators.required],
      siteId: ['', Validators.required],
      challanNo: ['', Validators.required],
      carNo: ['', Validators.required],
      remarks: [''],
      challanFile: ['']
    });
    if (this.challanId && this.challanId != null && this.challanId != undefined) {
      this.getChallanDetails();
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
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

  onFileSelected(event: Event): void {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.challanFile = inputElement.files[0];
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

  getMerchantList() {
    const apiUrl = this.apiUrl.apiUrl.Challan.MerchantList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.merchantList = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  submitChallanForm() {
    this.submitted = true;
    if (this.AddEditChallanForm.invalid) {
      return;
    }
    this.spinner.show();
    const formData = new FormData();
    formData.append('challanId', this.challanId && this.challanId != null && this.challanId != undefined ? this.challanId : "");
    formData.append('challanDate', this.formatDate(this.AddEditChallanForm.value.challanDate, "12:00 AM"));
    formData.append('siteId', this.AddEditChallanForm.value.siteId ? this.AddEditChallanForm.value.siteId : "");
    formData.append('merchantId', this.AddEditChallanForm.value.merchantId ? this.AddEditChallanForm.value.merchantId : "");
    formData.append('challanNo', this.AddEditChallanForm.value.challanNo);
    formData.append('carNo', this.AddEditChallanForm.value.carNo);
    formData.append('remarks', this.AddEditChallanForm.value.remarks?.trim());
    formData.append('challanPhoto', this.challanFile);
    
    const apiUrl = this.apiUrl.apiUrl.Challan.SaveChallan;
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

  getChallanDetails() {
    const apiUrl = this.apiUrl.apiUrl.Challan.GetChallanById.replace('{challanId}', this.challanId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedChallanDetails = response.data;
        this.AddEditChallanForm.patchValue({
          challanDate: this.editedChallanDetails.challanDate,
          challanNo: this.editedChallanDetails.challanNo,
          siteId: this.editedChallanDetails.siteId,
          merchantId: this.editedChallanDetails.merchantId,
          carNo: this.editedChallanDetails.carNo,
          remarks: this.editedChallanDetails.remarks ? this.editedChallanDetails.remarks : "",
        });
        this.challanId = this.editedChallanDetails.challanId
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  getChallanTypeDetalis() {
    const apiUrl = this.apiUrl.apiUrl.Expense.GetExpenseTypeList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.expenseType = response.data;
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
