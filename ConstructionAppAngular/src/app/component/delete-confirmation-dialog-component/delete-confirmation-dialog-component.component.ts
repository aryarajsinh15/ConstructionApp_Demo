import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { LanguageService } from 'app/services/language/language.service';

@Component({
  selector: 'vex-delete-confirmation-dialog-component',
  templateUrl: './delete-confirmation-dialog-component.component.html',
  styleUrl: './delete-confirmation-dialog-component.component.scss'
})
export class DeleteConfirmationDialogComponentComponent {

  action: string;
  ImageSrc: any;

  constructor(@Inject(MAT_DIALOG_DATA) public data: { action: string, imagesrc?: any, isImageComponent?: any }, private translate: TranslateService, private languageService: LanguageService) {
    this.action = data.action;
    this.ImageSrc = data.imagesrc;
  }

  ngOnInit(): void {
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }
}
