import { Component, ViewChild } from '@angular/core';
import { UntypedFormControl } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { AddEditEstimateComponent } from '../add-edit-estimate/add-edit-estimate.component';
import { TranslateService } from '@ngx-translate/core';
import { Router } from '@angular/router';
import { saveAs } from 'file-saver'

@Component({
  selector: 'vex-estimate',
  templateUrl: './estimate.component.html',
  styleUrl: './estimate.component.scss'
})
export class EstimateComponent {
  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['estimateDate', 'partyName', 'totalAmount', 'isActive', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  siteList: any = [];
  Estimate: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  startDate: Date;
  endDate: Date;
  hasItems: boolean;

  constructor(private toastr: ToastrService,
    private commonService: CommonService,
    private router: Router,
    private spinner: NgxSpinnerService,
    private apiUrl: ApiUrlHelper,
    private dialog: MatDialog,
    private translate: TranslateService,
    private languageService: LanguageService) {
    this.startDate = commonService.getFinancialYearStartDate();
    this.endDate = commonService.getCurrentDateWithOffset(new Date());
  }

  ngOnInit(): void {
    this.fetchEstimateList();
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

  fetchEstimateList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.Estimate.GetEstimateList;
    let EstimateModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      startDate: this.startDate,
      endDate: this.commonService.getCurrentDateWithOffset(this.endDate)
    };
    this.commonService.doPost(api, EstimateModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.Estimate = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.Estimate.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.Estimate.length != 0) {
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

  // Page Change Event happen
  pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.fetchEstimateList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchEstimateList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchEstimateList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchEstimateList();
    }
  }

  clearFilter() {
    this.startDate = this.commonService.getFinancialYearStartDate();
    this.endDate = this.commonService.getCurrentDateWithOffset(new Date());
    this.fetchEstimateList();
  }

  addEditEstimate(estimateId: any, hasItems: boolean) {
    if (hasItems) {
      var encryptedObj = btoa(JSON.stringify(estimateId))
      this.router.navigate(['estimate-bill-payment', encryptedObj]);
    }
    else {
      const dialogRef = this.dialog.open(AddEditEstimateComponent, {
        width: '800px',
        data: { estimateId: estimateId },
        disableClose: true,
        autoFocus: false
      });
      dialogRef.afterClosed().subscribe((result) => {
        this.fetchEstimateList();
      });
    }
  }

  EstimateBillPayment() {
    this.router.navigate(['estimate-bill-payment']);
  }

  deleteEstimate(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.Estimate.DeleteEstimate.replace('{estimateId}', DeleteId);
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
              this.fetchEstimateList();
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

  ActiveInActiveEstimate(EstimateId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.Estimate.ActiveInActiveEstimate.replace('{estimateId}', EstimateId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchEstimateList();
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