import { Injectable } from "@angular/core";
import {
  Router,
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
} from "@angular/router";
import { TokenService } from "@services";

@Injectable({ providedIn: "root" })
export class AuthGuard {
  constructor(
    private _token: TokenService,
    private _router: Router,
  ) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    const accessToken = this._token.getTokens().accessToken;
    if (accessToken) {
      return true;
    } else {
      this._router.navigateByUrl("/login");
      return false;
    }
  }
}
