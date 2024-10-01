import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PersonGroupListComponent } from './person-group-list.component';

describe('PersonGroupListComponent', () => {
  let component: PersonGroupListComponent;
  let fixture: ComponentFixture<PersonGroupListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PersonGroupListComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(PersonGroupListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
