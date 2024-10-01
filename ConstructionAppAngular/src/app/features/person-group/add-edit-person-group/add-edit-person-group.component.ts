import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-add-edit-person-group',
  templateUrl: './add-edit-person-group.component.html',
  styleUrl: './add-edit-person-group.component.scss'
})
export class AddEditPersonGroupComponent {

  // Fields
  addEditGroupForm: FormGroup;
  submitted : boolean = false;
  groupId : string = "";
  name : string ;
  editedGroupDetails : any = {};
  personList : any[] = [];

  // Constructor
  constructor(
    private dialogRef: MatDialogRef<AddEditPersonGroupComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commonService: CommonService,
    private fb: FormBuilder,
    private apiUrl: ApiUrlHelper,
    private translate: TranslateService,
    private languageService: LanguageService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService) {
      this.groupId = data.groupId;
      this.name = data.name;
    }

  // Init
  ngOnInit(): void {
    this.getPersonListForDropDown();
    this.addEditGroupForm = this.fb.group({
      groupName: [this.name, Validators.required],
      persons : [[], Validators.required]
    });

    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
  }

  // Save Group
  submitGroupForm() {
    this.submitted = true;
    if (this.addEditGroupForm.invalid) {
      return;
    }
    this.spinner.show();
    let groupMap = []
    this.addEditGroupForm.value.persons.forEach(element => {
      let groupData = {
        PersonGroupMapId : '',
        PersonId : element,
        PersonGroupId : this.groupId ? this.groupId : ''
      }
      groupMap.push(groupData);
    }); 
    let obj = {
      personGroupId : this.groupId ? this.groupId : '',
      groupName : this.addEditGroupForm.value.groupName?.trim(),
      groupMap : groupMap
    }
    const apiUrl = this.apiUrl.apiUrl.PersonGroup.SavePersonGroup;
    this.commonService.doPost(apiUrl, obj).pipe().subscribe({
      next: (response) => {
        if (response.success) {
          this.spinner.hide();
          this.toastr.success(response.message);
          this.dialogRef.close(true);
        } else {
          this.spinner.hide();
          this.toastr.error(response.message);
        }
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  // Get Person List For Drop Down
  getPersonListForDropDown(){
    const apiUrl = this.apiUrl.apiUrl.Persons.GetPerosnlistForDropDown;
    this.commonService.doGet(apiUrl.replace("{id}", this.groupId)).pipe().subscribe({
      next: (response) => {
        if (response.data != null) {
          this.personList = response.data;
        }
        if (this.groupId && this.groupId != null && this.groupId != undefined) {
          const filteredPersons = this.personList.filter(x => x.usageStatus === 1);
          const personIds = filteredPersons.map(person => person.personId);

          this.addEditGroupForm.patchValue({
            gruopName : this.name,
            persons : personIds
          });
        }
        this.spinner.hide();
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }

  // Close add edit model
  cancel() {
    this.dialogRef.close();
  }
}