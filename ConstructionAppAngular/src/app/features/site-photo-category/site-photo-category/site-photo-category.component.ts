import { Component, ViewChild } from '@angular/core';
import { UntypedFormControl } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import { AddEditSitePhotoCategoryComponent } from '../add-edit-site-photo-category/add-edit-site-photo-category.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';

@Component({
  selector: 'vex-site-photo-category',
  templateUrl: './site-photo-category.component.html',
  styleUrl: './site-photo-category.component.scss'
})
export class SitePhotoCategoryComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['categoryname', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  sitecategoryList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;

  constructor(private commonService: CommonService, private toastr: ToastrService, private spinner: NgxSpinnerService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private translate: TranslateService, private languageService: LanguageService, private router: Router) { }

  ngOnInit(): void {
    this.fetchSiteCategoryList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  fetchSiteCategoryList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.SiteCategory.GetSiteCategoryList;
    let SiteModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
    };
    this.commonService.doPost(api, SiteModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.sitecategoryList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.sitecategoryList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.sitecategoryList.length != 0) {
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
    this.fetchSiteCategoryList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchSiteCategoryList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchSiteCategoryList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchSiteCategoryList();
    }
  }

  addEditImageCategory(sitePhotoCategoryId: any) {
    const dialogRef = this.dialog.open(AddEditSitePhotoCategoryComponent, {
      width: '800px',
      data: { SitePhotoCategoryId: sitePhotoCategoryId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchSiteCategoryList();
    });
  }

  deleteImageCategory(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.SiteCategory.DeleteSiteCategory.replace('{sitePhotoCategoryId}', DeleteId);
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
              this.fetchSiteCategoryList();
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
}