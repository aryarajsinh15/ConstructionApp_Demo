import { Component } from "@angular/core";
import { Router } from "@angular/router";

@Component({
  selector: "vex-basic404",
  templateUrl: "./basic404.component.html",
  styleUrls: ["./basic404.component.scss"],
})
export class Basic404Component {

  constructor(private route: Router) { }

  goToLogin() {
    this.route.navigate(['/login'])
  }
}
