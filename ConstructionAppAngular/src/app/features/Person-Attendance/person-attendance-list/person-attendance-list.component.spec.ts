import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PersonAttendanceListComponent } from './person-attendance-list.component';

describe('PersonAttendanceListComponent', () => {
  let component: PersonAttendanceListComponent;
  let fixture: ComponentFixture<PersonAttendanceListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PersonAttendanceListComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(PersonAttendanceListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
