import { Component, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { AddEditMerchantComponent } from '../add-edit-merchant/add-edit-merchant.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { TranslateService } from '@ngx-translate/core';
import { LanguageService } from 'app/services/language/language.service';
import { ToastrService } from 'ngx-toastr';
import { UntypedFormControl } from '@angular/forms';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { NgxSpinnerService } from 'ngx-spinner';
import { Router } from '@angular/router';
@Component({
  selector: 'vex-merchant-list',
  templateUrl: './merchant-list.component.html',
  styleUrls: ['./merchant-list.component.scss']
})
export class MerchantListComponent {

  displayedColumns: string[] = ['MerchantName', 'FirmName', 'MobileNo', 'Address', 'MerchantPayment', 'IsActive', 'Actions'];
  layoutCtrl = new UntypedFormControl('boxed');
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  merchantList: any = [];
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
    private spinner: NgxSpinnerService,
    private translate: TranslateService,
    private languageService: LanguageService,
    private router: Router) { }

  ngOnInit(): void {
    this.getMerchantList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  getMerchantList() {
    this.showData = false;
    let api = this.apiUrl.apiUrl.Merchant.GetMerchantList;
    let obj = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
    };
    this.spinner.show();
    this.commonService.doPost(api, obj).pipe().subscribe({
      next: (response: any) => {
        this.spinner.hide();
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
      },
      error: (error) => {
        console.log(error);
      }
    });
  }

  // Page Change Event happen
  pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.getMerchantList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.getMerchantList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.getMerchantList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.getMerchantList();
    }
  }

  addEditMerchant(merchantid: any) {
    const dialogRef = this.dialog.open(AddEditMerchantComponent, {
      width: '800px',
      data: { MerchantId: merchantid },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.getMerchantList();
    });
  }

  deleteMerchant(action: any, id: any) {
    const apiUrl = this.apiUrl.apiUrl.Merchant.DeleteMerchant.replace('{id}', id);
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
            this.spinner.hide();
            if (response.success) {
              this.getMerchantList();
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
        this.spinner.show();
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            this.spinner.hide();
            if (response.success) {
              this.toastr.success(response.message);
            } else {
              this.toastr.error(response.message);
            }
            this.getMerchantList();
          },
          error: (err) => {
            console.log(err);
          }
        });
      }
    });
  }

  merchantPaymentList(merchantId: any, merchantName: any) {
    // var obj = {
    //   merchantId: merchantId,
    //   merchantName : merchantName
    // }
    var encodedMerchantName = encodeURIComponent(merchantName);
    var objWithEncodedName = {
      merchantId: merchantId,
      merchantName: encodedMerchantName
    };
    var encryptedObj = btoa(JSON.stringify(objWithEncodedName))
    this.router.navigate(['merchant-payment', encryptedObj]);
  }
}