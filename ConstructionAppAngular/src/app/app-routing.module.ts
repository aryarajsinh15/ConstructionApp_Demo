import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { CustomLayoutComponent } from "./custom-layout/custom-layout.component";
import { Basic404Component } from "./extrapages/basic404/basic404.component";

const routes: Routes = [
  {
    path: '',
    redirectTo : 'login',
    pathMatch: 'full' 
  },
  {
    path: "",
    component: CustomLayoutComponent,
    loadChildren: () =>
      import("./features/features.module").then((m) => m.FeaturesModule),
  },
  {
    path: "login",
    loadChildren: () =>
      import("./authentication/authentication.module").then(
        (m) => m.AuthenticationModule,
      ),
  },
  {
    path: "pages",
    loadChildren: () =>
      import("./extrapages/extrapages.module").then((m) => m.ExtrapagesModule),
  },
  {
    path: "**",
    component: Basic404Component,
  },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      scrollPositionRestoration: "enabled",
      anchorScrolling: "enabled",
    }),
  ],
  exports: [RouterModule],
})
export class AppRoutingModule {}
