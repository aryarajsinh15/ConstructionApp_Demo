import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PersonPaymentComponent } from './person-payment.component';

describe('PersonPaymentComponent', () => {
  let component: PersonPaymentComponent;
  let fixture: ComponentFixture<PersonPaymentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PersonPaymentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(PersonPaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
