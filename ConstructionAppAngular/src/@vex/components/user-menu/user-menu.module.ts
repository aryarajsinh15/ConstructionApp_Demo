import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";
import { UserMenuComponent } from "./user-menu.component";
import { MatRippleModule } from "@angular/material/core";
import { RouterModule } from "@angular/router";
import { MatIconModule } from "@angular/material/icon";
import { ToastrModule } from "ngx-toastr";
import { TranslateHttpLoader } from "@ngx-translate/http-loader";
import { HttpClient } from "@angular/common/http";
import { TranslateLoader, TranslateModule } from "@ngx-translate/core";

export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/json/', '.json');
}
@NgModule({
  declarations: [UserMenuComponent],
  exports: [TranslateModule],
  imports: [CommonModule, MatRippleModule, RouterModule, MatIconModule, ToastrModule.forRoot(),
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [HttpClient]
      }
    }),],
})
export class UserMenuModule { }
