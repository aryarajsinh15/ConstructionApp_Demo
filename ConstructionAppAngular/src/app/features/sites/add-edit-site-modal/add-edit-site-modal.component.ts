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
  selector: 'vex-add-edit-site-modal',
  templateUrl: './add-edit-site-modal.component.html',
  styleUrl: './add-edit-site-modal.component.scss'
})
export class AddEditSiteModalComponent {

  AddEditSiteForm: FormGroup;
  submitted: boolean = false;
  siteId: any;
  editedSiteDetails: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditSiteModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private languageService:LanguageService,
    private translate:TranslateService,
    private spinner: NgxSpinnerService,
    private toastr: ToastrService) {
    this.siteId = data.SiteId;
  }

  ngOnInit(): void {
    this.AddEditSiteForm = this.fb.group({
      siteName: ['', [Validators.required, Validators.maxLength(100)]],
      siteDescription: ['', Validators.required]
    });
    if (this.siteId && this.siteId != null && this.siteId != undefined) {
      this.getSiteDetails()
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  submitSiteForm() {
    this.submitted = true;
    if (this.AddEditSiteForm.invalid) {
      return;
    }
    this.spinner.show();
    const obj = {
      siteId: this.siteId && this.siteId != null && this.siteId != undefined ? this.siteId : null,
      siteName: this.AddEditSiteForm.value.siteName?.trim(),
      siteDescription: this.AddEditSiteForm.value.siteDescription?.trim()
    };
    const apiUrl = this.apiUrl.apiUrl.Site.SaveSite;
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

  getSiteDetails() {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.Site.GetSiteById.replace('{siteId}', this.siteId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedSiteDetails = response.data;
        this.AddEditSiteForm.patchValue({
          siteName: this.editedSiteDetails.siteName,
          siteDescription: this.editedSiteDetails.siteDescription
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