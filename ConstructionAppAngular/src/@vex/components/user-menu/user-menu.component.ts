import { Component, OnInit } from "@angular/core";
import { PopoverRef } from "../popover/popover-ref";
import { Router } from "@angular/router";
import { ConfirmationDialogComponentComponent } from "app/component/confirmation-dialog-component/confirmation-dialog-component.component";
import { MatDialog } from "@angular/material/dialog";
import { ToastrService } from "ngx-toastr";
import { LanguageService } from "app/services/language/language.service";
import { TranslateService } from "@ngx-translate/core";

@Component({
  selector: "vex-user-menu",
  templateUrl: "./user-menu.component.html",
  styleUrls: ["./user-menu.component.scss"],
})
export class UserMenuComponent implements OnInit {
  constructor(private translate: TranslateService, private languageService: LanguageService, private readonly popoverRef: PopoverRef, private toastr: ToastrService, private route: Router, private dialog: MatDialog) { }

  ngOnInit(): void {
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  close(): void {
    /** Wait for animation to complete and then close */
    setTimeout(() => this.popoverRef.close(), 250);
  }

  goToChangePassword() {
    this.route.navigate(['/change-password']);
  }

  goToProfile() {
    this.route.navigate(['/profile']);
  }

  backToSignIn(action: any) {
    const dialogRef = this.dialog.open(ConfirmationDialogComponentComponent, {
      width: '460px',
      data: { action },
      disableClose: true,
      autoFocus: false
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        localStorage.clear();
        // this.toastr.success('Logged out successfully.');
        this.route.navigate(['/login']);
      }
    })
  }
}
