import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";
import { ShareBottomSheetComponent } from "./share-bottom-sheet.component";
import { MatBottomSheetModule } from "@angular/material/bottom-sheet";
import { MatListModule } from "@angular/material/list";
import { RouterModule } from "@angular/router";
import { MatIconModule } from "@angular/material/icon";

@NgModule({
  declarations: [ShareBottomSheetComponent],
  imports: [
    CommonModule,
    MatBottomSheetModule,
    MatListModule,
    RouterModule,
    MatIconModule,
  ],
  exports: [MatBottomSheetModule],
})
export class ShareBottomSheetModule {}
