import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEditSiteModalComponent } from './add-edit-site-modal.component';

describe('AddEditSiteModalComponent', () => {
  let component: AddEditSiteModalComponent;
  let fixture: ComponentFixture<AddEditSiteModalComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEditSiteModalComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddEditSiteModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
