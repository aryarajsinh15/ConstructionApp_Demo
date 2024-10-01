import { Component,ViewChild,OnInit } from '@angular/core';
import { UntypedFormControl } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { LanguageService } from 'app/services/language/language.service';
import { ToastrService } from 'ngx-toastr';
import { ActivatedRoute, Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import {  NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'vex-person-attendance-list',
  templateUrl: './person-attendance-list.component.html',
  styleUrl: './person-attendance-list.component.scss'
})
export class PersonAttendanceListComponent implements OnInit {

  displayedColumns: string[] = ['AttendanceDate', 'TotalAmount', 'FullDay', 'HalfDay', 'Absent', 'Total', 'Action'];
  layoutCtrl = new UntypedFormControl('boxed');
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  personAttendanceList: any = [];
  attendanceId: any;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;

  constructor(private commonService: CommonService,  
    private toastr: ToastrService, 
    private apiUrl: ApiUrlHelper, 
    private dialog: MatDialog, 
    private translate: TranslateService, 
    private languageService: LanguageService,
    private route: ActivatedRoute,
    private datePipe: DatePipe,
    private router: Router,
    private spinner : NgxSpinnerService){
    
  }
  ngOnInit(): void {
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });  
    this.getPersonAttendanceList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.getPersonAttendanceList();
    }
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.getPersonAttendanceList();
  }

  // Page Change Event happen
  pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.getPersonAttendanceList();
  }

  getPersonAttendanceList() {
    this.showData = false;
    let api = this.apiUrl.apiUrl.PersonAttendance.GetPersonAttendance;
    let obj = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      activeInactiveStatus : '1'
    };
    this.spinner.show();
    this.commonService.doPost(api, obj).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.personAttendanceList = response.data;
          this.dataSource = response.data;
          if (this.personAttendanceList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.personAttendanceList.length != 0) {
            this.showData = false;
          }
          this.paginator.pageIndex = this.currentPage;
          this.paginator.length = this.totalrecord;
        } else {
          this.totalrecord = 0;
        }
        this.spinner.hide();
      },
      error: (error) => {
        this.spinner.hide();
        console.log(error);
      }
    });
  }

  addEditPersonAttendance(AttendanceId) {
    var obj = {
      attendanceId: AttendanceId
    }
    var encryptedObj = btoa(JSON.stringify(obj))
    this.router.navigate(["attendance/add-edit", encryptedObj]);
  }

  deletePersonAttendance(action, AttendanceId) {
    action = this.datePipe.transform(action, 'dd-MM-yyyy')
    const apiUrl = this.apiUrl.apiUrl.PersonAttendance.DeletePersonAttendance.replace('{attendanceId}', AttendanceId);
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponentComponent, {
      width: '460px',
      data: { action },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        this.commonService.doDelete(apiUrl, AttendanceId).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.getPersonAttendanceList();
              this.toastr.success(response.message);
            } else {
              this.toastr.error(response.message);
            }
            this.spinner.hide();
          },
          error: (err) => {
            this.spinner.hide();
            console.log(err);
          }
        });
      }
    });
  }
}