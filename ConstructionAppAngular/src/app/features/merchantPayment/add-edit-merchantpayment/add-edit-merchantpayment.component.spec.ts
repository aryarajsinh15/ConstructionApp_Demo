import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditMerchantpaymentComponent } from './add-edit-merchantpayment.component';

describe('AddEditMerchantpaymentComponent', () => {
  let component: AddEditMerchantpaymentComponent;
  let fixture: ComponentFixture<AddEditMerchantpaymentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditMerchantpaymentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditMerchantpaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
