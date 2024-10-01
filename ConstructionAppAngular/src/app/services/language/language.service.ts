import { Injectable } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { Observable } from 'rxjs';
import { BehaviorSubject } from 'rxjs/internal/BehaviorSubject';

@Injectable({
  providedIn: 'root'
})

export class  LanguageService {

  private readonly languageStorageKey = 'selectedLanguage';
  private currentLanguageSubject: BehaviorSubject<string>;
  public currentLanguage$: Observable<string>;
  constructor(private translate: TranslateService) {
    const savedLanguage = localStorage.getItem(this.languageStorageKey) || 'en';
    this.currentLanguageSubject = new BehaviorSubject<string>(savedLanguage);
    this.currentLanguage$ = this.currentLanguageSubject.asObservable();
    this.translate.setDefaultLang(savedLanguage);
    this.translate.use(savedLanguage);
  }

  // setLanguage(language: string) {
  //   this.translate.use(language);
  //   localStorage.setItem(this.languageStorageKey, language);
  // }

  // private loadLanguage() {
  //   const selectedLanguage = localStorage.getItem(this.languageStorageKey);
  //   if (selectedLanguage) {
  //     this.translate.setDefaultLang(selectedLanguage);
  //     this.translate.use(selectedLanguage);
  //   }
  // }

  setLanguage(language: string) {
    this.translate.use(language);
    localStorage.setItem(this.languageStorageKey, language);
    this.currentLanguageSubject.next(language);
  }

  getCurrentLanguage(): string {
    return this.currentLanguageSubject.value;
  }
}