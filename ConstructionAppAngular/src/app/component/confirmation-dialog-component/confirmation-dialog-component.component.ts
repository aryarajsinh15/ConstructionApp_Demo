import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { LanguageService } from 'app/services/language/language.service';

@Component({
  selector: 'vex-confirmation-dialog-component',
  templateUrl: './confirmation-dialog-component.component.html',
  styleUrl: './confirmation-dialog-component.component.scss'
})
export class ConfirmationDialogComponentComponent {

  action: string;

  constructor(@Inject(MAT_DIALOG_DATA) public data: { action: string, imagesrc?: any, isImageComponent?: any }, private translate:TranslateService , private languageService:LanguageService) {
    this.action = data.action;
  }

  ngOnInit(): void {
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }
}
