import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-add-edit-person',
  templateUrl: './add-edit-person.component.html',
  styleUrl: './add-edit-person.component.scss'
})
export class AddEditPersonComponent {

  personId: any;
  AddEditPersonForm: FormGroup;
  submitted: boolean = false;
  activeClient: any[] = [];
  activePersonType: any[] = [];
  editedPersonDetails: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditPersonComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService) {
    this.personId = data.Personid;
  }

  ngOnInit(): void {
    this.getActivePersonType();
    this.AddEditPersonForm = this.fb.group({
      personFullName: ['', Validators.required],
      personAddress: [''],
      mobileNo: [''],
    });

    if (this.personId && this.personId != null && this.personId != undefined && this.personId != 0) {
      this.getPersonDetails();
    }
  }

  getActiveClientList() {
    const apiUrl = this.apiUrl.apiUrl.Merchant.GetActiveClientList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.activeClient = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  getActivePersonType() {
    const apiUrl = this.apiUrl.apiUrl.Persons.GetActivePersonType
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.activePersonType = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  getPersonDetails() {
    const apiUrl = this.apiUrl.apiUrl.Persons.GetPersonById.replace('{id}', this.personId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedPersonDetails = response.data;
        this.AddEditPersonForm.patchValue({
          personFullName: this.editedPersonDetails.personFirstName,
          personAddress: this.editedPersonDetails.personAddress ? this.editedPersonDetails.personAddress : "",
          mobileNo: this.editedPersonDetails.mobileNo,
        });
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  submitPersonForm() {
    this.submitted = true;
    if (this.AddEditPersonForm.invalid) {
      return;
    }
    this.spinner.show();
    const obj = {
      personId: this.personId && this.personId != null && this.personId != undefined ? this.personId : null,
      personFirstName: this.AddEditPersonForm.value.personFullName?.trim(),
      personAddress: this.AddEditPersonForm.value.personAddress.trim(),
      mobileNo: this.AddEditPersonForm.value.mobileNo.toString(),
    };
    const apiUrl = this.apiUrl.apiUrl.Persons.SavePerson;
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

  cancel() {
    this.dialogRef.close();
  }
}