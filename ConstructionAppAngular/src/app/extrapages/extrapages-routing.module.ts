import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { Basic404Component } from "./basic404/basic404.component";

const routes: Routes = [
  {
    path: "404",
    component: Basic404Component,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ExtrapagesRoutingModule {}
