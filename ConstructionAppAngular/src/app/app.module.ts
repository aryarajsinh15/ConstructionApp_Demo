import { BrowserModule } from "@angular/platform-browser";
import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from "@angular/core";
import { AppRoutingModule } from "./app-routing.module";
import { AppComponent } from "./app.component";
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { VexModule } from "../@vex/vex.module";
import { HttpClient, HttpClientModule } from "@angular/common/http";
import { CustomLayoutModule } from "./custom-layout/custom-layout.module";
import { TranslateHttpLoader } from "@ngx-translate/http-loader";
import { TranslateLoader, TranslateModule } from "@ngx-translate/core";
import { MatDialogModule } from "@angular/material/dialog";
import { MatButtonModule } from "@angular/material/button";
import { DeleteConfirmationDialogComponentComponent } from "./component/delete-confirmation-dialog-component/delete-confirmation-dialog-component.component";
import { ToolbarModule } from "@vex/layout/toolbar/toolbar.module";
import { ConfirmationDialogComponentComponent } from "./component/confirmation-dialog-component/confirmation-dialog-component.component";
import { ActiveInactiveDialogComponentComponent } from "./component/active-inactive-dialog-component/active-inactive-dialog-component.component";
import { MatTableModule } from '@angular/material/table';
import { MatIconModule } from '@angular/material/icon';
import { NgxMatFileInputModule } from '@angular-material-components/file-input';
import { NgxSpinnerModule } from "ngx-spinner";
import { ToastrModule } from 'ngx-toastr';
import { MAT_DATE_LOCALE } from "@angular/material/core";

export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/json/', '.json');
}

@NgModule({
  declarations: [AppComponent, DeleteConfirmationDialogComponentComponent,ConfirmationDialogComponentComponent,ActiveInactiveDialogComponentComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    HttpClientModule,
    VexModule,
    ToolbarModule,
    CustomLayoutModule,
    MatDialogModule,
    MatButtonModule,
    MatTableModule,
    MatDialogModule,
    MatIconModule,
    NgxMatFileInputModule,
    NgxSpinnerModule.forRoot({ type: 'ball-scale-multiple' }),
    ToastrModule.forRoot({ closeButton: true }),
    TranslateModule.forRoot({
      defaultLanguage: 'en',
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [HttpClient]
      }
    }),
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],

  providers: [ { provide: MAT_DATE_LOCALE, useValue: 'en-GB' }],
  bootstrap: [AppComponent],
})
export class AppModule { }