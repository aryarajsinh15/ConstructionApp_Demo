import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditVehicleRentComponent } from './add-edit-vehicle-rent.component';

describe('AddEditVehicleRentComponent', () => {
  let component: AddEditVehicleRentComponent;
  let fixture: ComponentFixture<AddEditVehicleRentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditVehicleRentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditVehicleRentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
