import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditVehicleOwnerComponent } from './add-edit-vehicle-owner.component';

describe('AddEditVehicleOwnerComponent', () => {
  let component: AddEditVehicleOwnerComponent;
  let fixture: ComponentFixture<AddEditVehicleOwnerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditVehicleOwnerComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditVehicleOwnerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
