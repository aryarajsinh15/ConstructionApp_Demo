import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";

@Injectable({
  providedIn: "root",
})
export class CommonService {
  [x: string]: any;
  constructor(private http: HttpClient) {}
}
