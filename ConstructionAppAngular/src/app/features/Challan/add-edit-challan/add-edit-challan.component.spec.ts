import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditChallanComponent } from './add-edit-challan.component';

describe('AddEditChallanComponent', () => {
  let component: AddEditChallanComponent;
  let fixture: ComponentFixture<AddEditChallanComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditChallanComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditChallanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
