import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UplaodPhotoGalleryComponent } from './uplaod-photo-gallery.component';

describe('UplaodPhotoGalleryComponent', () => {
  let component: UplaodPhotoGalleryComponent;
  let fixture: ComponentFixture<UplaodPhotoGalleryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [UplaodPhotoGalleryComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(UplaodPhotoGalleryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
