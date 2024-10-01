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
import { AddEditSitePaymentComponent } from '../add-edit-site-payment/add-edit-site-payment.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { UntypedFormControl } from '@angular/forms';
import * as saveAs from 'file-saver';

@Component({
  selector: 'vex-site-payment',
  templateUrl: './site-payment.component.html',
  styleUrl: './site-payment.component.scss'
})
export class SitePaymentComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  siteObj: any
  parseSiteObj: any
  siteId: any;
  siteName:any;
  displayedColumns: string[] = ['selecteddate', 'amount', 'paymenttype', 'bankname', 'chequeno', 'chequefor', 'username', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  sitePaymentList: any = [];
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
    this.fetchSitePaymentList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  backToSite() {
    this.router.navigate(['/site']);
  }

  fetchSitePaymentList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.SitePayment.GetSitePaymentlist;
    let SitePaymentModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      siteId: this.siteId
    };
    this.commonService.doPost(api, SitePaymentModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.sitePaymentList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.sitePaymentList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.sitePaymentList.length != 0) {
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
    this.fetchSitePaymentList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchSitePaymentList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchSitePaymentList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchSitePaymentList();
    }
  }

  addEditSitePaymnet(contractorFinanceId: any) {
    const dialogRef = this.dialog.open(AddEditSitePaymentComponent, {
      width: '800px',
      data: { ContractorFinanceId: contractorFinanceId, SiteId: this.siteId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchSitePaymentList();
    });
  }

  deleteSitePayment(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.SitePayment.DeleteSitePayment.replace('{contractorFinanceId}', DeleteId);
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
              this.fetchSitePaymentList();
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

  exportSitePaymentListExcel() {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.SitePayment.ExportExcelSitePaymnet.replace('{siteId}', this.siteId);
    this.commonService.GetDownloadCSVFile(apiUrl).pipe().subscribe(
      (buffer) => {
        if (buffer.size != 0) {
          const data: Blob = new Blob([buffer], {
            type: "text/csv;charset=utf-8"
          });
          saveAs(data, `${this.siteName}-Site-Payment.xlsx`);
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

  exportSitePaymentListPDF() {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.SitePayment.ExportPDFSitePaymnet.replace('{siteId}', this.siteId);;
    this.commonService.DownloadPDFFile(apiUrl).pipe().subscribe(
      (buffer: Blob) => {
        if (buffer && buffer.size > 0) {
          const blob = new Blob([buffer], { type: 'application/pdf' });
          const blobUrl = URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = blobUrl;
          a.download = `${this.siteName}-Site-Payment.pdf`;
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