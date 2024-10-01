import { Injectable } from '@angular/core';
import { StorageKey, StorageService } from '../storage/storage.service';
import { CommonService } from '../common/common.service';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private storageService: StorageService, public commonService: CommonService,
  ) { }

  isTokenExpired(): boolean {
    let expireDate = this.storageService.getValue('expireDate');
    return new Date().getTime() > new Date(expireDate).getTime();
  }

  isLoggedIn(): boolean {
    let token = this.storageService.getValue('authToken');
    let currentUser = this.storageService.getValue('userId');
    if (token && currentUser)
      return true;
    else
      return false;
  }

  isAccessToAdmin(): boolean {
    let siteRole = this.storageService.getValue('roleId');
    if (siteRole == 1) {
      return true;
    }
    else {
      return false;
    }
  }

  getAccessToken(): any {
    let token = this.storageService.getValue(StorageKey.authToken);
    return token ? token : null;
  }
}