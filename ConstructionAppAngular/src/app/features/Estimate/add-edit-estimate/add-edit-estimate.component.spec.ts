import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditEstimateComponent } from './add-edit-estimate.component';

describe('AddEditEstimateComponent', () => {
  let component: AddEditEstimateComponent;
  let fixture: ComponentFixture<AddEditEstimateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditEstimateComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditEstimateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
