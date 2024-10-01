import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditSitePaymentDebitComponent } from './add-edit-site-payment-debit.component';

describe('AddEditSitePaymentDebitComponent', () => {
  let component: AddEditSitePaymentDebitComponent;
  let fixture: ComponentFixture<AddEditSitePaymentDebitComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditSitePaymentDebitComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditSitePaymentDebitComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
