import { Component, ViewChild } from '@angular/core';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { AddEditChallanComponent } from '../add-edit-challan/add-edit-challan.component';
import { MatSort } from '@angular/material/sort';
import { MatPaginator } from '@angular/material/paginator';
import { CommonService } from 'app/services/common/common.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { LanguageService } from 'app/services/language/language.service';
import { TranslateService } from '@ngx-translate/core';
import { MatDialog } from '@angular/material/dialog';
import { saveAs } from 'file-saver'
import { UntypedFormControl } from '@angular/forms';

@Component({
  selector: 'vex-challan',
  templateUrl: './challan.component.html',
  styleUrl: './challan.component.scss'
})
export class ChallanComponent {
  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['challanDate', 'challanNo', 'siteName', 'merchantName', 'carno', 'isactive', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  challanList: any = [];
  merchantList: any[] = [];
  activeSite: any[] = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  startDate: any = null;
  endDate: any = null;
  selectedSiteIds: any = [];
  selectedMerchantIds: any = [];

  constructor(private commonService: CommonService,
    private spinner: NgxSpinnerService,
    private toastr: ToastrService,
    private apiUrl: ApiUrlHelper,
    private dialog: MatDialog,
    private translate: TranslateService,
    private languageService: LanguageService) {
    const today = new Date();
    const year = today.getMonth() >= 3 ? today.getFullYear() : today.getFullYear() - 1;
    this.startDate = new Date(year, 3, 1); // April 1st of the current financial year
    this.endDate = new Date(); // Today’s date
  }

  ngOnInit(): void {
    this.getMerchantList();
    this.getActiveSiteDetails();
    this.fetchChallanList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  saveFile = async (file) => {
    try {
      saveAs(file);
    } catch (error) {
      console.error(error);
    }
  };

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

  fetchChallanList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.Challan.GetChallanlist;
    let ChallanModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      siteId: this.selectedSiteIds.join(','),
      merchantId: this.selectedMerchantIds.join(','),
      startDate: this.startDate ? this.formatDate(this.startDate, "12:00 AM") : null,
      endDate: this.endDate ? this.formatDate(this.endDate, "12:00 AM") : null
    };
    this.commonService.doPost(api, ChallanModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.challanList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.challanList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.challanList.length != 0) {
            this.showData = false;
          }
          this.paginator.pageIndex = this.currentPage;
          this.paginator.length = this.totalrecord;
        } else {
          this.totalrecord = 0;
          this.spinner.hide();
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  clearFilter() {
    const today = new Date();
    const year = today.getMonth() >= 3 ? today.getFullYear() : today.getFullYear() - 1;
    this.startDate = new Date(year, 3, 1); // April 1st of the current financial year
    this.endDate = new Date(); // Today’s date
    this.selectedSiteIds = [];
    this.selectedMerchantIds = [];
    this.fetchChallanList();
  }

  // Page Change Event happen
  pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.fetchChallanList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchChallanList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchChallanList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchChallanList();
    }
  }

  addEditChallan(challanId: any) {
    const dialogRef = this.dialog.open(AddEditChallanComponent, {
      width: '800px',
      data: { challanId: challanId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchChallanList();
    });
  }

  deleteChallan(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.Challan.DeleteChallan.replace('{challanId}', DeleteId);
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
              this.fetchChallanList();
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

  activeInactiveChallan(ChallanId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.Challan.ActiveInActivechallan.replace('{challanId}', ChallanId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchChallanList();
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

  getMerchantList() {
    const apiUrl = this.apiUrl.apiUrl.Challan.MerchantList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.merchantList = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  getActiveSiteDetails() {
    const apiUrl = this.apiUrl.apiUrl.Site.GetActiveSiteList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.activeSite = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }
}


