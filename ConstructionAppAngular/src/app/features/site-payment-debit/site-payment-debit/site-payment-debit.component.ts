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
import { AddEditSitePaymentDebitComponent } from '../add-edit-site-payment-debit/add-edit-site-payment-debit.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { UntypedFormControl } from '@angular/forms';
import * as saveAs from 'file-saver';

@Component({
  selector: 'vex-site-payment-debit',
  templateUrl: './site-payment-debit.component.html',
  styleUrl: './site-payment-debit.component.scss'
})
export class SitePaymentDebitComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  siteObj: any
  parseSiteObj: any
  siteId: any;
  siteName: any;
  dataSource: any = [];
  displayedColumns: string[] = ['billdate', 'billno', 'billtype', 'totalamount', 'actions'];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  sitePaymentDebitList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;

  constructor(private route: ActivatedRoute, private commonService: CommonService, private toastr: ToastrService, private spinner: NgxSpinnerService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private translate: TranslateService, private languageService: LanguageService, private router: Router) { }

  ngOnInit(): void {
    // this.siteObj = atob((this.route.snapshot.paramMap.get('siteid')));
    // this.parseSiteObj = JSON.parse(this.siteObj)
    // this.siteId = this.parseSiteObj.siteId;
    // this.siteName = this.parseSiteObj.siteName;
    const encodedSiteObj = this.route.snapshot.paramMap.get('siteid');
    const siteObjJsonString = atob(encodedSiteObj);
    const parsedSiteObj = JSON.parse(siteObjJsonString);
    this.siteId = parsedSiteObj.siteId;
    const encodedSiteName = parsedSiteObj.siteName;
    this.siteName = decodeURIComponent(encodedSiteName);
    
    this.fetchSitePaymentDebitList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  backToSite() {
    this.router.navigate(['/site']);
  }

  saveFile = async (file) => {
    try {
      saveAs(file);
    } catch (error) {
      console.error(error);
    }
  };

  fetchSitePaymentDebitList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.SitePaymentDebit.GetSitePaymentDebitlist;
    let SitePaymentDebitModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      siteId: this.siteId
    };
    this.commonService.doPost(api, SitePaymentDebitModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.sitePaymentDebitList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.sitePaymentDebitList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.sitePaymentDebitList.length != 0) {
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
    this.fetchSitePaymentDebitList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchSitePaymentDebitList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchSitePaymentDebitList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchSitePaymentDebitList();
    }
  }

  addEditSiteDebitPaymnet(billId: any, billType: any) {
    if (billType == "File") {
      const dialogRef = this.dialog.open(AddEditSitePaymentDebitComponent, {
        width: '800px',
        data: { BillId: billId, SiteId: this.siteId },
        disableClose: true,
        autoFocus: false
      });
      dialogRef.afterClosed().subscribe((result) => {
        this.fetchSitePaymentDebitList();
      });
    }
    else {
      var encodedSiteName = encodeURIComponent(this.siteName);
      var objWithEncodedName = {
        siteId: this.siteId,
        billId: billId,
        siteName: encodedSiteName
      };
      var encryptedObj = btoa(JSON.stringify(objWithEncodedName))
      this.router.navigate(['nofile-bill-payment', encryptedObj]);
    }
  }

  BillPaymentWithOutFile() {
    // var obj = {
    //   siteId: this.siteId,
    //   billId: null,
    //   siteName: this.siteName
    // }
    var encodedSiteName = encodeURIComponent(this.siteName);
    var objWithEncodedName = {
      siteId: this.siteId,
      billId: null,
      siteName: encodedSiteName
    };
    var encryptedObj = btoa(JSON.stringify(objWithEncodedName))
    this.router.navigate(['nofile-bill-payment', encryptedObj]);
  }

  deleteSiteDebitPayment(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.SitePaymentDebit.DeleteSitePaymentDebit.replace('{billId}', DeleteId);
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
              this.fetchSitePaymentDebitList();
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

  exportBillPaymentListExcel(billId: any, billNo: any) {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.SitePaymentDebit.ExportExcelBillPayment.replace('{billId}', billId);
    this.commonService.GetDownloadCSVFile(apiUrl).pipe().subscribe(
      (buffer) => {
        if (buffer.size != 0) {
          const data: Blob = new Blob([buffer], {
            type: "text/csv;charset=utf-8"
          });
          saveAs(data, `${billNo}-Bill-Payment.xlsx`);
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

  exportBillPaymentListPDF(billId: any, billNo: any) {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.SitePaymentDebit.ExportPDFBillPayment.replace('{billId}', billId);
    this.commonService.DownloadPDFFile(apiUrl).pipe().subscribe(
      (buffer: Blob) => {
        if (buffer && buffer.size > 0) {
          const blob = new Blob([buffer], { type: 'application/pdf' });
          const blobUrl = URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = blobUrl;
          a.download = `${billNo}-Bill-Payment.pdf`;
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