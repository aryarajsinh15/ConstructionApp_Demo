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
  selector: 'vex-add-edit-expense',
  templateUrl: './add-edit-expense.component.html',
  styleUrl: './add-edit-expense.component.scss'
})
export class AddEditExpenseComponent {

  AddEditExpenseForm: FormGroup;
  submitted: boolean = false;
  expenseId: any;
  editedExpenseDetails: any = {};
  expenseType: any[] = [];
  activeSite: any[] = [];
  expenseTypeId: number = 0;
  minDate: any = new Date();
  expenseFile: any;
  selectdFile: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditExpenseComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private translate: TranslateService,
    private languageService: LanguageService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService) {
    this.expenseId = data.ExpenseId;
  }

  ngOnInit(): void {
    this.getActiveSiteDetails();
    this.getExpenseTypeDetalis();
    this.AddEditExpenseForm = this.fb.group({
      expenseDate: ['', Validators.required],
      expenseType: ['', Validators.required],
      amount: ['', Validators.required],
      siteId: ['', Validators.required],
      description: [''],
      expenseFile: ['']
    });
    if (this.expenseId && this.expenseId != null && this.expenseId != undefined) {
      this.getExpenseDetails();
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
      this.expenseFile = inputElement.files[0];
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

  submitExpenseForm() {
    this.submitted = true;
    if (this.AddEditExpenseForm.invalid) {
      return;
    }
    this.spinner.show();
    const formData = new FormData();
    formData.append('expenseId', this.expenseId && this.expenseId != null && this.expenseId != undefined ? this.expenseId : "");
    formData.append('expenseDate', this.formatDate(this.AddEditExpenseForm.value.expenseDate, "12:00 AM"));
    formData.append('expenseType', this.AddEditExpenseForm.value.expenseType);
    formData.append('amount', this.AddEditExpenseForm.value.amount);
    formData.append('siteId', this.AddEditExpenseForm.value.siteId ? this.AddEditExpenseForm.value.siteId : "");
    formData.append('description', this.AddEditExpenseForm.value.description?.trim());
    formData.append('expenseFile', this.expenseFile);

    const apiUrl = this.apiUrl.apiUrl.Expense.SaveExpense;
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

  getExpenseDetails() {
    const apiUrl = this.apiUrl.apiUrl.Expense.GetExpenseById.replace('{expenseId}', this.expenseId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedExpenseDetails = response.data;
        this.AddEditExpenseForm.patchValue({
          expenseDate: this.editedExpenseDetails.expenseDate,
          expenseType: this.editedExpenseDetails.expenseTypeId,
          amount: this.editedExpenseDetails.amount,
          siteId: this.editedExpenseDetails.siteId,
          description: this.editedExpenseDetails.description ? this.editedExpenseDetails.description :  "",
        });
        this.expenseTypeId = this.editedExpenseDetails.expenseTypeId
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  getExpenseTypeDetalis() {
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

  onExpenseTypeChange(expenseTypeId: any): void {
    this.expenseTypeId = expenseTypeId
    if (expenseTypeId == 1) {
      this.AddEditExpenseForm.controls["siteId"].addValidators([Validators.required]);
    }
    else {
      this.AddEditExpenseForm.get('siteId').clearValidators();
      this.AddEditExpenseForm.patchValue({
        siteId: null,
      });
    }
    this.AddEditExpenseForm.get('siteId').updateValueAndValidity();
  }

  cancel() {
    this.dialogRef.close();
  }
}