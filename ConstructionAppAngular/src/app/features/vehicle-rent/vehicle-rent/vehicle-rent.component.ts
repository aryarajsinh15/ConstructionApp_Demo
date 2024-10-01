import { Component, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { AddEditVehicleRentComponent } from '../add-edit-vehicle-rent/add-edit-vehicle-rent.component';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { UntypedFormControl } from '@angular/forms';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import * as saveAs from 'file-saver';
import { CurrencyFormat } from 'app/services/custom-pipe/currency-format.pipe';

@Component({
  selector: 'vex-vehicle-rent',
  templateUrl: './vehicle-rent.component.html',
  styleUrl: './vehicle-rent.component.scss'
})
export class VehicleRentComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['vehiclerentdate', 'vehicleOwnerName', 'FromLocation', 'ToLocation', 'VehicleNumber', 'Amount', 'isActive', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  siteList: any = [];
  VehicleRent: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  startDate: Date;
  endDate: Date;
  vehilceOwner: any[] = [];
  selectedIds: any = [];

  constructor(private toastr: ToastrService,
    private commonService: CommonService,
    private spinner: NgxSpinnerService,
    private apiUrl: ApiUrlHelper,
    private dialog: MatDialog,
    private currencyFormat : CurrencyFormat,
    private translate: TranslateService,
    private languageService: LanguageService) {
    this.startDate = commonService.getFinancialYearStartDate();
    this.endDate = commonService.getCurrentDateWithOffset(new Date());
  }

  ngOnInit(): void {
    this.fetchVehicleRentList();
    this.getVehicleOwnerDetails();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  fetchVehicleRentList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.VehicleRent.GetVehicleRentList;
    let SiteModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      startDate: this.startDate,
      enddate: this.endDate,
      vehicleOwnerId: this.selectedIds.join(',') == '' ? null : this.selectedIds.join(','),
    };
    this.commonService.doPost(api, SiteModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.VehicleRent = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.VehicleRent.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.VehicleRent.length != 0) {
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
    this.fetchVehicleRentList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchVehicleRentList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchVehicleRentList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchVehicleRentList();
    }
  }

  clearFilter() {
    this.startDate = this.commonService.getFinancialYearStartDate();
    this.endDate = this.commonService.getCurrentDateWithOffset(new Date());
    this.selectedIds = [];
    this.fetchVehicleRentList();
  }

  addEditVehicleRent(vehicleRentId: any) {
    const dialogRef = this.dialog.open(AddEditVehicleRentComponent, {
      width: '800px',
      data: { vehicleRentId: vehicleRentId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchVehicleRentList();
    });
  }

  deleteVehicleRent(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.VehicleRent.DeleteVehicleRent.replace('{vehicleRentId}', DeleteId);
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
              this.fetchVehicleRentList();
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

  ActiveInActiveVehicleRent(VehicleRentId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.VehicleRent.ActiveInActiveVehicleRent.replace('{vehicleRentId}', VehicleRentId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchVehicleRentList();
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

  getVehicleOwnerDetails() {
    const apiUrl = this.apiUrl.apiUrl.VehicleRent.VehicleOwnerlist;
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.vehilceOwner = response.data;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  exportVehicleRentListPDF() {
    this.spinner.show();
    const objData = {
      VehicleOwnerId: this.selectedIds.join(',') == '' ? null : this.selectedIds.join(',')
    }
    const apiUrl = this.apiUrl.apiUrl.VehicleRent.ExportPDFVehicleRent
    this.commonService.DownloadPDFFilePost(apiUrl,objData).pipe().subscribe(
      (buffer: Blob) => {
        if (buffer && buffer.size > 0) {
          const blob = new Blob([buffer], { type: 'application/pdf' });
          const blobUrl = URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = blobUrl;
          a.download = 'Vehicle-Rent-List.pdf';
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

  exportVehicleRentListExcel() {
    this.spinner.show();
    const objData = {
      VehicleOwnerId: this.selectedIds.join(',') == '' ? null : this.selectedIds.join(',')
    }
    const apiUrl = this.apiUrl.apiUrl.VehicleRent.ExportExcelVehicleRent;
    this.commonService.DownloadCSVFile(apiUrl,objData).pipe().subscribe(
      (buffer) => {
        if (buffer.size != 0) {
          const data: Blob = new Blob([buffer], {
            type: "text/csv;charset=utf-8"
          });
          saveAs(data, 'Vehicle-Rent-List.xlsx');
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