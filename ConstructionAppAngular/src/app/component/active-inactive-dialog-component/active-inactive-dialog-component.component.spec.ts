import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ActiveInactiveDialogComponentComponent } from './active-inactive-dialog-component.component';

describe('ActiveInactiveDialogComponentComponent', () => {
  let component: ActiveInactiveDialogComponentComponent;
  let fixture: ComponentFixture<ActiveInactiveDialogComponentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ActiveInactiveDialogComponentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ActiveInactiveDialogComponentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
