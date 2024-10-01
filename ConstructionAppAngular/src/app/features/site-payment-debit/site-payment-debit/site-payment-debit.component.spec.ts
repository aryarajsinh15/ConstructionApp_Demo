import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SitePaymentDebitComponent } from './site-payment-debit.component';

describe('SitePaymentDebitComponent', () => {
  let component: SitePaymentDebitComponent;
  let fixture: ComponentFixture<SitePaymentDebitComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SitePaymentDebitComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(SitePaymentDebitComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
