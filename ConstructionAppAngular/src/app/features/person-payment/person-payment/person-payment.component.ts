import { Component, ViewChild } from '@angular/core';
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
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { UntypedFormControl } from '@angular/forms';
import * as saveAs from 'file-saver';
import { AddEditPersonPaymentComponent } from '../add-edit-person-payment/add-edit-person-payment.component';


@Component({
  selector: 'vex-person-payment',
  templateUrl: './person-payment.component.html',
  styleUrl: './person-payment.component.scss'
})
export class PersonPaymentComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  personObj: any
  parsePersonObj: any
  personId: any;
  displayedColumns: string[] = ['selecteddate', 'amount', 'paymenttype', 'bankname', 'chequeno', 'chequefor','username', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  personPaymentList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;

  constructor(private route: ActivatedRoute, private commonService: CommonService, private toastr: ToastrService, private spinner: NgxSpinnerService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private translate: TranslateService, private languageService: LanguageService, private router: Router) { }

  ngOnInit(): void {
    this.personObj = atob((this.route.snapshot.paramMap.get('personid')));
    this.parsePersonObj = JSON.parse(this.personObj)
    this.personId = this.parsePersonObj.personId;
    this.fetchPersonPaymentList();
    
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  backToPerson() {
    this.router.navigate(['/person']);
  }

  fetchPersonPaymentList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.PersonPayment.GetPersonPaymentlist;
    let PersonPaymentModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      personId: this.personId
    };
    this.commonService.doPost(api, PersonPaymentModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.personPaymentList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.personPaymentList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.personPaymentList.length != 0) {
            this.showData = false;
          }
          this.paginator.pageIndex = this.currentPage;
          this.paginator.length = this.totalrecord;
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

  // Page Change Event happen
  pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.fetchPersonPaymentList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchPersonPaymentList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchPersonPaymentList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchPersonPaymentList();
    }
  }

  addEditPersonPaymnet(personFinanceId: any) {
    const dialogRef = this.dialog.open(AddEditPersonPaymentComponent, {
      width: '800px',
      data: { PersonFinanceId: personFinanceId, PersonId: this.personId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchPersonPaymentList();
    });
  }

  deletePersonPayment(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.PersonPayment.DeletePersonPayment.replace('{personFinanceId}', DeleteId);
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponentComponent, {
      width: '460px',
      data: { action },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        this.commonService.doDelete(apiUrl, DeleteId).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.fetchPersonPaymentList();
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

  exportPersonPaymentListExcel() {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.PersonPayment.ExportExcelPersonPaymnet.replace('{personfinanceId}', this.personId);
    this.commonService.GetDownloadCSVFile(apiUrl).pipe().subscribe(
      (buffer) => {
        if (buffer.size != 0) {
          const data: Blob = new Blob([buffer], {
            type: "text/csv;charset=utf-8"
          });
          saveAs(data, 'Person-Payment-List.xlsx');
          this.spinner.hide();
        } else {
          this.spinner.hide();
          this.toastr.error('File not found.');
        }
      },
      (error) => {
        this.spinner.hide();
        this.commonService.checkAuthorize(error);
      });
  }
}
