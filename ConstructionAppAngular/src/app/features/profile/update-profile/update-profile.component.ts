import { ChangeDetectorRef, Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { StorageService } from 'app/services/storage/storage.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-update-profile',
  templateUrl: './update-profile.component.html',
  styleUrl: './update-profile.component.scss'
})
export class UpdateProfileComponent {

  submitted: boolean = false;
  UpdateProfileForm: FormGroup;
  editedUserDetails: any;
  userImage: any;
  imageSrc: string = '../../../../assets/img/shaligram_logo/default-user-profile.svg';

  constructor(private storageService: StorageService,
    private cd: ChangeDetectorRef,
    private fb: FormBuilder,
    private router: Router,
    private commonService: CommonService,
    private spinner: NgxSpinnerService,
    private toastr: ToastrService,
    private apiUrl: ApiUrlHelper,
    private translate: TranslateService,
    private languageService: LanguageService) { }

  ngOnInit(): void {
    this.getUserDetails();
    this.UpdateProfileForm = this.fb.group({
      userName: ['', Validators.required],
      email: ['', Validators.required],
      name: ['', Validators.required],
      mobileNo: ['', Validators.required],
      userPhoto: [],
    });
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  onFileSelected(event: any): void {
    const file = event.target.files[0];
    if (file) {
      const fileSizeInBytes = file.size;
      const maxSizeInBytes = 10 * 1024 * 1024; // 10MB
      if (fileSizeInBytes > maxSizeInBytes) {
        this.toastr.error('Selected file exceeds the maximum allowed size (10MB).');
        return;
      }
      this.userImage = file;
      const reader = new FileReader();
      reader.onload = (e: any) => {
        this.imageSrc = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  }

  handleImageError(image: any) {
    this.imageSrc = '../../../../assets/img/shaligram_logo/default-user-profile.svg';
  }

  submitProfileForm() {
    this.submitted = true;
    if (this.UpdateProfileForm.invalid) {
      return;
    }
    this.spinner.show();
    const formData = new FormData();
    formData.append('FirstName', this.UpdateProfileForm.value.name.trim());
    formData.append('UserEmail', this.UpdateProfileForm.value.email.trim());
    formData.append('UserName', this.UpdateProfileForm.value.userName.trim());
    formData.append('MobileNo', this.UpdateProfileForm.value.mobileNo.trim());
    formData.append('UserPhoto', this.userImage ? this.userImage : '');
    const apiUrl = this.apiUrl.apiUrl.Profile.UpdateProfile;
    this.commonService.doPost(apiUrl, formData).pipe().subscribe({
      next: (response) => {
        if (response.success) {
          this.spinner.hide();
          this.submitted = false;
          localStorage.setItem('fullName', this.UpdateProfileForm.value.name);
          localStorage.setItem('userImage', this.userImage);
          this.getUserDetails();
          this.toastr.success(response.message);
        } else {
          this.toastr.error(response.message);
          this.spinner.hide();
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  getUserDetails() {
    const apiUrl = this.apiUrl.apiUrl.Profile.GetUserDetails;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedUserDetails = response.data;
        this.UpdateProfileForm.patchValue({
          userName: this.editedUserDetails.userName,
          email: this.editedUserDetails.emailId,
          name: this.editedUserDetails.name,
          mobileNo: this.editedUserDetails.mobileNo,
        });
        this.imageSrc = this.editedUserDetails.userPhoto;
        this.storageService.setValue('userImage', this.editedUserDetails.userPhoto)
        this.storageService.subject.next(this.editedUserDetails.userPhoto);
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  removeSpaces(event: any) {
    const inputValue = event.target.value;
    event.target.value = inputValue.replace(/\s/g, '');
    this.UpdateProfileForm.controls['userName'].setValue(event.target.value);
  }

  removeSpacesFromEmail(event: any) {
    const inputValue = event.target.value;
    event.target.value = inputValue.replace(/\s/g, '');
    this.UpdateProfileForm.controls['email'].setValue(event.target.value);
  }

  cancel() {
    this.router.navigate(['/dashboard']);
  }
}