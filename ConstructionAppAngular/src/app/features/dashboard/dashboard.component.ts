import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'vex-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss'
})
export class DashboardComponent {

  dashboardInfo: any = [];
  siteCount: any;
  userCount: any;
  merchantCount: any;
  personCount: any;
  ownerCount: any;
  clientCount: any;
  roleId: any;

  constructor(private translate: TranslateService,private languageService: LanguageService, private router: Router, private commonService: CommonService, private spinner: NgxSpinnerService, private apiUrl: ApiUrlHelper) { }

  ngOnInit(): void {
    this.getDashBoardInfo();
    this.roleId = localStorage.getItem("roleId");
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  getDashBoardInfo() {
    this.spinner.show();
    let api = this.apiUrl.apiUrl.Dashboard.DashboardInfo;
    this.commonService.doGet(api).pipe().subscribe({
      next: (response: any) => {
        if (response.success) {
          this.dashboardInfo = response.data;
          this.siteCount = this.dashboardInfo.siteCount;
          this.userCount = this.dashboardInfo.userCount;
          this.personCount = this.dashboardInfo.personCount;
          this.merchantCount = this.dashboardInfo.merchantCount;
          this.ownerCount = this.dashboardInfo.vehicleOwnerCount;
          this.clientCount = this.dashboardInfo.clientCount;
          this.spinner.hide();
        } else {
          this.spinner.hide();
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  navigate(url: any) {
    if (url == "" || url == null || url == undefined) {
      this.router.navigate(['site'])
    }
    else {
      this.router.navigate([url])
    }
  }
}