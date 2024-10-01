import { Injectable } from "@angular/core";
import { Router } from "@angular/router";
import { HttpEvent, HttpHandler, HttpRequest } from "@angular/common/http";
import { Observable, catchError, throwError } from "rxjs";
import { TokenService } from "@services";

@Injectable({
  providedIn: "root",
})
export class ErrorInterceptor {
  constructor(
    private _tokenService: TokenService,
    private router: Router,
  ) {}

  intercept(
    request: HttpRequest<any>,
    next: HttpHandler,
  ): Observable<HttpEvent<any>> {
    return next.handle(request).pipe(
      catchError((err) => {
        if (err.status === 401) {
          // auto logout if 401 response returned from api
          this._tokenService.removeTokens();
          this.router.navigate(["login"]);
        }
        const error = err.error.message || err.statusText;
        return throwError(error);
      }),
    );
  }
}
