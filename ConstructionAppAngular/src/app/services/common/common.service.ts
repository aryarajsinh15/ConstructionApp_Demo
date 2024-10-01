import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { ApiResponse } from '../../models/commonModel';
import { HttpClient, HttpErrorResponse, HttpHeaders, HttpStatusCode } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { Observable, catchError, of, tap, Subject, BehaviorSubject, throwError, share } from 'rxjs';
import { AppService } from '../app-service/app.service';
import { MatDialog } from '@angular/material/dialog';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class CommonService {
  private userImageSource = new BehaviorSubject<string | null>(null);
  userImage$ = this.userImageSource.asObservable();
  private errorMessage: string = "Something went wrong. Please try again after sometime.";
  setAutoHide: boolean = true;
  autoHide: number = 2000;
  private logoutSubject = new Subject<void>();
  public logoutAction$ = this.logoutSubject.asObservable();
  public href: any;
  IsError: boolean = false;
  isSystemAlert: boolean = false;
  constructor(private toastr: ToastrService, private spinner: NgxSpinnerService,private router: Router, private dialog: MatDialog, private appService: AppService, private http: HttpClient) { }

  DownloadCSVFile(apiUrl: String, postData: any): Observable<any> {
    const url = `${environment.BaseURL}${apiUrl}`;
    return this.http.post<Blob>(url, postData,
      {
        responseType: 'blob' as 'json',
        headers: new HttpHeaders(
          {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, DELETE, PUT',
            'Authorization': 'Bearer ' + localStorage.getItem('authToken'),
          })
      });
  }

  GetDownloadCSVFile(apiUrl: String): Observable<any> {
    const url = `${environment.BaseURL}${apiUrl}`;
    return this.http.get<Blob>(url,
      {
        responseType: 'blob' as 'json',
        headers: new HttpHeaders(
          {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, DELETE, PUT',
            'Authorization': 'Bearer ' + localStorage.getItem('authToken'),
          })
      });
  }

  DownloadPDFFile(apiUrl: string): Observable<Blob> {
    const url = `${environment.BaseURL}${apiUrl}`;
    const headers = new HttpHeaders({
      'Authorization': 'Bearer ' + localStorage.getItem('authToken'),
    });

    return this.http.get<Blob>(url, {
      responseType: 'blob' as 'json',
      headers: headers,
    }).pipe(
      share() // Add the share operator here if needed
    );
  }

  DownloadPDFFilePost(apiUrl: string, postData: any): Observable<Blob> {
    const url = `${environment.BaseURL}${apiUrl}`;
    const headers = new HttpHeaders({
      'Authorization': 'Bearer ' + localStorage.getItem('authToken'),
    });

    return this.http.post<Blob>(url, postData,
      {
        responseType: 'blob' as 'json',
        headers: headers,
      }).pipe(
        share() // Add the share operator here if needed
      );
  }

  doDownloadCSVPost(apiUrl: string, postData: any) {
    const httpOptions = {
      headers: new HttpHeaders()
    };
    let loginData = localStorage.getItem('authToken');
    if (loginData) {
      httpOptions.headers = httpOptions.headers.set('Authorization', 'Bearer ' + loginData);
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Methods', '*');
    }
    return this.http.post(`${environment.BaseURL}${apiUrl}`, postData, { headers: httpOptions.headers, observe: "response", responseType: "blob" });
  }

  doGet(apiUrl: String): Observable<ApiResponse> {
    const httpOptions = {
      headers: new HttpHeaders()
    };
    let loginData = localStorage.getItem('authToken');
    if (loginData) {
      httpOptions.headers = httpOptions.headers.set('Authorization', 'Bearer ' + loginData);
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Origin', '*');
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Methods', 'POST, GET, OPTIONS, DELETE, PUT');
    }
    const url = `${environment.BaseURL}${apiUrl}`;
    return this.http.get<ApiResponse>(url, httpOptions).pipe(
      tap(() => this.log(`doGet success`)),
      catchError((error: HttpErrorResponse) => {
        this.checkAuthorize(error);
        return throwError(() => error);
      })
    );
  }

  doPost(apiUrl: string, postData: any): Observable<ApiResponse> {
    const httpOptions = {
      headers: new HttpHeaders(
      )
    };
    let loginData = localStorage.getItem('authToken');
    if (loginData) {
      httpOptions.headers = httpOptions.headers.set('Authorization', 'Bearer ' + loginData);
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Origin', '*');
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Methods', 'POST, GET, OPTIONS, DELETE, PUT');
    }
    const url = `${environment.BaseURL}${apiUrl}`;
    return this.http.post<ApiResponse>(url, postData, httpOptions).pipe(
      tap(() => this.log(`doGet success`)),
      catchError((error: HttpErrorResponse) => {
        this.checkAuthorize(error);
        return throwError(() => error);
      })
    );
  }

  doPut(apiUrl: string, putData: any): Observable<ApiResponse> {
    const httpOptions = {
      headers: new HttpHeaders(
      )
    };
    let loginData = localStorage.getItem('authToken');
    if (loginData) {
      httpOptions.headers = httpOptions.headers.set('Authorization', 'Bearer ' + loginData);
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Origin', '*');
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Methods', 'POST, GET, OPTIONS, DELETE, PUT');
    }
    const url = `${environment.BaseURL}${apiUrl}`;
    return this.http.put<ApiResponse>(url, putData, httpOptions).pipe(
      tap(() => this.log(`doGet success`)),
      catchError((error: HttpErrorResponse) => {
        this.checkAuthorize(error);
        return throwError(() => error);
      })
    );
  }

  doDownloadPost(apiUrl: string, postData: any) {
    const httpOptions = {
      headers: new HttpHeaders()
    };
    let loginData = localStorage.getItem('authToken');
    if (loginData) {
      httpOptions.headers = httpOptions.headers.set('Authorization', 'Bearer ' + loginData);
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Methods', '*');
    }
    const url = `${environment.BaseURL}${apiUrl}`;
    return this.http.post(url, postData, { headers: httpOptions.headers, observe: "response", responseType: "blob" });
  }

  doDelete(apiUrl: String, idtoDelete: any): Observable<ApiResponse> {
    const httpOptions = {
      headers: new HttpHeaders(
      )
    };
    let loginData = localStorage.getItem('authToken');
    if (loginData) {
      httpOptions.headers = httpOptions.headers.set('Authorization', 'Bearer ' + loginData);
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Origin', '*');
      httpOptions.headers = httpOptions.headers.set('Access-Control-Allow-Methods', 'POST, GET, OPTIONS, DELETE, PUT');
    }
    const options = {
      headers: httpOptions.headers,
      body: {
        UserId: idtoDelete
      }
    };
    const url = (`${environment.BaseURL}${apiUrl}`);
    return this.http.delete<ApiResponse>(url, httpOptions).pipe(
      tap(() => this.log(`doGet success`)),
      catchError((error: HttpErrorResponse) => {
        this.checkAuthorize(error);
        return throwError(() => error);
      })
    );
  }

  // Check Authorize Role
  checkAuthorize(error) {
    if (error.status == HttpStatusCode.Unauthorized) {
      this.toastr.error("Something went wrong ! Please try again after sometime.");
      this.spinner.hide();
      this.appService.logout();
      this.dialog.closeAll();
    }
    else if (error.status == HttpStatusCode.Forbidden) {
      this.toastr.error("Your session has been expired, Please login again!");
      localStorage.clear();
      this.appService.logout();
      this.spinner.hide();
      this.dialog.closeAll();
    }
    else if (error.status === HttpStatusCode.InternalServerError) {
      this.toastr.error("Something went wrong ! Please try again after sometime.")
      this.appService.logout();
      this.spinner.hide();
      this.dialog.closeAll();
    }
    else {
      var errorMessage = (error.error.message != null) ? error.error.message : error.message
    }
  }

  /**
   * Handle Http operation that failed.
   * Let the app continue.
   * @param operation - name of the operation that failed
   * @param result - optional value to return as the observable result
   */
  private handleError<T>(operation = 'operation', result?: T) {

    return (error: any): Observable<T> => {
      this.checkAuthorize(error);

      // TODO: send the error to remote logging infrastructure
      console.error(error); // log to console instead

      // TODO: better job of transforming error for user consumption
      console.log(`${operation} failed: ${error.message}`);

      // Let the app keep running by returning an empty result.
      return of(result as T);
    };
  }

  /** Log a HeroService message with the MessageService */
  private log(message: string) {
    this.IsError = false;
  }

  setUserImage(imageSrc: string | null) {
    this.userImageSource.next(imageSrc);
  }

  getUserImage(): Observable<string | null> {
    return this.userImage$;
  }

  private formSubmittedSubject = new BehaviorSubject<boolean>(false);
  formSubmitted$ = this.formSubmittedSubject.asObservable();

  setFormSubmitted(value: boolean): void {
    this.formSubmittedSubject.next(value);
  }

  getFormSubmitted(): boolean {
    return this.formSubmittedSubject.value;
  }
  
  getFinancialYearStartDate(): Date {
    const today = new Date();
    const currentYear = today.getFullYear();
    const startMonth = 3;
    const startDay = 1;
  
    let startDate;
    if (today.getMonth() < startMonth) {
      startDate = new Date(currentYear - 1, startMonth, startDay);
    } else {
      startDate = new Date(currentYear, startMonth, startDay);
    }
  
    // Add 5 hours and 30 minutes
    startDate.setHours(startDate.getHours() + 5);
    startDate.setMinutes(startDate.getMinutes() + 30);
  
    return startDate;
  }

  getFirstDateOfCurrentMonth() : Date {
    const today = new Date();
    const currentYear = today.getFullYear();
    const startMonth = today.getMonth();
    const startDay = 1;
  
    let startDate;
    startDate = new Date(currentYear - 1, startMonth, startDay);
  
    // Add 5 hours and 30 minutes
    startDate.setHours(startDate.getHours() + 5);
    startDate.setMinutes(startDate.getMinutes() + 30);
  
    return startDate;
  }

  getCurrentDateWithOffset(date : any): Date {
    const currentDate = new Date(date);
  
    currentDate.setHours(23);
    currentDate.setMinutes(59);
  
    return currentDate;
  }
}
