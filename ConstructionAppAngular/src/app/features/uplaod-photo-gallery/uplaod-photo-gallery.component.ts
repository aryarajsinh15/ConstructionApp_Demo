import { Component, ElementRef, Inject, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-uplaod-photo-gallery',
  templateUrl: './uplaod-photo-gallery.component.html',
  styleUrl: './uplaod-photo-gallery.component.scss'
})
export class UplaodPhotoGalleryComponent {

  @ViewChild('fileInput') fileInput: ElementRef;
  uplaodSiteImageForm: FormGroup;
  submitted: boolean = false;
  siteId: any;
  siteImage: any;
  selectdFile: any;
  category: any = [];
  activeSiteCategory: any[] = [];
  siteCategoryId: any;
  imageCategoryList = [];

  constructor(
    private dialogRef: MatDialogRef<UplaodPhotoGalleryComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private languageService: LanguageService,
    private translate: TranslateService,
    private spinner: NgxSpinnerService,
    private toastr: ToastrService) {
    this.siteId = data.SiteId;
  }

  ngOnInit(): void {
    this.getActiveSitePhotoCategoryList();
    this.uplaodSiteImageForm = this.fb.group({
      categoryName: ['', Validators.required],
      siteImage: ['', Validators.required]
    });
  }

  onFileSelected(event: Event): void {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      const files = inputElement.files;
      const maxSize = 10 * 1024 * 1024; // 10 MB in bytes
      const validTypes = ['image/png', 'image/jpeg', 'image/jpg'];
  
      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        if (file.size > maxSize) {
          this.toastr.error('File size exceeds the maximum limit (10 MB)');
          return;
        }
        if (!validTypes.includes(file.type)) {
          this.toastr.error('Invalid file type. only .png, .jpg, and .jpeg files are allowed.');
          this.siteImage = null;
          this.fileInput.nativeElement.value = '';
          return;
        }
        this.imageCategoryList.push(file);
        const reader = new FileReader();
        reader.onload = (e) => {
          this.selectdFile = e.target.result as string;
        };
        reader.readAsDataURL(file);
      }
    } else {
      this.selectdFile = null;
    }
  }

  getActiveSitePhotoCategoryList() {
    const apiUrl = this.apiUrl.apiUrl.SiteCategory.GetActiveSiteCategory;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.activeSiteCategory = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  submitSiteImageForm() {
    this.submitted = true;
    if (this.uplaodSiteImageForm.invalid) {
      return;
    }
    this.spinner.show();
    const formData = new FormData();
    formData.append('SiteId', this.siteId ? this.siteId : "");
    formData.append('SiteCategoryId', this.uplaodSiteImageForm.value.categoryName);
    for (let i = 0; i < this.imageCategoryList.length; i++) {
      formData.append('Photo', this.imageCategoryList[i]);
    }
    const apiUrl = this.apiUrl.apiUrl.Site.SaveSiteCategoryImage;
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

  cancel() {
    this.dialogRef.close();
  }
}