import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SitePhotoCategoryComponent } from './site-photo-category.component';

describe('SitePhotoCategoryComponent', () => {
  let component: SitePhotoCategoryComponent;
  let fixture: ComponentFixture<SitePhotoCategoryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SitePhotoCategoryComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(SitePhotoCategoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
