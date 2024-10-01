import { Component, OnInit, Inject } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { TranslateService } from '@ngx-translate/core';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'vex-add-edit-person-attendance',
  templateUrl: './add-edit-person-attendance.component.html',
  styleUrl: './add-edit-person-attendance.component.scss'
})
export class AddEditPersonAttendanceComponent implements OnInit {
  AddEditPersonAttendanceForm: FormGroup;
  submitted: boolean = false;
  AttendanceId: any;
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  siteList: any = [];
  showData: boolean = false;
  personList = [];
  personAttendanceDetail: any = {};

  constructor(
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private translate: TranslateService,
    private languageService: LanguageService,
    private spinner: NgxSpinnerService,
    private toastr: ToastrService,
    private route: ActivatedRoute,
    private router: Router,
  ) { }

  ngOnInit() {

    this.fetchSiteList();
    let AttendanceObj: any = atob((this.route.snapshot.paramMap.get('attendanceId')));
    AttendanceObj = JSON.parse(AttendanceObj)
    this.AttendanceId = AttendanceObj.attendanceId;
    this.AddEditPersonAttendanceForm = this.fb.group({
      attendanceId: [''],
      attendanceDate: ['', Validators.required],
      attendanceList: this.fb.array([])
    });
    if (this.AttendanceId && this.AttendanceId != null && this.AttendanceId != undefined) {
      this.getPersonAttendanceDetails(this.AttendanceId);
    }
    else {
      this.getPersonList();
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

  submitPesronAttendanceForm() {
    this.submitted = true;
    if (this.AddEditPersonAttendanceForm.invalid) {
      return;
    }
    let attendanceList = [];
    let data = (this.AddEditPersonAttendanceForm.get("attendanceList") as FormArray).controls;
    data.forEach(x => {
      var obj = {
        personAttendanceId: x.get('personAttendanceId').value,
        personId: x.value.personId,
        attendanceStatus: x.value.attendanceStatus ? parseFloat(x.value.attendanceStatus) : 0,
        siteId: x.value.siteId,
        withdrawAmount: x.value.withdrawAmount ? Number.parseFloat(x.value.withdrawAmount) : 0,
        overtimeAmount: x.value.overtimeAmount ? Number.parseFloat(x.value.overtimeAmount) : 0,
        remarks: x.value.remarks,
      }
      attendanceList.push(obj);
    })
    const obj = {
      attendanceId: this.AttendanceId && this.AttendanceId != null && this.AttendanceId != undefined ? this.AttendanceId : null,
      attendanceDate: this.formatDate(this.AddEditPersonAttendanceForm.get('attendanceDate').value, "12:00 AM"),
      attendanceList: attendanceList
    };
    const apiUrl = this.apiUrl.apiUrl.PersonAttendance.SavePersonAttendance;
    this.spinner.show();
    this.commonService.doPost(apiUrl, obj).pipe().subscribe({
      next: (response) => {
        this.spinner.hide();
        if (response.success) {
          this.toastr.success(response.message);
          this.router.navigate(['/attendance']);
        } else {
          this.toastr.error(response.message);
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  createItem() {
    const attendanceArray = this.AddEditPersonAttendanceForm.get("attendanceList") as FormArray;
    this.personList.forEach(person => {
      const attendanceGroup = this.fb.group({
        personAttendanceId: [''],
        personId: [person.personId],
        personName: [person.personFirstName],
        attendanceStatus: ['', Validators.required],
        siteId: ['', Validators.required], 
        withdrawAmount: [''],
        overtimeAmount: [''],
        remarks: [''],
      });
      attendanceArray.push(attendanceGroup);
    });
  }

  attendanceFormArray(): FormArray {
    return this.AddEditPersonAttendanceForm.get("attendanceList") as FormArray;
  }

  getItemDetails(index: number): FormArray {
    return this.getItemAtIndex(index).get('itemDetail') as FormArray
  }

  getItemAtIndex(index: number): FormGroup {
    return this.attendanceList.at(index) as FormGroup;
  }

  get attendanceList(): FormArray {
    return this.AddEditPersonAttendanceForm.get('attendanceList') as FormArray;
  }

  attendance(index: any): any {
    return (this.AddEditPersonAttendanceForm.get('attendanceList') as FormArray).at(index) as FormGroup;
  }

  changeAttendenceStatus(index: number, event: any) {
    const attendanceFormGroup = this.attendance(index);
    if (event.value === "0") {
      attendanceFormGroup.patchValue({
        siteId: '',
        overtimeAmount: ''
      });
      attendanceFormGroup.get("siteId").clearValidators();
      attendanceFormGroup.get("siteId").disable();
      attendanceFormGroup.get("overtimeAmount").clearValidators();
      attendanceFormGroup.get("overtimeAmount").disable();
    } else {
      attendanceFormGroup.get("siteId").setValidators([Validators.required]);
      attendanceFormGroup.get("siteId").enable();
      attendanceFormGroup.get("overtimeAmount").enable();
    }
    attendanceFormGroup.get("siteId").updateValueAndValidity();
    attendanceFormGroup.get("overtimeAmount").updateValueAndValidity();
  }

  getPersonAttendanceDetails(AttendanceId) {
    let api = this.apiUrl.apiUrl.PersonAttendance.GetPersonAttendanceDetails.replace("{id}", AttendanceId);

    this.spinner.show();
    this.commonService.doGet(api).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.personAttendanceDetail = response.data;
          this.AddEditPersonAttendanceForm.patchValue({
            attendanceDate: response.data.attendanceDate
          })
          const attendanceArray = this.AddEditPersonAttendanceForm.get('attendanceList') as FormArray;
          attendanceArray.clear(); // Clear previous items if any

          this.personAttendanceDetail.attendanceList.forEach((attendanceItem: any, index: any) => {
            const attendanceGroup = this.fb.group({
              personAttendanceId: [attendanceItem.personAttendanceId],
              attendanceStatus: [(attendanceItem.attendanceStatus).toString(), Validators.required],
              personName: [attendanceItem.personName],
              personId: [attendanceItem.personId],
              siteId: [{ value: attendanceItem.attendanceStatus == "0" ? '' : attendanceItem.siteId, disabled: attendanceItem.attendanceStatus == "0" ? true : false }, attendanceItem.attendanceStatus == "0" ? '' : Validators.required],
              withdrawAmount: [attendanceItem.withdrawAmount == "0" ? '' : attendanceItem.withdrawAmount],
              overtimeAmount: [{ value: attendanceItem.attendanceStatus == "0" ? '' :( attendanceItem.overtimeAmount == "0" ? '' : attendanceItem.overtimeAmount ), disabled: attendanceItem.attendanceStatus == "0" ? true : false }],
              remarks: [attendanceItem.remarks]
            });
            attendanceArray.push(attendanceGroup);
          });

          this.spinner.hide();
        } else {
          this.spinner.hide();
          this.totalrecord = 0;
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  fetchSiteList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.Site.GetSiteList;
    let SiteModel = {
      pageNumber: 1,
      pageSize: 1000000,
      sortColumn: "",
      sortOrder: "",
      strSearch: "", 
      startDate: null,
      endDate: null,
      activeInActiveStatus: '0,1'
    };
    this.commonService.doPost(api, SiteModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.siteList = response.data;
          this.spinner.hide();
          if (this.siteList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.siteList.length != 0) {
            this.showData = false;
          }
        } else {
          this.spinner.hide();
          this.totalrecord = 0;
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  getPersonList() {
    this.showData = false;
    let api = this.apiUrl.apiUrl.Persons.GetPerosnAttedanceList;
    let obj = {
      pageNumber: 1,
      pageSize: 1000000,
      sortColumn: 'PersonFirstName',
      sortOrder: 'asc',
      strSearch: '',
      activeInActiveStatus: '1'
    };
    this.spinner.show();
    this.commonService.doPost(api, obj).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.personList = response.data;
          this.createItem();
          this.spinner.hide();
        } else {
          this.spinner.hide();
        }
      },
      error: (error) => {
        this.spinner.hide();
        console.log(error);
      }
    });
  }

  cancel() {
    this.router.navigate(["attendance"]);
  }

  backToAttendance() {
    this.router.navigate(["attendance"]);
  }
}
