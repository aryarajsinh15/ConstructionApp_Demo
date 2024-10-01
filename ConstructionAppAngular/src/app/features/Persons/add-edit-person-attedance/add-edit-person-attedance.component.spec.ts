import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditPersonAttedanceComponent } from './add-edit-person-attedance.component';

describe('AddEditPersonAttedanceComponent', () => {
  let component: AddEditPersonAttedanceComponent;
  let fixture: ComponentFixture<AddEditPersonAttedanceComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditPersonAttedanceComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditPersonAttedanceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
