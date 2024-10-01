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
import { AddEditPaymentDebitComponent } from '../add-edit-payment-debit/add-edit-payment-debit.component';

@Component({
  selector: 'vex-person-payment-debit',
  templateUrl: './person-payment-debit.component.html',
  styleUrl: './person-payment-debit.component.scss'
})
export class PersonPaymentDebitComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  PersonObj: any
  parsePersonObj: any
  PersonId: any;
  dataSource: any = [];
  displayedColumns: string[] = ['billdate', 'billno', 'totalamount', 'actions'];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  PersonPaymentDebitList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;

  constructor(private route: ActivatedRoute, private commonService: CommonService, private toastr: ToastrService, private spinner: NgxSpinnerService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private translate: TranslateService, private languageService: LanguageService, private router: Router) { }

  ngOnInit(): void {
    this.PersonObj = atob((this.route.snapshot.paramMap.get('personid')));
    this.parsePersonObj = JSON.parse(this.PersonObj)
    this.PersonId = this.parsePersonObj.personId;
    this.fetchPersonPaymentDebitList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  backToPerson() {
    this.router.navigate(['/person']);
  }

  fetchPersonPaymentDebitList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.PersonPaymentDebit.GetPersonPaymentDebitlist;
    let PersonPaymentDebitModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      PersonId: this.PersonId
    };
    this.commonService.doPost(api, PersonPaymentDebitModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.PersonPaymentDebitList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.PersonPaymentDebitList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.PersonPaymentDebitList.length != 0) {
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
    this.fetchPersonPaymentDebitList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchPersonPaymentDebitList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchPersonPaymentDebitList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchPersonPaymentDebitList();
    }
  }

  addEditPersonDebitPaymnet(billId: any) {
    const dialogRef = this.dialog.open(AddEditPaymentDebitComponent, {
      width: '800px',
      data: { BillId: billId, PersonId: this.PersonId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchPersonPaymentDebitList();
    });
  }

  BillPaymentWithOutFile() {
    this.router.navigate(['nofile-bill-payment']);
  }

  deletePersonDebitPayment(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.PersonPaymentDebit.DeletePersonPaymentDebit.replace('{billId}', DeleteId);
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
              this.fetchPersonPaymentDebitList();
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

  exportBillPaymentListExcel() {
    const obj = {
      PersonId: this.PersonId
    }
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.PersonPaymentDebit.ExportExcelBillPayment;
    this.commonService.DownloadCSVFile(apiUrl, obj).pipe().subscribe(
      (buffer) => {
        if (buffer.size != 0) {
          const data: Blob = new Blob([buffer], {
            type: "text/csv;charset=utf-8"
          });
          saveAs(data, 'Bill-Payment.xlsx');
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

  exportBillPaymentListPDF() {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.PersonPaymentDebit.ExportPDFBillPayment;
    this.commonService.DownloadPDFFile(apiUrl).pipe().subscribe(
      (buffer: Blob) => {
        if (buffer && buffer.size > 0) {
          const blob = new Blob([buffer], { type: 'application/pdf' });
          const blobUrl = URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = blobUrl;
          a.download = `Bill-Payment.pdf`;
          a.click();
          URL.revokeObjectURL(blobUrl);
          this.spinner.hide();
        } else {
          this.spinner.hide();
          this.toastr.error('File not found.');
        }
      },
      (error) => {
        console.error('Error:', error);
        this.spinner.hide();
      }
    );
  }
}