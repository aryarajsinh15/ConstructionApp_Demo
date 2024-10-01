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
  selector: 'vex-change-password',
  templateUrl: './change-password.component.html',
  styleUrl: './change-password.component.scss'
})
export class ChangePasswordComponent {

  submitted: boolean = false;
  inputType = 'password';
  visible = false;
  newPasswordVisible = false;
  confirmPasswordVisible = false;
  ChangePassForm: FormGroup;
  constructor(private storageService: StorageService, private cd: ChangeDetectorRef, private fb: FormBuilder, private router: Router, private commonService: CommonService, private spinner: NgxSpinnerService, private toastr: ToastrService, private apiUrl: ApiUrlHelper, private translate: TranslateService, private languageService: LanguageService) { }

  ngOnInit(): void {
    this.ChangePassForm = this.fb.group(
      {
        oldPassword: ['', Validators.required],
        newPassword: ['', [Validators.required, Validators.minLength(4)]],
        confirmNewPassword: ['', Validators.required]
      },
      {
        validator: this.passwordMatchValidator,
      }
    );
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  get ChangePassControls() {
    return this.ChangePassForm.controls;
  }

  submitChangePassForm() {
    this.submitted = true;
    if (this.ChangePassForm.invalid) {
      return;
    }
    this.spinner.show();
    let ChangePassModel = {
      OldPassword: this.ChangePassForm.value.oldPassword.trim(),
      NewPassword: this.ChangePassForm.value.newPassword.trim(),
      ConfirmPassword: this.ChangePassForm.value.confirmNewPassword.trim(),
    };
    const apiUrl = this.apiUrl.apiUrl.ChangePassword.ChangePassword;
    this.commonService.doPost(apiUrl, ChangePassModel).pipe().subscribe({
      next: (response) => {
        if (response.success) {
          this.submitted = false;
          this.ChangePassForm.reset();
          this.toastr.success(response.message);
          this.storageService.clearStorage();
          this.spinner.hide();
          this.router.navigate(['/login']);
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

  passwordMatchValidator(formGroup: FormGroup) {
    const newPassword = formGroup.get('newPassword').value;
    const confirmNewPassword = formGroup.get('confirmNewPassword').value;
    return newPassword === confirmNewPassword ? null : { mismatch: true };
  }

  togglePassword() {
    if (this.visible) {
      this.inputType = 'password';
      this.visible = false;
      this.cd.markForCheck();
    } else {
      this.inputType = 'text';
      this.visible = true;
      this.cd.markForCheck();
    }
  }

  cancel() {
    this.router.navigate(['/dashboard']);
  }
}