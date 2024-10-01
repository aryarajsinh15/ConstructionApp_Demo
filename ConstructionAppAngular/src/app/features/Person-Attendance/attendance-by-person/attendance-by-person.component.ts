import { Component, ViewChild } from '@angular/core';
import { UntypedFormControl } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-attendance-by-person',
  templateUrl: './attendance-by-person.component.html',
  styleUrl: './attendance-by-person.component.scss'
})
export class AttendanceByPersonComponent {

  // Fields
  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['date', 'status', 'site', 'withDrawAmount', 'overTimeAmount', 'payableAmount', 'remarks'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  attendanceList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  personName: string = "";
  personId: string = "";
  startDate: any = null;
  endDate: any = null;
  statusIds: any = [];
  siteIds: any = [];
  activeSite: any[] = [];
  totalWithdrawAmount = 0;
  totalOvertimeAmount = 0;
  totalPayableAmount = 0;

  //Constructor
  constructor(private commonService: CommonService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService,
    private apiUrl: ApiUrlHelper,
    private dialog: MatDialog,
    private translate: TranslateService,
    private languageService: LanguageService,
    private route: ActivatedRoute,
    private router: Router) {
    this.startDate = this.commonService.getFirstDateOfCurrentMonth();
    this.endDate = this.commonService.getCurrentDateWithOffset(new Date());
  }

  // Init
  ngOnInit(): void {
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });

    const encodedObj = this.route.snapshot.paramMap.get('person');
    const jsonString = atob(encodedObj);
    const parsedSiteObj = JSON.parse(jsonString);
    this.personId = parsedSiteObj.personId;
    const encodedName = parsedSiteObj.personName;
    this.personName = decodeURIComponent(encodedName);
    this.fetchAttendanceList();
    this.fetchSiteList();
  }

  backToPerson(){
    this.router.navigate(['/attedance/person']);
  }

  // Get Group List
  fetchAttendanceList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.PersonAttendance.GetAttendanceByPerson;
    let paginationModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      startDate: this.startDate ? this.formatDate(this.startDate, "12:00 AM") : null,
      endDate: this.endDate ? this.formatDate(this.endDate, "12:00 AM") : null,
      personId: this.personId,
      statusIds: this.statusIds.length > 0 ? this.statusIds.join(',') : '',
      siteIds: this.siteIds.length > 0 ? this.siteIds.join(',') : '',
    };
    this.commonService.doPost(api, paginationModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.attendanceList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.attendanceList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.attendanceList.length != 0) {
            this.showData = false;
          }
          this.paginator.pageIndex = this.currentPage;
          this.paginator.length = this.totalrecord;
          debugger
          this.attendanceList.forEach(element => {
            this.totalWithdrawAmount += element.withdrawAmount;
            this.totalOvertimeAmount += element.overtimeAmount;
            this.totalPayableAmount += element.payableAmount;
          });
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

  // Page Change Event
  pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.fetchAttendanceList();
  }

  // Sort Data Event
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchAttendanceList();
  }

  // Clear Search
  clearSearch() {
    this.searchKeyword = '';
    this.fetchAttendanceList();
  }

  // Apply Search
  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchAttendanceList();
    }
  }

  clearFilter() {
    const today = new Date();
    const year = today.getMonth() >= 3 ? today.getFullYear() : today.getFullYear() - 1;
    this.startDate = new Date(year, today.getMonth(), 1); // April 1st of the current financial year
    this.endDate = new Date(); // Today’s date
    this.siteIds = [];
    this.statusIds = [];
    this.fetchAttendanceList();
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
          this.activeSite = response.data;
          this.spinner.hide();
        } else {
          this.spinner.hide();
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
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
}
