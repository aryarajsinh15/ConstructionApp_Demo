import { Component, ViewChild } from '@angular/core';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { AddEditPersonAttedanceComponent } from '../add-edit-person-attedance/add-edit-person-attedance.component';
import { CommonService } from 'app/services/common/common.service';
import { UntypedFormControl } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-person-attedance',
  templateUrl: './person-attedance.component.html',
  styleUrl: './person-attedance.component.scss'
})
export class PersonAttedanceComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['PersonFirstName', 'PersonAddress', 'MobileNo', 'DailyRate', 'PersonType', 'IsActive',"Attendance", 'Actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  personList: any = [];
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  statusIds = ['1'];

  constructor(private spinner: NgxSpinnerService, private commonService: CommonService, private router: Router, private toastr: ToastrService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private route: Router, private translate: TranslateService, private languageService: LanguageService) { }

  ngOnInit(): void {
    this.getPersonList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  clearFilter() {
    this.statusIds = ['1'];
    this.getPersonList();
  }

  // Page Change Event happen
  pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.getPersonList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.getPersonList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.getPersonList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.getPersonList();
    }
  }

  getPersonList() {
    this.showData = false;
    let api = this.apiUrl.apiUrl.Persons.GetPerosnAttedanceList;
    let obj = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      activeInActiveStatus: this.statusIds.length > 0 ? this.statusIds.join(',') : '0,1'
    };
    this.spinner.show();
    this.commonService.doPost(api, obj).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.personList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.personList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.personList.length != 0) {
            this.showData = false;
          }
          this.paginator.pageIndex = this.currentPage;
          this.paginator.length = this.totalrecord;
        } else {
          this.totalrecord = 0;
          this.spinner.hide();
        }
      },
      error: (error) => {
        this.spinner.hide();
        console.log(error);
      }
    });
  }

  addEditPerson(personid: any) {
    const dialogRef = this.dialog.open(AddEditPersonAttedanceComponent, {
      width: '800px',
      data: { Personid: personid },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.getPersonList();
    });
  }

  deletePerson(action: any, id: any) {
    const apiUrl = this.apiUrl.apiUrl.Persons.DeletePerson.replace('{id}', id);
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponentComponent, {
      width: '460px',
      data: { action },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        this.commonService.doDelete(apiUrl, id).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.getPersonList();
              this.spinner.hide();
              this.toastr.success(response.message);
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
    });
  }

  activeInactiveSite(PersonId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.Persons.ActiveInActivePerson.replace('{personId}', PersonId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.getPersonList();
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
    });
  }

  personAttendanceList(personId: any, name : any) {
    // var obj = {
    //   merchantId: merchantId,
    //   merchantName : merchantName
    // }
    var encodedName = encodeURIComponent(name);
    var objWithEncodedName = {
      personId: personId,
      personName: encodedName
    };
    var encryptedObj = btoa(JSON.stringify(objWithEncodedName))
    this.router.navigate(['attendance-by-person', encryptedObj]);
  }
}
