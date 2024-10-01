import { Component, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { LanguageService } from 'app/services/language/language.service';
import { CommonService } from 'app/services/common/common.service';
import { AddEditPersonComponent } from '../add-edit-person/add-edit-person.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { ToastrService } from 'ngx-toastr';
import { UntypedFormControl } from '@angular/forms';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { NgxSpinnerService } from 'ngx-spinner';
@Component({
  selector: 'vex-persons-list',
  templateUrl: './persons-list.component.html',
  styleUrl: './persons-list.component.scss'
})
export class PersonsListComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['PersonFirstName', 'billamount', 'creditamount', 'remainingamount', 'MobileNo', 'IsActive', 'personPayment', 'Actions'];
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
  startDate: any = null;
  endDate: any = null;
  statusIds = ['1'];

  constructor(private spinner: NgxSpinnerService, private commonService: CommonService, private router: Router, private toastr: ToastrService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private route: Router, private translate: TranslateService, private languageService: LanguageService) {
    this.startDate = this.commonService.getFinancialYearStartDate(); // April 1st of the current financial year
    this.endDate = this.commonService.getCurrentDateWithOffset(new Date()); // Today’s date
  }

  ngOnInit(): void {
    this.getPersonList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  clearFilter() {
    this.startDate = this.commonService.getFinancialYearStartDate(); // April 1st of the current financial year
    this.endDate = this.commonService.getCurrentDateWithOffset(new Date()); // Today’s date
    this.statusIds = ['1'];
    this.getPersonList();
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
    let api = this.apiUrl.apiUrl.Persons.GetPerosnList;
    let obj = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      startDate: this.startDate ? this.formatDate(this.startDate, "12:00 AM") : null,
      endDate: this.endDate ? this.formatDate(this.endDate, "12:00 AM") : null,
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
    const dialogRef = this.dialog.open(AddEditPersonComponent, {
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

  personPaymentList(personid: any) {
    var obj = {
      personId: personid
    }
    var encryptedObj = btoa(JSON.stringify(obj))
    this.router.navigate(['person-payment', encryptedObj]);
  }

  personPaymentDebitList(personid: any) {
    var obj = {
      personId: personid
    }
    var encryptedObj = btoa(JSON.stringify(obj))
    this.router.navigate(['person-bill-payment', encryptedObj]);
  }
}