import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PersonPaymentDebitComponent } from './person-payment-debit.component';

describe('PersonPaymentDebitComponent', () => {
  let component: PersonPaymentDebitComponent;
  let fixture: ComponentFixture<PersonPaymentDebitComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PersonPaymentDebitComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(PersonPaymentDebitComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
