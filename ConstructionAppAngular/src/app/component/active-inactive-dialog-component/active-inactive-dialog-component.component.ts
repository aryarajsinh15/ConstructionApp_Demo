import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { LanguageService } from 'app/services/language/language.service';

@Component({
  selector: 'vex-active-inactive-dialog-component',
  templateUrl: './active-inactive-dialog-component.component.html',
  styleUrl: './active-inactive-dialog-component.component.scss'
})
export class ActiveInactiveDialogComponentComponent implements OnInit {

  action: string;
  title: string;

  constructor(@Inject(MAT_DIALOG_DATA) public data: { action: string, title: any } , private translate:TranslateService , private languageService:LanguageService) {
    this.action = data.action;
    this.title = data.title
  }

  ngOnInit(): void {
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }
}
