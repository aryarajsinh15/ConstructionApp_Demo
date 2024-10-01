import { Component, Inject, LOCALE_ID, Renderer2 } from "@angular/core";
import { ConfigService } from "../@vex/config/config.service";
import { Settings } from "luxon";
import { DOCUMENT } from "@angular/common";
import { Platform } from "@angular/cdk/platform";
import { NavigationService } from "../@vex/services/navigation.service";
import { LayoutService } from "../@vex/services/layout.service";
import { ActivatedRoute } from "@angular/router";
import { coerceBooleanProperty } from "@angular/cdk/coercion";
import { SplashScreenService } from "../@vex/services/splash-screen.service";
import { VexConfigName } from "../@vex/config/config-name.model";
import { ColorSchemeName } from "../@vex/config/colorSchemeName";
import {
  MatIconRegistry,
  SafeResourceUrlWithIconOptions,
} from "@angular/material/icon";
import { DomSanitizer, SafeResourceUrl } from "@angular/platform-browser";
import {
  ColorVariable,
  colorVariables,
} from "../@vex/components/config-panel/color-variables";
import { StorageService } from "./services/storage/storage.service";
import { TranslateService } from "@ngx-translate/core";
import { LanguageService } from "./services/language/language.service";

@Component({
  selector: "vex-root",
  templateUrl: "./app.component.html",
  styleUrls: ["./app.component.scss"],
})
export class AppComponent {

  roleId: any = this.storageService.siteRole;
  constructor(
    private configService: ConfigService,
    private renderer: Renderer2,
    private platform: Platform,
    @Inject(DOCUMENT) private document: Document,
    @Inject(LOCALE_ID) private localeId: string,
    private layoutService: LayoutService,
    private route: ActivatedRoute,
    private navigationService: NavigationService,
    private splashScreenService: SplashScreenService,
    private readonly matIconRegistry: MatIconRegistry,
    private readonly domSanitizer: DomSanitizer,
    private storageService: StorageService,
    private transalteService: TranslateService,
    private languageService: LanguageService
  ) {
    Settings.defaultLocale = this.localeId;
    this.transalteService.setDefaultLang('en');
    if (this.platform.BLINK) {
      this.renderer.addClass(this.document.body, "is-blink");
    }

    this.matIconRegistry.addSvgIconResolver(
      (
        name: string,
        namespace: string,
      ): SafeResourceUrl | SafeResourceUrlWithIconOptions | null => {
        switch (namespace) {
          case "mat":
            return this.domSanitizer.bypassSecurityTrustResourceUrl(
              `assets/img/icons/material-design-icons/two-tone/${name}.svg`,
            );

          case "logo":
            return this.domSanitizer.bypassSecurityTrustResourceUrl(
              `assets/img/icons/logos/${name}.svg`,
            );

          case "flag":
            return this.domSanitizer.bypassSecurityTrustResourceUrl(
              `assets/img/icons/flags/${name}.svg`,
            );
        }
      },
    );

    /**
     * Customize the template to your needs with the ConfigService
     * Example:
     *  this.configService.updateConfig({
     *    sidenav: {
     *      title: 'Custom App',
     *      imageUrl: '//placehold.it/100x100',
     *      showCollapsePin: false
     *    },
     *    footer: {
     *      visible: false
     *    }
     *  });
     */

    /**
     * Config Related Subscriptions
     * You can remove this if you don't need the functionality of being able to enable specific configs with queryParams
     * Example: example.com/?layout=apollo&style=default
     */
    this.route.queryParamMap.subscribe((queryParamMap) => {
      if (queryParamMap.has("layout")) {
        this.configService.setConfig(
          queryParamMap.get("layout") as VexConfigName,
        );
      }

      if (queryParamMap.has("style")) {
        this.configService.updateConfig({
          style: {
            colorScheme: queryParamMap.get("style") as ColorSchemeName,
          },
        });
      }

      if (queryParamMap.has("primaryColor")) {
        const color: ColorVariable =
          colorVariables[queryParamMap.get("primaryColor")];

        if (color) {
          this.configService.updateConfig({
            style: {
              colors: {
                primary: color,
              },
            },
          });
        }
      }

      if (queryParamMap.has("rtl")) {
        this.configService.updateConfig({
          direction: coerceBooleanProperty(queryParamMap.get("rtl"))
            ? "rtl"
            : "ltr",
        });
      }
    });
  }

  ngOnInit(): void {
    this.translateLabels();
    var language = localStorage.getItem('language');
    if(language == null || language == '' || language== undefined){
      language = 'en';
    }
    this.transalteService.use(language);
    this.languageService.currentLanguage$.subscribe(language => {
      this.transalteService.use(language);
    });
  }
  translateLabels() {
      this.transalteService.get(['ATTEDANCE', 'DASHBOARD', 'CLIENTS', 'SITES', 'EXPENSES', 'MERCHANTS', 'MERCHANT_PAYMENT', 'PERSONS', 'VEHICLE_OWNER','VEHICLE_RENT','CHALLAN','ESTIMATE','USERS','SITE_IMAGE_CATEGORY','PERSON_GROUP','ATTENDACNE_LIST']).subscribe((translations) => {
      if (this.roleId() == 1) {
        this.navigationService.items = [
          {
            type: "subheading",
            label: "",
            children: [
              {
                type: "link",
                label: translations['DASHBOARD'],
                route: "/dashboard",
                icon: "mat:dashboard",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['CLIENTS'],
                route: "/client",
                icon: "mat:supervisor_account",
                routerLinkActiveOptions: { exact: true },
              },
            ],
          },
        ]
      }
      else if (this.roleId() == 2) {
        this.navigationService.items = [
          {
            type: "subheading",
            label: "",
            children: [
              {
                type: "link",
                label: translations['DASHBOARD'],
                route: "/dashboard",
                icon: "mat:dashboard",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['SITES'],
                route: "/site",
                icon: "mat:location_city",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['EXPENSES'],
                route: "/expense",
                icon: "mat:account_balance_wallet",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['MERCHANTS'],
                route: "/merchant",
                icon: "mat:supervised_user_circle",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['MERCHANT_PAYMENT'],
                route: "/merchant-payment",
                icon: "mat:supervised_user_circle",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['PERSONS'],
                route: "/person",
                icon: "mat:supervisor_account",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['VEHICLE_OWNER'],
                route: "/vehicle-owner",
                icon: "mat:nature_people",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['VEHICLE_RENT'],
                route: "/vehicle-rent",
                icon: "mat:local_shipping",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['USERS'],
                route: "/user",
                icon: "mat:people_outline",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['SITE_IMAGE_CATEGORY'],
                route: "/site-image-category",
                icon: "mat:image_search",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['CHALLAN'],
                route: "/challan",
                icon: "mat:nature_people",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['ESTIMATE'],
                route: "/estimate",
                icon: "mat:nature_people",
                routerLinkActiveOptions: { exact: true },
              },
            ],
          },
          {
            type: "dropdown",
            icon: "mat:supervisor_account",
            label: translations['ATTEDANCE'],
            children: [
              {
                type: "link",
                label: translations['PERSONS'],
                route: "/attedance/person",
                icon: "mat:supervisor_account",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['PERSON_GROUP'],
                route: "/person-group",
                icon: "mat:supervised_user_circle",
                routerLinkActiveOptions: { exact: true },
              },
              {
                type: "link",
                label: translations['ATTENDACNE_LIST'],
                route: "/attendance",
                icon: "mat:supervised_user_circle",
                routerLinkActiveOptions: { exact: true },
              },
            ],
          }
        ]
      }
    });
  }
}