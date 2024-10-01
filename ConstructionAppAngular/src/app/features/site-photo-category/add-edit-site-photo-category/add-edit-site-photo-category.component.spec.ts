import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditSitePhotoCategoryComponent } from './add-edit-site-photo-category.component';

describe('AddEditSitePhotoCategoryComponent', () => {
  let component: AddEditSitePhotoCategoryComponent;
  let fixture: ComponentFixture<AddEditSitePhotoCategoryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditSitePhotoCategoryComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditSitePhotoCategoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
