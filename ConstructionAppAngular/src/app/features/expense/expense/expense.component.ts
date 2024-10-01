import { Component, Input, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { AddEditExpenseComponent } from '../add-edit-expense/add-edit-expense.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { TranslateService } from '@ngx-translate/core';
import { LanguageService } from 'app/services/language/language.service';
import { saveAs } from 'file-saver'
import { ToastrService } from 'ngx-toastr';
import { UntypedFormControl } from '@angular/forms';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'vex-expense',
  templateUrl: './expense.component.html',
  styleUrl: './expense.component.scss'
})
export class ExpenseComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['expensedate', 'expensetype', 'amount', 'description', 'sitename', 'isactive', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  expenseList: any = [];
  isSiteType: boolean = false;
  startDate: Date;
  endDate: Date;
  expenseTypeIds: any = [];
  siteIds: any = [];
  statusIds = ['1'];
  allSiteIds: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;

  constructor(private commonService: CommonService, private spinner: NgxSpinnerService, private toastr: ToastrService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private translate: TranslateService, private languageService: LanguageService) {
    this.startDate = commonService.getFinancialYearStartDate();
    this.endDate = commonService.getCurrentDateWithOffset(new Date());
  }

  ngOnInit(): void {
    this.getActiveSiteDetails();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  expenseTypeChange(event: any) {
    this.isSiteType = event.value.includes('1');
  }

  getActiveSiteDetails() {
    const apiUrl = this.apiUrl.apiUrl.Site.GetActiveSiteList;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.allSiteIds = response.data;
        this.fetchExpenseList();
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  saveFile = async (file) => {
    try {
      saveAs(file);
    } catch (error) {
      console.error(error);
    }
  };

  fetchExpenseList() {
    this.showData = false;
    this.spinner.show();
    let siteIdArray = [];
    for (let i = 0; i < this.allSiteIds.length; i++) {
      siteIdArray.push(this.allSiteIds[i].siteId);
    }
    let api = this.apiUrl.apiUrl.Expense.GetExpenseList;
    let ExpenseModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      siteIds: this.siteIds.length > 0 ? this.siteIds.join(',') : '',
      expenseTypeIds: this.expenseTypeIds.length > 0 ? this.expenseTypeIds.join(',') : '1,2,3',
      startDate: this.startDate,
      endDate: this.commonService.getCurrentDateWithOffset(this.endDate),
      activeInActiveStatus: this.statusIds.length > 0 ? this.statusIds.join(',') : '0,1'
    };
    this.commonService.doPost(api, ExpenseModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.expenseList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.expenseList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.expenseList.length != 0) {
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
    this.fetchExpenseList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchExpenseList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchExpenseList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchExpenseList();
    }
  }

  clearFilter() {
    this.siteIds = [];
    this.expenseTypeIds = [];
    this.statusIds = ['1'];
    this.startDate = this.commonService.getFinancialYearStartDate();
    this.endDate = this.commonService.getCurrentDateWithOffset(new Date());
    this.fetchExpenseList();
  }

  addEditExpense(expenseId: any) {
    const dialogRef = this.dialog.open(AddEditExpenseComponent, {
      width: '800px',
      data: { ExpenseId: expenseId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchExpenseList();
    });
  }

  deleteExpense(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.Expense.DeleteExpense.replace('{expenseId}', DeleteId);
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
              this.fetchExpenseList();
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

  activeInactiveExpense(ExpenseId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.Expense.ActiveInActiveExpense.replace('{expenseId}', ExpenseId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchExpenseList();
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

  exportExpenseListPDF() {
    this.spinner.show();
    const objData = {
      ExpenseTypeId :  this.expenseTypeIds.length > 0 ? this.expenseTypeIds.join(',') : '1,2,3',
      SiteId : this.siteIds.length > 0 ? this.siteIds.join(',') : '',
      StatusId : this.statusIds.length > 0 ? this.statusIds.join(',') : '0,1'
    }
    const apiUrl = this.apiUrl.apiUrl.Expense.ExportPDFExpense
    this.commonService.DownloadPDFFilePost(apiUrl,objData).pipe().subscribe(
      (buffer: Blob) => {
        if (buffer && buffer.size > 0) {
          const blob = new Blob([buffer], { type: 'application/pdf' });
          const blobUrl = URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = blobUrl;
          a.download = 'Expense-List.pdf';
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

  exportExpenseListExcel() {
    this.spinner.show();
    const objData = {
      ExpenseTypeId :  this.expenseTypeIds.length > 0 ? this.expenseTypeIds.join(',') : '1,2,3',
      SiteId : this.siteIds.length > 0 ? this.siteIds.join(',') : '',
      StatusId : this.statusIds.length > 0 ? this.statusIds.join(',') : '0,1'
    }
    const apiUrl = this.apiUrl.apiUrl.Expense.ExportExcelExpense;
    this.commonService.DownloadCSVFile(apiUrl,objData).pipe().subscribe(
      (buffer) => {
        if (buffer.size != 0) {
          const data: Blob = new Blob([buffer], {
            type: "text/csv;charset=utf-8"
          });
          saveAs(data, 'Expense-List.xlsx');
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