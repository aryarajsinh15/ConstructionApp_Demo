import { Injectable, effect, signal } from '@angular/core';
import { NavigationService } from '@vex/services/navigation.service';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StorageService {
  constructor(private navigationService: NavigationService) {
    this.subject.next(this.getValue('userImage'));
  }

  siteRole = signal(this.getValue('roleId'));
  userImage = signal(this.getValue('userImage'));
  subject = new Subject();

  getValue(key: string): any {
    return localStorage.getItem(key);
  }

  updateRole(id: any) {
    this.siteRole.set(id);
    if (id == 1) {
      this.navigationService.items = [
        {
          type: "subheading",
          label: "",
          children: [
            {
              type: "link",
              label: "Dashboard",
              route: "/dashboard",
              icon: "mat:dashboard",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Clients",
              route: "/client",
              icon: "mat:supervisor_account",
              routerLinkActiveOptions: { exact: true },
            },
          ],
        },
      ]
    }
    else {
      this.navigationService.items = [
        {
          type: "subheading",
          label: "",
          children: [
            {
              type: "link",
              label: "Dashboard",
              route: "/dashboard",
              icon: "mat:dashboard",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Sites",
              route: "/site",
              icon: "mat:location_city",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Expenses",
              route: "/expense",
              icon: "mat:account_balance_wallet",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Merchants",
              route: "/merchant",
              icon: "mat:supervised_user_circle",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Merchant Payment",
              route: "/merchant-payment",
              icon: "mat:supervised_user_circle",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Persons",
              route: "/person",
              icon: "mat:supervisor_account",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Vehicle Owner",
              route: "/vehicle-owner",
              icon: "mat:nature_people",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Vehicle Rent",
              route: "/vehicle-rent",
              icon: "mat:local_shipping",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: 'Users',
              route: "/user",
              icon: "mat:people_outline",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Site Image Category",
              route: "/site-image-category",
              icon: "mat:image_search",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Challan",
              route: "/challan",
              icon: "mat:nature_people",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: 'Estimate',
              route: "/estimate",
              icon: "mat:nature_people",
              routerLinkActiveOptions: { exact: true },
            }
          ],
        },
        {
          type: "dropdown",
          icon: "mat:supervisor_account",
          label: "Attendance",
          children: [
            {
              type: "link",
              label: 'Persons',
              route: "/attedance/person",
              icon: "mat:supervisor_account",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: 'Person Group',
              route: "/person-group",
              icon: "mat:supervised_user_circle",
              routerLinkActiveOptions: { exact: true },
            },
            {
              type: "link",
              label: "Attendance",
              route: "/attendance",
              icon: "mat:supervised_user_circle",
              routerLinkActiveOptions: { exact: true },
            }
          ],
        }
      ]
    }
  }

  setValue(key: string, value: string): void {
    localStorage.setItem(key, value);
  }

  removeValue(key: string): void {
    localStorage.removeItem(key);
  }

  clearStorage(): void {
    localStorage.clear();
  }
}

export class StorageKey {
  public static userId = 'userId'
  public static authToken = 'authToken';
  public static expireDate: 'expireDate';
}