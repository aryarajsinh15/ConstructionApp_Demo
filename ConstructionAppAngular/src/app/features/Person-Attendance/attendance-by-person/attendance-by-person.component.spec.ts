import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AttendanceByPersonComponent } from './attendance-by-person.component';

describe('AttendanceByPersonComponent', () => {
  let component: AttendanceByPersonComponent;
  let fixture: ComponentFixture<AttendanceByPersonComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AttendanceByPersonComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AttendanceByPersonComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
