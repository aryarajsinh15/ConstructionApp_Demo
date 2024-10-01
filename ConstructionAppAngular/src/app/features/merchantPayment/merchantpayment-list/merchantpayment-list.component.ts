import { Component, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { TranslateService } from '@ngx-translate/core';
import { LanguageService } from 'app/services/language/language.service';
import { ToastrService } from 'ngx-toastr';
import { UntypedFormControl } from '@angular/forms';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { AddEditMerchantpaymentComponent } from '../add-edit-merchantpayment/add-edit-merchantpayment.component';
import { ActivatedRoute, Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'vex-merchantpayment-list',
  templateUrl: './merchantpayment-list.component.html',
  styleUrl: './merchantpayment-list.component.scss'
})
export class MerchantpaymentListComponent {

  displayedColumns: string[] = ['PaymentDate', 'MerchantName', 'SiteName', 'Amount', 'PaymentType', 'ChequeNo'
    , 'BankName', 'ChequeFor', 'Action'];
  layoutCtrl = new UntypedFormControl('boxed');
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  merchantList: any = [];
  merchantId: any;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  IsFromList: any;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  merchantName: any;
  merchantDropDownList: any = [];
  paymentIds: any = [];
  merchantIds: any = [];
  paymentType = [
    {
      paymentId: "Cash",
      PaymentName: "Cash"
    },
    {
      paymentId: "Cheque",
      PaymentName: "Cheque"
    },
    {
      paymentId: "UPI",
      PaymentName: "UPI"
    },
    {
      paymentId: "RTGS",
      PaymentName: "RTGS"
    },
    {
      paymentId: "NEFT",
      PaymentName: "NEFT"
    },
  ];
  submerchantId: any;

  constructor(private commonService: CommonService,
    private toastr: ToastrService,
    private apiUrl: ApiUrlHelper,
    private spinner: NgxSpinnerService,
    private dialog: MatDialog,
    private translate: TranslateService,
    private languageService: LanguageService,
    private route: ActivatedRoute,
    private router: Router) {
    this.IsFromList = this.route.snapshot.paramMap.has('merchantid') ? true : false;
    this.displayedColumns = this.route.snapshot.paramMap.has('merchantid') ? ['PaymentDate', 'SiteName', 'Amount', 'PaymentType', 'ChequeNo'
      , 'BankName', 'ChequeFor', 'Action'] : ['PaymentDate', 'MerchantName', 'SiteName', 'Amount', 'PaymentType', 'ChequeNo'
      , 'BankName', 'ChequeFor', 'Action'];
  }

  ngOnInit(): void {
    this.getMerchantListForDropDown();
    // let merchantObj: any = atob((this.route.snapshot.paramMap.get('merchantid')));
    // if (this.route.snapshot.paramMap.has('merchantid')) {
    //   merchantObj = JSON.parse(merchantObj)
    //   this.merchantId = merchantObj.merchantId;
    //   this.merchantName = merchantObj.merchantName;
    // }
    const encodedMerchantObj = this.route.snapshot.paramMap.get('merchantid');
    if (this.route.snapshot.paramMap.has('merchantid')) {
      const merchantObjJsonString = atob(encodedMerchantObj);
      const parsedMerchantObj = JSON.parse(merchantObjJsonString);
      this.merchantId = parsedMerchantObj.merchantId;
      this.merchantIds.push(parsedMerchantObj.merchantId);
      const encodedMerchantName = parsedMerchantObj.merchantName;
      this.merchantName = decodeURIComponent(encodedMerchantName);
    }

    this.getMerchantPaymentList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  clearFilter() {
    this.paymentIds = [];
    this.merchantIds = [];
    this.getMerchantPaymentList();
  }

  getMerchantListForDropDown() {
    const apiUrl = this.apiUrl.apiUrl.Merchant.GetMerchantListForDropDown;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.merchantDropDownList = response.data;
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  getMerchantPaymentList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.MerchantPayment.GetMerchantPaymentList;
    let obj = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      startDate: null,
      endDate: null,
      siteId: "",
      paymentType: this.paymentIds.length > 0 ? this.paymentIds.join(',') : null,
      merchantId: this.merchantIds.join(',') ? this.merchantIds.join(',') : null
    };

    this.commonService.doPost(api, obj).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.merchantList = response.data;
          this.dataSource = response.data;
          if (this.merchantList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.merchantList.length != 0) {
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

  // Page Change Event happen
  pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.getMerchantPaymentList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.getMerchantPaymentList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.getMerchantPaymentList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.getMerchantPaymentList();
    }
  }

  backToMerchnat() {
    this.router.navigate(['/merchant']);
  }

  addEditMerchantPayment(paymentid: any, merchantId: any) {
    const dialogRef = this.dialog.open(AddEditMerchantpaymentComponent, {
      width: '800px',
      data: { merchantId: merchantId ? merchantId : this.merchantId, paymentId: paymentid, IsFromList: this.route.snapshot.paramMap.has('merchantid') ? true : false },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.getMerchantPaymentList();
    });
  }

  deleteMerchantPayment(action: any, id: any) {
    const apiUrl = this.apiUrl.apiUrl.MerchantPayment.DeleteMerchantPayment.replace('{id}', id);
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponentComponent, {
      width: '460px',
      data: { action },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.commonService.doDelete(apiUrl, id).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.getMerchantPaymentList();
              this.toastr.success(response.message);
            } else {
              this.toastr.error(response.message);
            }
          },
          error: (err) => {
            console.log(err);
          }
        });
      }
    });
  }

  activeInactiveMerchant(MerchantId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        const apiUrl = this.apiUrl.apiUrl.Merchant.ActiveInActiveMerchant.replace('{merchantId}', MerchantId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.toastr.success(response.message);
            } else {
              this.toastr.error(response.message);
            }
            this.getMerchantPaymentList();
          },
          error: (err) => {
            console.log(err);
          }
        });
      }
    });
  }
}
