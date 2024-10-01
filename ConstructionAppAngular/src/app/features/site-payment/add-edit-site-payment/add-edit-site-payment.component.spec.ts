import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditSitePaymentComponent } from './add-edit-site-payment.component';

describe('AddEditSitePaymentComponent', () => {
  let component: AddEditSitePaymentComponent;
  let fixture: ComponentFixture<AddEditSitePaymentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditSitePaymentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditSitePaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
