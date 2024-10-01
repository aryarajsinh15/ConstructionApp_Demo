import { Component, ViewChild } from "@angular/core";
import { MatDialog } from "@angular/material/dialog";
import { MatPaginator } from "@angular/material/paginator";
import { MatSort } from "@angular/material/sort";
import { ApiUrlHelper } from "app/api-url/api-url-helper";
import { CommonService } from "app/services/common/common.service";
import { AddEditSiteModalComponent } from "../add-edit-site-modal/add-edit-site-modal.component";
import { DeleteConfirmationDialogComponentComponent } from "app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component";
import { ActiveInactiveDialogComponentComponent } from "app/component/active-inactive-dialog-component/active-inactive-dialog-component.component";
import { TranslateService } from "@ngx-translate/core";
import { LanguageService } from "app/services/language/language.service";
import { NgxSpinnerService } from "ngx-spinner";
import { ToastrService } from "ngx-toastr";
import { UntypedFormControl } from "@angular/forms";
import { Router } from "@angular/router";

@Component({
  selector: "vex-dashboard",
  templateUrl: "./site.component.html",
  styleUrls: ["./site.component.scss"],
})

export class SiteComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['sitename', 'billamount', 'creditamount', 'remainingamount', 'isactive', 'sitepayment', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  siteList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  startDate: any = null;
  endDate: any = null;
  statusIds: any = ['1'];

  constructor(private commonService: CommonService, private toastr: ToastrService, private spinner: NgxSpinnerService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private translate: TranslateService, private languageService: LanguageService, private router: Router) {
    this.startDate = this.commonService.getFinancialYearStartDate(); // April 1st of the current financial year
    this.endDate = this.commonService.getCurrentDateWithOffset(new Date()); // Today’s date
  }

  ngOnInit(): void {
    this.fetchSiteList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  clearFilter() {
    this.startDate = this.commonService.getFinancialYearStartDate(); // April 1st of the current financial year
    this.endDate = this.commonService.getCurrentDateWithOffset(new Date()); // Today’s date
    this.statusIds = ['1'];
    this.fetchSiteList();
  }

  sitePaymentList(siteId: any, siteName: any) {
    // var obj = {
    //   siteId: siteId,
    //   siteName: siteName
    // };
    // Encode the siteName using encodeURIComponent to handle non-Latin characters
    var encodedSiteName = encodeURIComponent(siteName);
    var objWithEncodedName = {
      siteId: siteId,
      siteName: encodedSiteName
    };
    var encryptedObj = btoa(JSON.stringify(objWithEncodedName));
    this.router.navigate(['site-payment', encryptedObj]);
  }

  sitePaymentDebitList(siteId: any, siteName: any) {
    // var obj = {
    //   siteId: siteId,
    //   siteName: siteName
    // }
    var encodedSiteName = encodeURIComponent(siteName);
    var objWithEncodedName = {
      siteId: siteId,
      siteName: encodedSiteName
    };
    var encryptedObj = btoa(JSON.stringify(objWithEncodedName))
    this.router.navigate(['bill-payment', encryptedObj]);
  }

  goToPhotoGallery(siteId: any, siteName: any) {
    // var obj = {
    //   siteId: siteId,
    //   siteName: siteName
    // }
    var encodedSiteName = encodeURIComponent(siteName);
    var objWithEncodedName = {
      siteId: siteId,
      siteName: encodedSiteName
    };
    var encryptedObj = btoa(JSON.stringify(objWithEncodedName))
    this.router.navigate(['photo-gallery', encryptedObj]);
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

  fetchSiteList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.Site.GetSiteList;
    let SiteModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      startDate: this.startDate ? this.formatDate(this.startDate, "12:00 AM") : null,
      endDate: this.endDate ? this.formatDate(this.endDate, "12:00 AM") : null,
      activeInActiveStatus : this.statusIds.length > 0 ? this.statusIds.join(',') : '0,1'
    };
    this.commonService.doPost(api, SiteModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.siteList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.siteList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.siteList.length != 0) {
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
    this.fetchSiteList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchSiteList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchSiteList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchSiteList();
    }
  }

  addEditSite(siteId: any) {
    const dialogRef = this.dialog.open(AddEditSiteModalComponent, {
      width: '800px',
      data: { SiteId: siteId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchSiteList();
    });
  }

  deleteSite(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.Site.DeleteSite.replace('{siteId}', DeleteId);
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
              this.fetchSiteList();
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

  activeInactiveSite(SiteId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.Site.ActiveInActiveSite.replace('{siteId}', SiteId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchSiteList();
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
}