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
  selector: 'vex-add-edit-estimate',
  templateUrl: './add-edit-estimate.component.html',
  styleUrl: './add-edit-estimate.component.scss'
})
export class AddEditEstimateComponent {
  AddEditEstimateForm: FormGroup;
  submitted: boolean = false;
  Estimate: any[] = [];
  estimateId: any;
  editedEstimateDetails: any = {};
  minDate: any = new Date();
  estimateFile: any;
  selectdFile: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditEstimateComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private languageService: LanguageService,
    private translate: TranslateService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService) {
    this.estimateId = data.estimateId;
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

  ngOnInit(): void {
    this.AddEditEstimateForm = this.fb.group({
      estimateDate: ['', Validators.required],
      partyName: ['', Validators.required],
      totalAmount: ['', [Validators.required]],
      estimateFile: [''],
      remarks: [''],
    });
    if (this.estimateId && this.estimateId != null && this.estimateId != undefined) {
      this.getEstimateDetails()
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  submitEstimateForm() {
    this.submitted = true;
    if (this.AddEditEstimateForm.invalid) {
      return;
    }
    if (this.AddEditEstimateForm.valid) {
      this.spinner.show();
      const apiUrl = this.apiUrl.apiUrl.Estimate.SaveEstimate;
      const formData = new FormData();
      formData.append('estimateId', this.estimateId && this.estimateId != null && this.estimateId != undefined ? this.estimateId : "");
      formData.append('estimateDate', this.formatDate(this.AddEditEstimateForm.value.estimateDate, "12:00 AM"));
      formData.append('partyName', this.AddEditEstimateForm.value.partyName?.trim());
      formData.append('remarks', this.AddEditEstimateForm.value.remarks?.trim(),);
      formData.append('totalAmount', this.AddEditEstimateForm.value.totalAmount);
      formData.append('estimatePhoto', this.estimateFile);
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
  }

  onFileSelected(event: Event): void {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.estimateFile = inputElement.files[0];
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

  getEstimateDetails() {
    const apiUrl = this.apiUrl.apiUrl.Estimate.GetEstimateById.replace('{estimateId}', this.estimateId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedEstimateDetails = response.data;
        this.AddEditEstimateForm.patchValue({
          estimateId: this.editedEstimateDetails.estimateId,
          estimateDate: this.editedEstimateDetails.estimateDate,
          partyName: this.editedEstimateDetails.partyName,
          totalAmount: this.editedEstimateDetails.totalAmount,
          remarks: this.editedEstimateDetails.remarks ? this.editedEstimateDetails.remarks : ""
        });
        this.estimateId = this.editedEstimateDetails.estimateId
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
