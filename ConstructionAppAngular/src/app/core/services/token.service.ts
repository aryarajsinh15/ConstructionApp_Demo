import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { environment } from "environments/environment";

@Injectable({
  providedIn: "root",
})
export class TokenService {
  private tokenKey = environment.tokenKey;

  keysToRemoveOfLocalStorage = [environment.tokenKey];
  constructor(private http: HttpClient) {}

  getTokens() {
    return JSON.parse(
      localStorage.getItem(this.tokenKey) ??
        sessionStorage.getItem(this.tokenKey) ??
        "{}",
    );
  }

  removeTokens() {
    for (const key of this.keysToRemoveOfLocalStorage) {
      localStorage.removeItem(key);
    }
  }
}
