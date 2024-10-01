import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditEstimateBillPaymentComponent } from './add-edit-estimate-bill-payment.component';

describe('AddEditEstimateBillPaymentComponent', () => {
  let component: AddEditEstimateBillPaymentComponent;
  let fixture: ComponentFixture<AddEditEstimateBillPaymentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditEstimateBillPaymentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditEstimateBillPaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
