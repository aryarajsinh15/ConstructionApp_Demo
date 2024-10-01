import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PersonAttedanceComponent } from './person-attedance.component';

describe('PersonAttedanceComponent', () => {
  let component: PersonAttedanceComponent;
  let fixture: ComponentFixture<PersonAttedanceComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PersonAttedanceComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(PersonAttedanceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
