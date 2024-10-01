import { Component, ElementRef, HostBinding, Input } from "@angular/core";
import { LayoutService } from "../../services/layout.service";
import { ConfigService } from "../../config/config.service";
import { map, startWith, switchMap } from "rxjs/operators";
import { NavigationService } from "../../services/navigation.service";
import { PopoverService } from "../../components/popover/popover.service";
import { MegaMenuComponent } from "../../components/mega-menu/mega-menu.component";
import { Observable, of } from "rxjs";
import { LanguageService } from "app/services/language/language.service";
import { TranslateService } from "@ngx-translate/core";

@Component({
  selector: "vex-toolbar",
  templateUrl: "./toolbar.component.html",
  styleUrls: ["./toolbar.component.scss"],
})
export class ToolbarComponent {
  @Input() mobileQuery: boolean;

  @Input()
  @HostBinding("class.shadow-b")
  hasShadow: boolean;

  navigationItems = this.navigationService.items;

  isHorizontalLayout$: Observable<boolean> = this.configService.config$.pipe(
    map((config) => config.layout === "horizontal"),
  );
  isVerticalLayout$: Observable<boolean> = this.configService.config$.pipe(
    map((config) => config.layout === "vertical"),
  );
  isNavbarInToolbar$: Observable<boolean> = this.configService.config$.pipe(
    map((config) => config.navbar.position === "in-toolbar"),
  );
  isNavbarBelowToolbar$: Observable<boolean> = this.configService.config$.pipe(
    map((config) => config.navbar.position === "below-toolbar"),
  );
  userVisible$: Observable<boolean> = this.configService.config$.pipe(
    map((config) => config.toolbar.user.visible),
  );

  megaMenuOpen$: Observable<boolean> = of(false);
  currentLanguage: string = '';
  selectedLanguage: string = '';

  constructor(
    private layoutService: LayoutService,
    private configService: ConfigService,
    private navigationService: NavigationService,
    private popoverService: PopoverService,
    private languageService: LanguageService,
    private translate: TranslateService
  ) { this.currentLanguage = this.languageService.getCurrentLanguage(); }

  openQuickpanel(): void {
    this.layoutService.openQuickpanel();
  }
  
  ngOnInit() {
    this.translate.setDefaultLang('guj');
    // this.languageService.setLanguage('guj');
  }

  openSidenav(): void {
    this.layoutService.openSidenav();
  }

  openMegaMenu(origin: ElementRef | HTMLElement): void {
    this.megaMenuOpen$ = of(
      this.popoverService.open({
        content: MegaMenuComponent,
        origin,
        offsetY: 12,
        position: [
          {
            originX: "start",
            originY: "bottom",
            overlayX: "start",
            overlayY: "top",
          },
          {
            originX: "end",
            originY: "bottom",
            overlayX: "end",
            overlayY: "top",
          },
        ],
      }),
    ).pipe(
      switchMap((popoverRef) => popoverRef.afterClosed$.pipe(map(() => false))),
      startWith(true),
    );
  }

  openSearch(): void {
    this.layoutService.openSearch();
  }

  setLanguage(event: any): void {
    this.selectedLanguage = event;
    this.languageService.setLanguage(this.selectedLanguage);
    this.currentLanguage = this.selectedLanguage;
    window.location.reload();
  }
}
