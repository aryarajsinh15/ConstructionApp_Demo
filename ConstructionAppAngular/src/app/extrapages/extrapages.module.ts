import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";
import { ExtrapagesRoutingModule } from "./extrapages-routing.module";
import { Basic404Component } from "./basic404/basic404.component";
import { MatButtonModule } from "@angular/material/button";
import { MatIconModule } from "@angular/material/icon";

@NgModule({
  declarations: [Basic404Component],
  imports: [CommonModule, ExtrapagesRoutingModule,MatButtonModule,MatIconModule],
})
export class ExtrapagesModule {}
