import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditPaymentDebitComponent } from './add-edit-payment-debit.component';

describe('AddEditPaymentDebitComponent', () => {
  let component: AddEditPaymentDebitComponent;
  let fixture: ComponentFixture<AddEditPaymentDebitComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditPaymentDebitComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditPaymentDebitComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
