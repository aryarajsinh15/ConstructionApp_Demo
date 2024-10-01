import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from 'app/services/common/common.service';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { LanguageService } from 'app/services/language/language.service';
import { ToastrService } from 'ngx-toastr';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'vex-add-edit-vehicle-rent',
  templateUrl: './add-edit-vehicle-rent.component.html',
  styleUrl: './add-edit-vehicle-rent.component.scss'
})
export class AddEditVehicleRentComponent {

  AddEditVehicleRentForm: FormGroup;
  submitted: boolean = false;
  vehicleOwnerId: any;
  vehicleRentId: any;
  vehicleOwner: any[] = [];
  editedVehicleRentDetails: any;
  minDate: any = new Date();

  constructor(
    private dialogRef: MatDialogRef<AddEditVehicleRentComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private languageService: LanguageService,
    private translate: TranslateService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService) {
    this.vehicleOwnerId = data.VehicleOwnerId;
    this.vehicleRentId = data.vehicleRentId;
  }

  formatDate(dateString: string, timeString: string): string {
    const date = new Date(dateString);
    const timeParts = timeString.split(":");
    let hours = parseInt(timeParts[0]);
    const minutes = parseInt(timeParts[1].split(" ")[0]);
    const meridian = timeParts[1].split(" ")[1];
    if (meridian === "PM" && hours !== 12) {
      hours += 12;
    } else if (meridian === "AM" && hours === 12) {
      hours = 0;
    }
    date.setHours(hours, minutes);
    const localDate = new Date(date.getTime() - (date.getTimezoneOffset() * 60000));
    return localDate.toISOString();
  }

  ngOnInit(): void {
    this.onVehicleOwnerChange();
    this.AddEditVehicleRentForm = this.fb.group({
      fromLocation: ['', Validators.required],
      toLocation: ['', Validators.required],
      vehicleNumber: ['', Validators.required],
      amount: ['', Validators.required],
      remarks: [''],
      vehicleOwnerId: ['', Validators.required],
      vehicleRentDate: ['', Validators.required],
    });
    if (this.vehicleRentId && this.vehicleRentId != null && this.vehicleRentId != undefined) {
      this.getVehicleRentDetails()
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  onVehicleOwnerChange() {
    const apiUrl = this.apiUrl.apiUrl.VehicleRent.VehicleOwnerlist;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.vehicleOwner = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  submitVehicleRentForm() {
    this.submitted = true;
    if (this.AddEditVehicleRentForm.invalid) {
      return;
    }
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.VehicleRent.SaveVehicleRent;
    const formData = new FormData();
    formData.append('vehicleRentId', this.vehicleRentId && this.vehicleRentId != null && this.vehicleRentId != undefined ? this.vehicleRentId : "");
    formData.append('vehicleRentDate', this.formatDate(this.AddEditVehicleRentForm.value.vehicleRentDate, "12:00 AM"));
    formData.append('vehicleOwnerId', this.AddEditVehicleRentForm.value.vehicleOwnerId);
    formData.append('fromLocation', this.AddEditVehicleRentForm.value.fromLocation);
    formData.append('toLocation', this.AddEditVehicleRentForm.value.toLocation);
    formData.append('vehicleNumber', this.AddEditVehicleRentForm.value.vehicleNumber);
    formData.append('amount', this.AddEditVehicleRentForm.value.amount);
    formData.append('remarks', this.AddEditVehicleRentForm.value.remarks);
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

  onOwnerTypeChange(vehicleOwnerId: any): void {
    this.vehicleOwnerId = vehicleOwnerId
    if (vehicleOwnerId == 1) {
      this.AddEditVehicleRentForm.controls["vehicleOwnerId"].addValidators([Validators.required]);
    }
    else {
      this.AddEditVehicleRentForm.get('vehicleOwnerId').clearValidators();
      this.AddEditVehicleRentForm.patchValue({
        siteId: null,
      });
    }
    this.AddEditVehicleRentForm.get('vehicleOwnerId').updateValueAndValidity();
  }

  getVehicleRentDetails() {
    const apiUrl = this.apiUrl.apiUrl.VehicleRent.GetVehicleRentById.replace('{vehicleRentId}', this.vehicleRentId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedVehicleRentDetails = response.data;
        this.AddEditVehicleRentForm.patchValue({
          vehicleRentId: this.editedVehicleRentDetails.vehicleRentId,
          vehicleRentDate: this.editedVehicleRentDetails.vehicleRentDate,
          fromLocation: this.editedVehicleRentDetails.fromLocation,
          toLocation: this.editedVehicleRentDetails.toLocation,
          vehicleNumber: this.editedVehicleRentDetails.vehicleNumber,
          vehicleOwnerId: this.editedVehicleRentDetails.vehicleOwnerId,
          amount: this.editedVehicleRentDetails.amount,
          remarks: this.editedVehicleRentDetails.remarks ? this.editedVehicleRentDetails.remarks : ""
        });
        this.vehicleRentId = this.editedVehicleRentDetails.vehicleRentId
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