import { Inject, Injectable, InjectionToken, Optional } from "@angular/core";
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
} from "@angular/common/http";
import { Observable } from "rxjs";
export const API_URL = new InjectionToken<string>("API_URL");
@Injectable()
export class BaseUrlInterceptor implements HttpInterceptor {
  private haveToAppendApiUrl = (url: string) =>
    !(this.apiUrl && url.includes("assets"));
  constructor(@Optional() @Inject(API_URL) private apiUrl?: string) {}

  intercept(
    request: HttpRequest<unknown>,
    next: HttpHandler,
  ): Observable<HttpEvent<unknown>> {
    return this.haveToAppendApiUrl(request.url)
      ? next.handle(request.clone({ url: this.prependBaseUrl(request.url) }))
      : next.handle(request);
  }

  private prependBaseUrl(url: string) {
    return [this.apiUrl?.replace(/\/$/g, ""), url.replace(/^\.?\//, "")]
      .filter((val) => val)
      .join("/");
  }
}
