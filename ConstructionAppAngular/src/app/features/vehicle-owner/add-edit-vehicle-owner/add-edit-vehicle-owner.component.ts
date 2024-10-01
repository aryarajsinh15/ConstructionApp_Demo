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
  selector: 'vex-add-edit-vehicle-owner',
  templateUrl: './add-edit-vehicle-owner.component.html',
  styleUrl: './add-edit-vehicle-owner.component.scss'
})
export class AddEditVehicleOwnerComponent {

  AddEditVehicleOwnerForm: FormGroup;
  submitted: boolean = false;
  vehicleOwnerId: any;
  editedVehicleOwnerDetails: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditVehicleOwnerComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private languageService: LanguageService,
    private translate: TranslateService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService) {
    this.vehicleOwnerId = data.VehicleOwnerId;
  }

  ngOnInit(): void {
    this.AddEditVehicleOwnerForm = this.fb.group({
      vehicleOwnerName: ['', Validators.required],
      mobileNo: ['', [Validators.required, Validators.minLength(10)]],
      remarks: [''],
    });
    if (this.vehicleOwnerId && this.vehicleOwnerId != null && this.vehicleOwnerId != undefined) {
      this.getVehicleOwnerDetails()
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  submitVehicleOwnerForm() {
    this.submitted = true;
    if (this.AddEditVehicleOwnerForm.invalid) {
      return;
    }
    this.spinner.show();
    const obj = {
      vehicleOwnerId: this.vehicleOwnerId && this.vehicleOwnerId != null && this.vehicleOwnerId != undefined ? this.vehicleOwnerId : null,
      vehicleOwnerName: this.AddEditVehicleOwnerForm.value.vehicleOwnerName?.trim(),
      mobileNo: this.AddEditVehicleOwnerForm.value.mobileNo.toString(),
      remarks: this.AddEditVehicleOwnerForm.value.remarks?.trim()
    };
    const apiUrl = this.apiUrl.apiUrl.VehicleOwner.SaveVehicleOwner;
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

  getVehicleOwnerDetails() {
    const apiUrl = this.apiUrl.apiUrl.VehicleOwner.GetVehicleOwnerById.replace('{vehicleOwnerId}', this.vehicleOwnerId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedVehicleOwnerDetails = response.data;
        this.AddEditVehicleOwnerForm.patchValue({
          vehicleOwnerName: this.editedVehicleOwnerDetails.vehicleOwnerName,
          mobileNo: this.editedVehicleOwnerDetails.mobileNo,
          remarks: this.editedVehicleOwnerDetails.remarks ? this.editedVehicleOwnerDetails.remarks : ""
        })
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
