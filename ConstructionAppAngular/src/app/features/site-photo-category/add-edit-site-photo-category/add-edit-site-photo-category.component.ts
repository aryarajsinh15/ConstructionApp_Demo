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
  selector: 'vex-add-edit-site-photo-category',
  templateUrl: './add-edit-site-photo-category.component.html',
  styleUrl: './add-edit-site-photo-category.component.scss'
})
export class AddEditSitePhotoCategoryComponent {

  AddEditSiteCategoryForm: FormGroup;
  submitted: boolean = false;
  sitePhotoCategoryId: any;
  editedSiteCategoryDetails: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditSitePhotoCategoryComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private languageService: LanguageService,
    private translate: TranslateService,
    private spinner: NgxSpinnerService,
    private toastr: ToastrService) {
    this.sitePhotoCategoryId = data.SitePhotoCategoryId;
  }

  ngOnInit(): void {
    this.AddEditSiteCategoryForm = this.fb.group({
      categoryName: ['', [Validators.required, Validators.maxLength(100)]],
    });
    if (this.sitePhotoCategoryId && this.sitePhotoCategoryId != null && this.sitePhotoCategoryId != undefined) {
      this.getSiteCategoryDetails();
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  submitSiteCategoryForm() {
    this.submitted = true;
    if (this.AddEditSiteCategoryForm.invalid) {
      return;
    }
    this.spinner.show();
    const obj = {
      sitePhotoCategoryId: this.sitePhotoCategoryId && this.sitePhotoCategoryId != null && this.sitePhotoCategoryId != undefined ? this.sitePhotoCategoryId : null,
      categoryName: this.AddEditSiteCategoryForm.value.categoryName?.trim(),
    };
    const apiUrl = this.apiUrl.apiUrl.SiteCategory.SaveSiteCategory;
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

  getSiteCategoryDetails() {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.SiteCategory.GetSiteCategoryById.replace('{sitePhotoCategoryId}', this.sitePhotoCategoryId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedSiteCategoryDetails = response.data;
        this.AddEditSiteCategoryForm.patchValue({
          categoryName: this.editedSiteCategoryDetails.categoryName,
        });
        this.spinner.hide();
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
}