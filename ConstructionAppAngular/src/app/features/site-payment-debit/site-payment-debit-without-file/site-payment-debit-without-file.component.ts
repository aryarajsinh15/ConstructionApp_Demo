import { Component } from '@angular/core';
import { AbstractControl, FormArray, FormBuilder, FormControl, FormGroup, ValidationErrors, ValidatorFn, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { CommonService } from 'app/services/common/common.service';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'vex-site-payment-debit-without-file',
  templateUrl: './site-payment-debit-without-file.component.html',
  styleUrls: ['./site-payment-debit-without-file.component.scss']
})
export class SitePaymentDebitWithoutFileComponent {

  billForm: FormGroup;
  submitted: boolean = false;
  siteObj: any
  parseSiteObj: any
  siteId: any;
  siteName: any;
  billId: any;
  billType: any = [];
  checkItemName: FormArray<any> | undefined;
  editedSiteBillDetails: any;

  constructor(private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private commonService: CommonService,
    private apiUrl: ApiUrlHelper,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService,
    private languageService: LanguageService,
    private translate: TranslateService) { }

  ngOnInit(): void {
    this.billForm = this.fb.group({
      billId: [null],
      billDate: ['', Validators.required],
      billNumber: ['', Validators.required],
      remarks: ['', Validators.required],
      items: this.fb.array([this.createItem()])
    });
    // this.siteObj = atob((this.route.snapshot.paramMap.get('siteid')));
    // this.parseSiteObj = JSON.parse(this.siteObj)
    // this.siteId = this.parseSiteObj.siteId;
    // this.billId = this.parseSiteObj.billId;
    // this.siteName = this.parseSiteObj.siteName;
    const encodedSiteObj = this.route.snapshot.paramMap.get('siteid');
    const siteObjJsonString = atob(encodedSiteObj);
    const parsedSiteObj = JSON.parse(siteObjJsonString);
    this.siteId = parsedSiteObj.siteId;
    this.billId = parsedSiteObj.billId;
    const encodedSiteName = parsedSiteObj.siteName;
    this.siteName = decodeURIComponent(encodedSiteName);

    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    this.billType = [
      {
        billTypeId: "CFT(+)",
        billTypeName: "CFT(+)"
      },
      {
        billTypeId: "CFT(-)",
        billTypeName: "CFT(-)"
      },
      {
        billTypeId: "SFT(+)",
        billTypeName: "SFT(+)"
      },
      {
        billTypeId: "SFT(-)",
        billTypeName: "SFT(-)"
      },
      {
        billTypeId: "RFT(+)",
        billTypeName: "RFT(+)"
      },
      {
        billTypeId: "RFT(-)",
        billTypeName: "RFT(-)"
      },
      {
        billTypeId: "NOS(+)",
        billTypeName: "NOS(+)"
      },
      {
        billTypeId: "NOS(-)",
        billTypeName: "NOS(-)"
      },
    ];
    if (this.billId && this.billId != null && this.billId != undefined) {
      this.getBillDetails();
    }
  }

  get items(): FormArray {
    return this.billForm.get('items') as FormArray;
  }

  getItemAtIndex(index: number): FormGroup {
    return this.items.at(index) as FormGroup;
  }

  getItemDetails(index: number): FormArray {
    return this.getItemAtIndex(index).get('itemDetail') as FormArray;
  }

  createItem(withDescription: boolean = true): FormGroup {
    return this.fb.group({
      billSiteItemId: [null],
      itemDetail: this.fb.array([this.createItemDetail()]),
      description: withDescription ? ['', Validators.required] : null,
      rate: ['', Validators.required]
    });
  }

  createItemWithoutParam() {
    return this.fb.group({
      billSiteItemId: [null],
      description: ['', Validators.required],
      itemDetail: this.fb.array([this.createItemDetail()]),
      rate: ['', Validators.required]
    });
  }

  createItemDetail() {
    return this.fb.group({
      billSiteItemId: [null],
      name: ['', Validators.required],
      type: ['', Validators.required],
      quantity: ['', Validators.required],
      length: ['', Validators.required],
      height: ['', Validators.required],
      width: ['', Validators.required]
    });
  }

  addItem(): void {
    const newItem = this.createItemWithoutParam();
    this.items.push(newItem);
  }

  addItemDescription(index: number): void {
    this.getItemDetails(index).push(this.createItemDetail());
  }

  removeItemDetail(itemIndex: number, itemDetailIndex: number): void {
    this.getItemDetails(itemIndex).removeAt(itemDetailIndex);
  }

  getItemArea(itemIndex: number, itemDetailIndex: number): number {
    let formValue = this.getItemDetails(itemIndex).at(itemDetailIndex).value;
    this.getAllValueEnable(itemIndex, itemDetailIndex)
    if (formValue.type == 'RFT(+)' || formValue.type == 'RFT(-)' || formValue.type == 'NOS(+)' || formValue.type == 'NOS(-)') {
      this.getItemDetails(itemIndex).at(itemDetailIndex).patchValue({
        width: '',
        height: ''
      });
      this.getItemDetails(itemIndex).at(itemDetailIndex).get('width').disable();
      this.getItemDetails(itemIndex).at(itemDetailIndex).get('width').clearValidators();
      this.getItemDetails(itemIndex).at(itemDetailIndex).get('height').disable();
      this.getItemDetails(itemIndex).at(itemDetailIndex).get('height').clearValidators();
      this.getItemDetails(itemIndex).at(itemDetailIndex).updateValueAndValidity();
      if (formValue.quantity === '' || formValue.length === '') {
        return 0;
      } else {
        return formValue.quantity * formValue.length
      }
    }
    else if (formValue.type == 'SFT(+)' || formValue.type == 'SFT(-)') {
      this.getItemDetails(itemIndex).at(itemDetailIndex).patchValue({
        height: ''
      });
      this.getItemDetails(itemIndex).at(itemDetailIndex).get('height').disable();
      this.getItemDetails(itemIndex).at(itemDetailIndex).get('height').clearValidators();
      this.getItemDetails(itemIndex).at(itemDetailIndex).updateValueAndValidity();
      if (formValue.quantity === '' || formValue.length === '' || formValue.width === '') {
        return 0;
      } else {
        return formValue.quantity * formValue.length * formValue.width
      }
    }
    else {
      this.getItemDetails(itemIndex).at(itemDetailIndex).updateValueAndValidity();
      if (formValue.quantity === '' || formValue.length === '' || formValue.width === '' || formValue.height === '') {
        return 0;
      } else {
        return formValue.quantity * formValue.length * formValue.width * formValue.height;
      }
    }
  }

  getAllValueEnable(itemIndex: number, itemDetailIndex: number) {
    this.getItemDetails(itemIndex).at(itemDetailIndex).get('height').enable();
    this.getItemDetails(itemIndex).at(itemDetailIndex).get('height').addValidators([Validators.required]);
    this.getItemDetails(itemIndex).at(itemDetailIndex).get('width').enable();
    this.getItemDetails(itemIndex).at(itemDetailIndex).get('width').addValidators([Validators.required]);
  }

  getItemAreaTotal(itemIndex: number): number {
    var total = 0;
    for (let index = 0; index < this.getItemDetails(itemIndex).length; index++) {
      const detail = this.getItemDetails(itemIndex).at(index).value;
      if (detail.type.includes('(+)')) {
        total += this.getItemArea(itemIndex, index);
      }
      else if (detail.type.includes('(-)')) {
        total -= this.getItemArea(itemIndex, index);
      }
    }
    return total;
  }

  getTotal(index: number): number {
    const rate = this.getItemAtIndex(index).get('rate').value || 0;
    return this.getItemAreaTotal(index) * rate;
  }

  getFinalTotal(): number {
    let finalTotal = 0;
    for (let index = 0; index < this.items.length; index++) {
      finalTotal += this.getTotal(index);
    }
    return finalTotal;
  }

  formatDate(dateString: string, timeString: string): string {
    const date = new Date(dateString);
    const timeParts = timeString.split(":");
    let hours = parseInt(timeParts[0]);
    const minutes = parseInt(timeParts[1].split(" ")[0]);
    const meridian = timeParts[1].split(" ")[1];
    if (meridian === "PM" && hours !== 12) {
      hours += 12;
    } else if (meridian === "AM" && hours === 12) {
      hours = 0;
    }
    date.setHours(hours, minutes);
    const localDate = new Date(date.getTime() - (date.getTimezoneOffset() * 60000));
    return localDate.toISOString();
  }

  onSubmit(): void {
    this.submitted = true;
    if (this.billForm.invalid) {
      return;
    }
    if (this.checkSameItemNameFunction()) {
      return;
    }
    if (this.checkSameDescription()) {
      return;
    }

    this.spinner.show();
    var obj = {
      billPaymentId: this.billId,
      siteId: this.siteId,
      billDate: this.formatDate(this.billForm.value.billDate, "12:00 AM"),
      billNumber: this.billForm.value.billNumber,
      remarks: this.billForm.value.remarks,
      items: []
    };
    let item = [];
    for (let index = 0; index < this.items.length; index++) {
      let itemObj = {
        billSiteItemId: this.getItemAtIndex(index).value.billSiteItemId,
        description: this.getItemAtIndex(index).value.description,
        rate: this.getItemAtIndex(index).value.rate,
        itemDetail: []
      };
      let itemDetails = [];
      for (let itemDetailIndex = 0; itemDetailIndex < this.getItemDetails(index).length; itemDetailIndex++) {
        let itemDetailObj = {
          billSiteItemId: this.getItemDetails(index).at(itemDetailIndex).value.billSiteItemId,
          name: this.getItemDetails(index).at(itemDetailIndex).value.name ? this.getItemDetails(index).at(itemDetailIndex).value.name : '',
          type: this.getItemDetails(index).at(itemDetailIndex).value.type ? this.getItemDetails(index).at(itemDetailIndex).value.type : '',
          quantity: this.getItemDetails(index).at(itemDetailIndex).value.quantity ? Number(this.getItemDetails(index).at(itemDetailIndex).value.quantity) : null,
          length: this.getItemDetails(index).at(itemDetailIndex).value.length ? Number(this.getItemDetails(index).at(itemDetailIndex).value.length) : null,
          height: this.getItemDetails(index).at(itemDetailIndex).value.height ? Number(this.getItemDetails(index).at(itemDetailIndex).value.height) : null,
          width: this.getItemDetails(index).at(itemDetailIndex).value.width ? Number(this.getItemDetails(index).at(itemDetailIndex).value.width) : null,
          itemDetailTotal: this.getItemArea(index, itemDetailIndex) ? Number(this.getItemArea(index, itemDetailIndex)) : 0
        };
        itemDetails.push(itemDetailObj);
      }
      itemObj.itemDetail = itemDetails;
      item.push(itemObj);
    }
    obj.items = item;
    const apiUrl = this.apiUrl.apiUrl.SitePaymentDebit.SaveSiteBillWithOutFile;
    this.commonService.doPost(apiUrl, obj).pipe().subscribe({
      next: (response) => {
        if (response.success) {
          this.spinner.hide();
          this.toastr.success(response.message);
          this.redirectToSiteBillPayment(this.siteId, this.siteName);
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

  deleteRow(index: number) {
    this.items.removeAt(index);
  }

  isSingleRow(): boolean {
    return this.items.length === 1;
  }

  redirectToSiteBillPayment(siteId: any, siteName: any) {
    // var obj = {
    //   siteId: siteId,
    //   siteName: siteName
    // }
    var encodedSiteName = encodeURIComponent(siteName);
    var objWithEncodedName = {
      siteId: siteId,
      siteName: encodedSiteName
    };
    var encryptedObj = btoa(JSON.stringify(objWithEncodedName))
    this.router.navigate(['bill-payment', encryptedObj]);
  }

  hasDuplicates(array: any[]): boolean {
    return new Set(array).size !== array.length;
  }

  checkSameItemNameFunction(): boolean {
    let hasDuplicateInSameGroup = false;
    this.items.controls.forEach((item: FormGroup) => {
      const itemNames: string[] = [];
      const itemDetails = item.get('itemDetail') as FormArray;
      itemDetails.controls.forEach((detail: FormGroup) => {
        const name = detail.get('name').value;
        if (name && name.trim()) {
          itemNames.push(name.trim());
        }
      });
      if (this.hasDuplicates(itemNames)) {
        hasDuplicateInSameGroup = true;
        this.toastr.error('Duplicate item names found.');
      }
    });

    return hasDuplicateInSameGroup;
  }

  checkSameDescription(): boolean {
    const descriptions: string[] = this.items.controls.map((item: FormGroup) => {
      const description = item.get('description').value;
      return description ? description.trim() : '';
    });
    if (this.hasDuplicates(descriptions)) {
      this.toastr.error('Duplicate descriptions found.');
      return true;
    }
    return false;
  }

  getBillDetails() {
    const apiUrl = this.apiUrl.apiUrl.SitePaymentDebit.GetSiteBillDetails.replace('{billId}', this.billId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedSiteBillDetails = response.data;
        this.billForm.patchValue({
          billId: this.billId,
          siteId: this.siteId,
          billDate: this.editedSiteBillDetails.billDate,
          billNumber: this.editedSiteBillDetails.billNo,
          remarks: this.editedSiteBillDetails.remarks
        });
        while (this.items.length !== 0) {
          this.items.removeAt(0);
        }
        this.editedSiteBillDetails.items.forEach(item => {
          const newItem = this.createItem(true);
          newItem.patchValue({
            billSiteItemId: item.billSiteItemId,
            description: item.description,
            rate: item.rate
          });
          const itemDetailsArray = newItem.get('itemDetail') as FormArray;
          while (itemDetailsArray.length !== 0) {
            itemDetailsArray.removeAt(0);
          }
          item.itemDetails.forEach(itemDetail => {
            const newItemDetail = this.createItemDetail();
            newItemDetail.patchValue({
              billSiteItemId: itemDetail.billSiteItemId,
              name: itemDetail.itemName,
              type: itemDetail.type,
              quantity: itemDetail.quantity,
              length: itemDetail.length,
              height: itemDetail.height,
              width: itemDetail.width
            });
            itemDetailsArray.push(newItemDetail);
          });
          this.items.push(newItem);
        });
      },
      error: (err) => {
        console.log(err);
      }
    });
  }
}
