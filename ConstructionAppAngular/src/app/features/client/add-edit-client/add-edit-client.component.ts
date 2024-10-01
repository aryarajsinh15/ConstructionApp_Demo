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
  selector: 'vex-add-edit-client',
  templateUrl: './add-edit-client.component.html',
  styleUrl: './add-edit-client.component.scss'
})
export class AddEditClientComponent {

  AddEditClientForm: FormGroup;
  submitted: boolean = false;
  clientId: any;
  editedClientDetails: any = {};
  packageType: any[] = [];
  headerFile: any;
  selectdHeaderFile: any;
  footerFile: any;
  selectdFooterFile: any;

  constructor(
    private dialogRef: MatDialogRef<AddEditClientComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private toastr: ToastrService,
    private languageService: LanguageService,
    private translate: TranslateService,
    private spinner: NgxSpinnerService) {
    this.clientId = data.ClientId;
  }

  ngOnInit(): void {
    this.getPackageTypeDetalis();
    this.AddEditClientForm = this.fb.group({
      clientName: ['', Validators.required],
      firmName: ['', Validators.required],
      packageType: ['', Validators.required],
      expireDate: ['', Validators.required],
      address: [''],
      remarks: [''],
      headerFile: [null],
      footerFile: [null]
    });
    if (this.clientId && this.clientId != null && this.clientId != undefined) {
      this.getClientDetails();
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
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

  onHeaderFileSelected(event: Event): void {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.headerFile = inputElement.files[0];
      const file = inputElement.files[0];
      const maxSize = 10 * 1024 * 1024; // 10 MB in bytes
      const validTypes = ['image/png', 'image/jpeg', 'image/jpg'];
      if (file.size > maxSize) {
        this.toastr.error('File size exceeds the maximum limit (10 MB)');
        this.headerFile = null;
        inputElement.value = ''; 
        return;
      }
      if (!validTypes.includes(file.type)) {
        this.toastr.error('Invalid file type. Only .png, .jpg, and .jpeg files are allowed.');
        this.headerFile = null;
        inputElement.value = '';
        return;
      }
      const reader = new FileReader();
      reader.onload = (e) => {
        this.selectdHeaderFile = e.target.result as string;
      };
      reader.readAsDataURL(file);
    } else {
      this.selectdHeaderFile = null;
    }
  }

  onFooterFileSelected(event: Event): void {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.footerFile = inputElement.files[0];
      const file = inputElement.files[0];
      const maxSize = 10 * 1024 * 1024; // 10 MB in bytes
      const validTypes = ['image/png', 'image/jpeg', 'image/jpg'];
      if (file.size > maxSize) {
        this.toastr.error('File size exceeds the maximum limit (10 MB)');
        this.footerFile = null;
        inputElement.value = ''; 
        return;
      }
      if (!validTypes.includes(file.type)) {
        this.toastr.error('Invalid file type! only .png, .jpg, and .jpeg files are allowed.');
        this.footerFile = null;
        inputElement.value = '';
        return;
      }
      const reader = new FileReader();
      reader.onload = (e) => {
        this.selectdFooterFile = e.target.result as string;
      };
      reader.readAsDataURL(file);
    } else {
      this.selectdFooterFile = null;
    }
  }

  submitClientForm() {
    this.submitted = true;
    if (this.AddEditClientForm.invalid) {
      return;
    }
    this.spinner.show();
    const formData = new FormData();
    formData.append('clientId', this.clientId && this.clientId != null && this.clientId != undefined ? this.clientId : "");
    formData.append('clientName', this.AddEditClientForm.value.clientName?.trim());
    formData.append('firmName', this.AddEditClientForm.value.firmName?.trim());
    formData.append('packageTypeId', this.AddEditClientForm.value.packageType);
    formData.append('expireDate', this.formatDate(this.AddEditClientForm.value.expireDate, "12:00 AM"));
    formData.append('address', this.AddEditClientForm.value.address?.trim());
    formData.append('remarks', this.AddEditClientForm.value.remarks?.trim());
    formData.append('HeaderImage', this.headerFile);
    formData.append('FooterImage', this.footerFile);

    const apiUrl = this.apiUrl.apiUrl.Client.SaveClient;
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

  getClientDetails() {
    const apiUrl = this.apiUrl.apiUrl.Client.GetClientById.replace('{clientId}', this.clientId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedClientDetails = response.data;
        this.AddEditClientForm.patchValue({
          clientName: this.editedClientDetails.clientName,
          firmName: this.editedClientDetails.firmName,
          packageType: this.editedClientDetails.packageTypeId,
          expireDate: this.editedClientDetails.expireDate,
          address: this.editedClientDetails.address ? this.editedClientDetails.address : "",
          remarks: this.editedClientDetails.remarks ? this.editedClientDetails.remarks : ""
        });
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  getPackageTypeDetalis() {
    const apiUrl = this.apiUrl.apiUrl.Client.GetPackageTypeList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.packageType = response.data;
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