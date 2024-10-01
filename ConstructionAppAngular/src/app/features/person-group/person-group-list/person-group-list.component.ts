import { Component, ViewChild } from '@angular/core';
import { UntypedFormControl } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import { AddEditPersonGroupComponent } from '../add-edit-person-group/add-edit-person-group.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { CommonService } from 'app/services/common/common.service';

@Component({
  selector: 'vex-person-group-list',
  templateUrl: './person-group-list.component.html',
  styleUrl: './person-group-list.component.scss'
})
export class PersonGroupListComponent {

  // Fields
  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['groupname', 'personcount', 'isactive', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  groupList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;

  //Constructor
  constructor(private commonService: CommonService, 
    private toastr: ToastrService, 
    private spinner: NgxSpinnerService, 
    private apiUrl: ApiUrlHelper, 
    private dialog: MatDialog, 
    private translate: TranslateService, 
    private languageService: LanguageService, 
    private router: Router) {
  }

  // Init
  ngOnInit(): void {
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    this.fetchPersonGroupList();
  }

  // Get Group List
  fetchPersonGroupList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.PersonGroup.GetPersonGroupList;
    let paginationModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
    };
    this.commonService.doPost(api, paginationModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.groupList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.groupList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.groupList.length != 0) {
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

  // Page Change Event
   pageChanged(event: any) {
    this.pageSize = event.pageSize;
    this.currentPage = event.pageIndex;
    this.fetchPersonGroupList();
  }

  // Sort Data Event
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchPersonGroupList();
  }

  // Clear Search
  clearSearch() {
    this.searchKeyword = '';
    this.fetchPersonGroupList();
  }

  // Apply Search
  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchPersonGroupList();
    }
  }

  // Add Edit Group Form
  addEditGroup(groupId: any, name : any) {
    const dialogRef = this.dialog.open(AddEditPersonGroupComponent, {
      width: '800px',
      data: { groupId: groupId, name : name },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchPersonGroupList();
    });
  }

  // Delete Group
  deleteGroup(action: any, groupId: any) {
    const apiUrl = this.apiUrl.apiUrl.PersonGroup.DeletePersonGroup.replace('{groupId}', groupId);
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponentComponent, {
      width: '460px',
      data: { action },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        this.commonService.doDelete(apiUrl, groupId).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.fetchPersonGroupList();
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

  // Active/InActive Group
  activeInactiveGroup(groupId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.PersonGroup.ActiveInActiveGroup.replace('{groupId}', groupId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchPersonGroupList();
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
