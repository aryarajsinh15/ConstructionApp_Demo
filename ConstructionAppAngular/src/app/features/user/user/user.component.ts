import { Component, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { ActivatedRoute, Router } from '@angular/router';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { ToastrService } from 'ngx-toastr';
import { AddEditUserComponent } from '../add-edit-user/add-edit-user.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { LanguageService } from 'app/services/language/language.service';
import { TranslateService } from '@ngx-translate/core';
import { UntypedFormControl } from '@angular/forms';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'vex-user',
  templateUrl: './user.component.html',
  styleUrl: './user.component.scss'
})
export class UserComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['name', 'username', 'emailid', 'mobileno', 'isactive', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  userList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;
  clientId: any;
  statusIds: any = [];
  loginUserId: string;
  clientName: any;

  constructor(private route: ActivatedRoute,
    private spinner: NgxSpinnerService,
    private commonService: CommonService,
    private router: Router,
    private toastr: ToastrService,
    private apiUrl: ApiUrlHelper,
    private dialog: MatDialog,
    private translate: TranslateService,
    private languageService: LanguageService) {

  }

  ngOnInit(): void {
    // this.clientId = this.route.snapshot.paramMap.get('clientid');

    const encodedClientObj = this.route.snapshot.paramMap.get('clientid');
    if (encodedClientObj) {
      const clientObjJsonString = decodeURIComponent(escape(atob(encodedClientObj)));
      const parsedSiteObj = JSON.parse(clientObjJsonString);
      this.clientId = parsedSiteObj.clientId;
      const encodedClientName = parsedSiteObj.clientName;
      this.clientName = decodeURIComponent(encodedClientName);
    }

    if (!this.clientId || this.clientId == null || this.clientId == undefined) {
      this.clientId = null;
    }
    this.fetchUserList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    this.loginUserId = localStorage.getItem('userId');
  }

  backToClient() {
    this.router.navigate(['/client']);
  }

  fetchUserList() {
    this.showData = false;
    this.spinner.show();

    let api = this.apiUrl.apiUrl.User.GetUserlist;
    let UserModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
      ClientId: this.clientId,
    };
    this.commonService.doPost(api, UserModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.userList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.userList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.userList.length != 0) {
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
    this.fetchUserList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchUserList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchUserList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchUserList();
    }
  }

  clearFilter() {
    this.statusIds = [];
    this.fetchUserList();
  }

  addEditUser(userId: any, clientId: any) {
    const dialogRef = this.dialog.open(AddEditUserComponent, {
      width: '800px',
      data: { UserId: userId, ClientId: clientId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchUserList();
    });
  }

  deleteUser(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.User.DeleteUser.replace('{userId}', DeleteId);
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
              this.fetchUserList();
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

  activeInactiveUser(UserId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.User.ActiveInActiveUser.replace('{userId}', UserId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchUserList();
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