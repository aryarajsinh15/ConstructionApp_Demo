import { Component } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { fadeInRight400ms } from '@vex/animations/fade-in-right.animation';
import { fadeInUp400ms } from '@vex/animations/fade-in-up.animation';
import { scaleIn400ms } from '@vex/animations/scale-in.animation';
import { stagger40ms } from '@vex/animations/stagger.animation';
import { UplaodPhotoGalleryComponent } from '../uplaod-photo-gallery/uplaod-photo-gallery.component';
import { Fancybox } from "@fancyapps/ui";
import { Carousel } from "@fancyapps/ui/dist/carousel/carousel.esm.js";
import { NgxSpinnerService } from 'ngx-spinner';
import { CommonService } from 'app/services/common/common.service';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { ToastrService } from 'ngx-toastr';
import { DeleteConfirmationDialogComponentComponent } from 'app/component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component';

@Component({
  selector: 'vex-photo-gallery',
  templateUrl: './photo-gallery.component.html',
  styleUrl: './photo-gallery.component.scss',
  animations: [
    scaleIn400ms,
    stagger40ms,
    fadeInUp400ms,
    fadeInRight400ms
  ]
})
export class PhotoGalleryComponent {

  siteObj: any
  parseSiteObj: any
  siteId: any;
  siteName:any;
  panelOpenState = false;
  siteCategoryImageList: any;
  sitePhotoId: any;

  constructor(private toastr: ToastrService, private spinner: NgxSpinnerService, private route: ActivatedRoute, private dialog: MatDialog, private router: Router, private commonService: CommonService, private apiUrl: ApiUrlHelper) { }

  ngOnInit(): void {
    // this.siteObj = atob((this.route.snapshot.paramMap.get('siteid')));
    // this.parseSiteObj = JSON.parse(this.siteObj)
    // this.siteId = this.parseSiteObj.siteId;
    // this.siteName = this.parseSiteObj.siteName;
    const encodedSiteObj = this.route.snapshot.paramMap.get('siteid');
    const siteObjJsonString = atob(encodedSiteObj);
    const parsedSiteObj = JSON.parse(siteObjJsonString);
    this.siteId = parsedSiteObj.siteId;
    const encodedSiteName = parsedSiteObj.siteName;
    this.siteName = decodeURIComponent(encodedSiteName);
    this.getCategoryImageList();
  }

  uploadSiteImage(siteId: any) {
    const dialogRef = this.dialog.open(UplaodPhotoGalleryComponent, {
      width: '800px',
      data: { SiteId: siteId },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.getCategoryImageList();
    });
  }

  getCategoryImageList() {
    let apiUrl = this.apiUrl.apiUrl.Site.GetSiteCategoryImageList.replace('{siteId}', this.siteId);
    this.spinner.show();
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        if (response.success) {
          this.siteCategoryImageList = response.data;
          const container = document.getElementById("myCarousel");
          const options = {
            infinite: true,
            Navigation: false,
            Dots: true,
          };
          if (container && container != null && container != undefined) {
            new Carousel(container, options);
            this.initFancybox();
          }
          this.spinner.hide();
        } else {
          this.toastr.error(response.message);
          this.spinner.hide();
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  deleteImageById(imagesrc: any, DeleteId: any) {
    const apiUrl = this.apiUrl.apiUrl.Site.DeleteIamgeBySitePhotoId.replace('{sitePhotoId}', DeleteId);
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponentComponent, {
      width: '460px',
      data: { imagesrc },
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
              this.getCategoryImageList();
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

  handleImageError(img: any) {
    img.photoName = '../../../assets/img/shaligram_logo/default_img.png';
  }

  backToSite() {
    this.router.navigate(['/site']);
  }

  initFancybox() {
    Fancybox.bind('[data-fancybox="gallery"]');
  }
}