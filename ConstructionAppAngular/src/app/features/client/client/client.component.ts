import { Component, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { AddEditClientComponent } from '../add-edit-client/add-edit-client.component';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';
import { ActiveInactiveDialogComponentComponent } from 'app/component/active-inactive-dialog-component/active-inactive-dialog-component.component';
import { ToastrService } from 'ngx-toastr';
import { Router } from '@angular/router';
import { LanguageService } from 'app/services/language/language.service';
import { TranslateService } from '@ngx-translate/core';
import { UntypedFormControl } from '@angular/forms';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'vex-client',
  templateUrl: './client.component.html',
  styleUrl: './client.component.scss'
})
export class ClientComponent {

  layoutCtrl = new UntypedFormControl('boxed');
  displayedColumns: string[] = ['clientname', 'firmname', 'packagetype', 'expiredate', 'address', 'user', 'isactive', 'actions'];
  dataSource: any = [];
  page = 1;
  searchKeyword = '';
  sortColumn: string = '';
  sortOrder: string = '';
  clientList: any = [];
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator | null = null;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageSize: number = 10;
  currentPage: number = 0;
  totalrecord: number = 0;
  showData: boolean = false;

  constructor(private commonService: CommonService, private spinner: NgxSpinnerService, private router: Router, private toastr: ToastrService, private apiUrl: ApiUrlHelper, private dialog: MatDialog, private translate: TranslateService, private languageService: LanguageService) { }

  ngOnInit(): void {
    this.fetchClientList();
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  fetchClientList() {
    this.showData = false;
    this.spinner.show();
    let api = this.apiUrl.apiUrl.Client.GetClientList;
    let ClientModel = {
      pageNumber: this.currentPage + 1,
      pageSize: this.pageSize,
      sortColumn: this.sortColumn,
      sortOrder: this.sortOrder,
      strSearch: this.searchKeyword,
    };
    this.commonService.doPost(api, ClientModel).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.showData = true;
          this.clientList = response.data;
          this.dataSource = response.data;
          this.spinner.hide();
          if (this.clientList.length > 0) {
            this.totalrecord = response.data[0].totalRecords;
          }
          if (this.clientList.length != 0) {
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
    this.fetchClientList();
  }

  //For Sort Data event happen
  sortData(event: any) {
    this.sortOrder = event.direction;
    this.sortColumn = event.active;
    this.fetchClientList();
  }

  clearSearch() {
    this.searchKeyword = '';
    this.fetchClientList();
  }

  applyFilter(event) {
    if ((event.target.value == '') || (event.key && event.key === "Enter" && event.target.value != '')) {
      this.currentPage = 0;
      this.fetchClientList();
    }
  }

  addEditClient(clientId: any) {
    const dialogRef = this.dialog.open(AddEditClientComponent, {
      width: '900px',
      data: { ClientId: clientId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.fetchClientList();
    });
  }

  userList(clientId: any, clientName: any) {
    var encodedClientName = encodeURIComponent(clientName);
    var objWithEncodedName = {
      clientId: clientId,
      clientName: encodedClientName
    };
    // Convert the object to a JSON string and encode it using btoa
    var encryptedObj = btoa(unescape(encodeURIComponent(JSON.stringify(objWithEncodedName))));
    this.router.navigate(['/user', encryptedObj]);
  }

  deleteClient(action: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.Client.DeleteClient.replace('{clientId}', DeleteId);
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
              this.fetchClientList();
              this.toastr.success(response.message);
            } else {
              this.spinner.hide();
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

  activeInactiveClient(ClientId: any, action: any, title: any) {
    const dialogRef = this.dialog.open(ActiveInactiveDialogComponentComponent, {
      width: '460px',
      data: { action, title },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.spinner.show();
        const apiUrl = this.apiUrl.apiUrl.Client.ActiveInActiveClient.replace('{clientId}', ClientId);
        this.commonService.doGet(apiUrl).pipe().subscribe({
          next: (response) => {
            if (response.success) {
              this.spinner.hide();
              this.toastr.success(response.message);
              this.fetchClientList();
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

  checkExpiry(expireDate: string): boolean {
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Set the time part to 00:00:00 for accurate comparison
    return new Date(expireDate) < today;
  }
}