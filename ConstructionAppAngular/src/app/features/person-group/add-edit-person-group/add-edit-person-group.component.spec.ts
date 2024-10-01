import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditPersonGroupComponent } from './add-edit-person-group.component';

describe('AddEditPersonGroupComponent', () => {
  let component: AddEditPersonGroupComponent;
  let fixture: ComponentFixture<AddEditPersonGroupComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditPersonGroupComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditPersonGroupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
