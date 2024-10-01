import { HttpEvent, HttpHandler, HttpRequest } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { TokenService } from "@services";

@Injectable({
  providedIn: "root",
})
export class TokenInterceptor {
  constructor(public _tokenService: TokenService) { }
  intercept(
    request: HttpRequest<unknown>,
    next: HttpHandler,
  ): Observable<HttpEvent<unknown>> {
    const token = this._tokenService.getTokens().accessToken;
    return next.handle(
      request.clone({
        headers: request.headers.append("Authorization", token ? "Bearer " + token : ""),
        withCredentials: true,
      }),
    );
  }
}
