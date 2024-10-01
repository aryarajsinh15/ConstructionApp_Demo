import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditPersonPaymentComponent } from './add-edit-person-payment.component';

describe('AddEditPersonPaymentComponent', () => {
  let component: AddEditPersonPaymentComponent;
  let fixture: ComponentFixture<AddEditPersonPaymentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditPersonPaymentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditPersonPaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
