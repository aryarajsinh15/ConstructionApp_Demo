import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SitePaymentComponent } from './site-payment.component';

describe('SitePaymentComponent', () => {
  let component: SitePaymentComponent;
  let fixture: ComponentFixture<SitePaymentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SitePaymentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(SitePaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
