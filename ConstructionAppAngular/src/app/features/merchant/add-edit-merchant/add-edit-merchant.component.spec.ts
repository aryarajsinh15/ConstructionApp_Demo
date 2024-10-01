import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditMerchantComponent } from './add-edit-merchant.component';

describe('AddEditMerchantComponent', () => {
  let component: AddEditMerchantComponent;
  let fixture: ComponentFixture<AddEditMerchantComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditMerchantComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditMerchantComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
