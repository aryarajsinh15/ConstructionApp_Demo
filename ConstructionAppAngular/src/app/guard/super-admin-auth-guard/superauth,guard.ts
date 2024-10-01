import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../../services/auth-service/auth.service';

@Injectable({
    providedIn: 'root',
})
export class SuperAuthGuard {
    constructor(private authService: AuthService, private router: Router) { }
    canActivate(
        route: ActivatedRouteSnapshot,
        state: RouterStateSnapshot
    ):
        | boolean
        | UrlTree
        | Observable<boolean | UrlTree>
        | Promise<boolean | UrlTree> {
        if (!this.authService.isLoggedIn()) {
            this.router.navigate(['/login']); // go to login if not authenticated
            return false;
        }
        if (this.authService.isAccessToAdmin()) {
            this.router.navigate(['/login']); // go to login if trying to access another modules
            return false;
        }
        return true;
    }
}
