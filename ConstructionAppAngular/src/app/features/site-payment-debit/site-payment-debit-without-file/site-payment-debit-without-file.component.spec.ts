import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SitePaymentDebitWithoutFileComponent } from './site-payment-debit-without-file.component';

describe('SitePaymentDebitWithoutFileComponent', () => {
  let component: SitePaymentDebitWithoutFileComponent;
  let fixture: ComponentFixture<SitePaymentDebitWithoutFileComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SitePaymentDebitWithoutFileComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(SitePaymentDebitWithoutFileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
