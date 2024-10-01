import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditPersonAttendanceComponent } from './add-edit-person-attendance.component';

describe('AddEditPersonAttendanceComponent', () => {
  let component: AddEditPersonAttendanceComponent;
  let fixture: ComponentFixture<AddEditPersonAttendanceComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditPersonAttendanceComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditPersonAttendanceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
