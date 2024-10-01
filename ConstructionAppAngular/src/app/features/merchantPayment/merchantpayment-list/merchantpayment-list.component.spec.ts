import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MerchantpaymentListComponent } from './merchantpayment-list.component';

describe('MerchantpaymentListComponent', () => {
  let component: MerchantpaymentListComponent;
  let fixture: ComponentFixture<MerchantpaymentListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MerchantpaymentListComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(MerchantpaymentListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
