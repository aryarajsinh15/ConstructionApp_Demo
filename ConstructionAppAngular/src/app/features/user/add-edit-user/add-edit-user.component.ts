import { ChangeDetectorRef, Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-add-edit-user',
  templateUrl: './add-edit-user.component.html',
  styleUrl: './add-edit-user.component.scss'
})
export class AddEditUserComponent {

  inputType = 'password';
  visible = false;
  AddEditUserForm: FormGroup;
  submitted: boolean = false;
  userId: any;
  clientId: any;
  editedUserDetails: any;

  constructor(private cd: ChangeDetectorRef,
    private dialogRef: MatDialogRef<AddEditUserComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private toastr: ToastrService,
    private languageService: LanguageService,
    private translate: TranslateService,
    private spinner: NgxSpinnerService) {
    this.userId = data.UserId;
    this.clientId = data.ClientId
    if (!this.clientId || this.clientId == null || this.clientId == undefined) {
      this.clientId = null;
    }
  }

  ngOnInit(): void {
    this.AddEditUserForm = this.fb.group({
      userName: ['', Validators.required],
      password: ['', Validators.required],
      name: ['', Validators.required],
      email: ['', [Validators.required, Validators.pattern(/^(?=.{1,30}@)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)]],
      mobileNumber: ['', [Validators.required, Validators.minLength(10)]],
    });
    if (this.userId && this.userId != null && this.userId != undefined) {
      this.getUserDetails();
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  submitUserForm() {
    this.submitted = true;
    if (this.AddEditUserForm.invalid) {
      return;
    }
    this.spinner.show();
    const obj = {
      UserId: this.userId && this.userId != null && this.userId != undefined ? this.userId : null,
      UserName: this.AddEditUserForm.value.userName?.trim(),
      Password: this.AddEditUserForm.value.password?.trim(),
      Name: this.AddEditUserForm.value.name?.trim(),
      Email: this.AddEditUserForm.value.email?.trim(),
      MobileNumber: this.AddEditUserForm.value.mobileNumber?.toString(),
      clientId: this.clientId
    };
    const apiUrl = this.apiUrl.apiUrl.User.SaveUser;
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

  getUserDetails() {
    const apiUrl = this.apiUrl.apiUrl.User.GetUserById.replace('{userId}', this.userId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedUserDetails = response.data;
        this.AddEditUserForm.patchValue({
          userName: this.editedUserDetails.userName,
          password: this.editedUserDetails.password,
          name: this.editedUserDetails.name,
          email: this.editedUserDetails.emailId,
          mobileNumber: this.editedUserDetails.mobileNo,
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

  removeSpaces(event: any) {
    const inputValue = event.target.value;
    event.target.value = inputValue.replace(/\s/g, '');
    this.AddEditUserForm.controls['userName'].setValue(event.target.value);
  }

  removeSpacesFromEmail(event: any) {
    const inputValue = event.target.value;
    event.target.value = inputValue.replace(/\s/g, '');
    this.AddEditUserForm.controls['email'].setValue(event.target.value);
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