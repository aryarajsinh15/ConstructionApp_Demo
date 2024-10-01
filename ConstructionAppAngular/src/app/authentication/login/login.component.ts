import { ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { fadeInUp400ms } from '@vex/animations/fade-in-up.animation';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { StorageService } from 'app/services/storage/storage.service';
import { CommonService } from 'app/services/common/common.service';
import { ToastrService } from 'ngx-toastr';
import { NgxSpinnerService } from 'ngx-spinner';
import { TranslateService } from '@ngx-translate/core';
import { LanguageService } from 'app/services/language/language.service';

@Component({
  selector: 'vex-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  animations: [
    fadeInUp400ms
  ]
})
export class LoginComponent implements OnInit {

  loginForm: FormGroup = this.formBuilder.group({});
  submitted = false;
  inputType = 'password';
  visible = false;
  

  constructor(private router: Router,
    private formBuilder: FormBuilder,
    private storageService: StorageService,
    private commonService: CommonService,
    private cd: ChangeDetectorRef,
    private toastr: ToastrService,
    private apiUrl: ApiUrlHelper,
    private spinner: NgxSpinnerService
  ) { }

  ngOnInit() {
    this.OnInitLoginForm();
    var token = this.storageService.getValue('authToken');
    var userId = this.storageService.getValue('userId');
    var firmName = this.storageService.getValue('firmName');
    var fullName = this.storageService.getValue('fullName');
    var roleId = this.storageService.getValue('roleId');
    var rolaName = this.storageService.getValue('roleName');
    if (token != null && token != undefined && userId != null && userId != undefined
      && firmName != null && firmName != undefined && fullName != null && fullName != undefined
      && roleId != null && roleId != undefined && rolaName != null && rolaName != undefined) {
      this.router.navigate(['/dashboard'])
    }
  }

  OnInitLoginForm() {
    this.loginForm = this.formBuilder.group({
      email: ['', [Validators.required]],
      password: ['', [Validators.required, Validators.maxLength(100)]],
    });
  }

  get loginFormControl() {
    return this.loginForm.controls;
  }

  onLogin(): void {
    this.submitted = true;
    const email = this.loginForm.value.email?.trim();
    const password = this.loginForm.value.password?.trim();
    if (this.loginForm.invalid || !email || !password) {
      return;
    }
    this.spinner.show();
    const loginData = {
      userName: email,
      password: password
    };
    const apiUrl = this.apiUrl.apiUrl.Login.UserLogin;
    this.commonService.doPost(apiUrl, loginData).subscribe({
      next: (response) => {
        if (response.success) {
          this.storageService.setValue('authToken', response.data.jwtToken);
          this.storageService.setValue('userId', response.data.userId);
          this.storageService.setValue('firmName', response.data.firmName);
          this.storageService.setValue('fullName', response.data.fullName);
          this.storageService.setValue('roleId', response.data.roleId);
          this.storageService.setValue('roleName', response.data.roleName);
          this.storageService.setValue('userImage', response.data.userPhoto);
          this.storageService.subject.next(response.data.userPhoto);
          // this.toastr.success(response.message);
          this.storageService.updateRole(response.data.roleId);
          this.router.navigate(['/dashboard']);
          this.spinner.hide();
        } else {
          this.toastr.error(response.message);
          this.spinner.hide();
        }
      },
      error: (err) => {
        console.error('Login error:', err);
        this.spinner.hide();
        localStorage.clear();
      }
    });
  }

  removeSpaces(event: any) {
    const inputValue = event.target.value;
    event.target.value = inputValue.replace(/\s/g, '');
    this.loginForm.controls['email'].setValue(event.target.value);
  }


  toggleVisibility() {
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
}