import { Component, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { AddEditVehicleOwnerComponent } from '../add-edit-vehicle-owner/add-edit-vehicle-owner.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { ToastrService } from 'ngx-toastr';
import { UntypedFormControl } from '@angular/forms';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'vex-vehicle-owner',
  templateUrl: './vehicle-owner.component.html',
  styleUrl: './vehicle-owner.component.scss'
})
export class VehicleOwnerComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['vehicleownername', 'mobileno', 'remarks', 'isactive', 'actions'];
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

  constructor(private commonService: CommonService,private spinner: NgxSpinnerService,  private toastr: ToastrService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private translate: TranslateService, private languageService: LanguageService) {
  }

  ngOnInit(): void {
    this.fetchVehicleOwnerList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  fetchVehicleOwnerList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.VehicleOwner.GetVehicleOwnerList;
    let VehicleOwnerModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
    };
    this.commonService.doPost(api, VehicleOwnerModel).pipe().subscribe({
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
    this.fetchVehicleOwnerList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchVehicleOwnerList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchVehicleOwnerList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchVehicleOwnerList();
    }
  }

  addEditVehicleOwner(vehicleOwnerId: any) {
    const dialogRef = this.dialog.open(AddEditVehicleOwnerComponent, {
      width: '800px',
      data: { VehicleOwnerId: vehicleOwnerId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchVehicleOwnerList();
    });
  }

  deleteVehicleOwner(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.VehicleOwner.DeleteVehicleOwner.replace('{vehicleOwnerId}', DeleteId);
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
              this.fetchVehicleOwnerList();
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

  activeInactiveVehicleOwner(VehicleOwnerId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.VehicleOwner.ActiveInActiveVehicleOwner.replace('{vehicleOwnerId}', VehicleOwnerId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchVehicleOwnerList();
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