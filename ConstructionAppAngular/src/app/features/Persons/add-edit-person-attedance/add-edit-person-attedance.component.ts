import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import { AddEditPersonComponent } from '../add-edit-person/add-edit-person.component';

@Component({
  selector: 'vex-add-edit-person-attedance',
  templateUrl: './add-edit-person-attedance.component.html',
  styleUrl: './add-edit-person-attedance.component.scss'
})
export class AddEditPersonAttedanceComponent {
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
      dailyRate: ['', Validators.required],
      id: ['', Validators.required],
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
          dailyRate: this.editedPersonDetails.dailyRate,
          id: this.editedPersonDetails.id,
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
      dailyRate: this.AddEditPersonForm.value.dailyRate,
      PersonTypeId: this.AddEditPersonForm.value.id,
    };
    const apiUrl = this.apiUrl.apiUrl.Persons.SaveAttedancePerson;
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
