import { ComponentFixture, TestBed, waitForAsync } from "@angular/core/testing";

import { WidgetQuickValueStartComponent } from "./widget-quick-value-start.component";

describe("WidgetQuickValueStartComponent", () => {
  let component: WidgetQuickValueStartComponent;
  let fixture: ComponentFixture<WidgetQuickValueStartComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [WidgetQuickValueStartComponent],
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WidgetQuickValueStartComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it("should create", () => {
    expect(component).toBeTruthy();
  });
});
