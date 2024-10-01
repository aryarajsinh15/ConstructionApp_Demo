import { Component } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ApiUrlHelper } from 'app/api-url/api-url-helper';
import { LanguageService } from 'app/services/language/language.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import { CommonService } from 'app/services/common/common.service';
import { TranslateService } from '@ngx-translate/core';

@Component({
  selector: 'vex-add-edit-estimate-bill-payment',
  templateUrl: './add-edit-estimate-bill-payment.component.html',
  styleUrl: './add-edit-estimate-bill-payment.component.scss'
})
export class AddEditEstimateBillPaymentComponent {

  billForm: FormGroup;
  rate: number = 2
  estimateId: any;
  editedEstimateBillDetails: any;
  submitted: boolean = false;

  constructor(private fb: FormBuilder, private router: Router,
    private apiUrl: ApiUrlHelper,
    private commonService: CommonService,
    private toastr: ToastrService,
    private spinner: NgxSpinnerService,
    private languageService: LanguageService,
    private route: ActivatedRoute,
    private translate: TranslateService) { }

  ngOnInit(): void {
    this.billForm = this.fb.group({
      estimatebillDate: ['', Validators.required],
      // estimatebillNumber: ['', Validators.required],
      remarks: [''],
      partyName: ['', Validators.required],
      items: this.fb.array([this.createItemDetail()])
    });
    const encodedObj = this.route.snapshot.paramMap.get('id');
    if (this.route.snapshot.paramMap.has('id')) {
      const objJsonString = atob(encodedObj);
      const parsedMerchantObj = JSON.parse(objJsonString);
      this.estimateId = parsedMerchantObj;
    }
    this.languageService.currentLanguage$.subscribe(language => {
      this.translate.use(language);
    });
    if (this.estimateId && this.estimateId != null && this.estimateId != undefined) {
      this.getEstimateBillDetails();
    }
  }

  items(): FormArray {
    return this.billForm.get('items') as FormArray;
  }

  getItemAtIndex(index: number): FormGroup {
    return this.items().at(index) as FormGroup;
  }

  getItemDetails(index: number): FormArray {
    return this.getItemAtIndex(index).get('itemDetail') as FormArray
  }

  createItem(withDescription: boolean = true): FormGroup {
    return this.fb.group({
      billEstimateItemId: [null],
      itemDetail: this.fb.array([this.createItemDetail()]),
    });
  }

  createItemWithoutParam() {
    return this.fb.group({
      billEstimateItemId: [null],
      itemDetail: this.fb.array([this.createItemDetail()])
    });
  }

  createItemDetail() {
    return this.fb.group({
      billEstimateItemId: [null],
      name: ['', Validators.required],
      nos: ['', Validators.required],
      rate: ['', Validators.required],
      quantity: ['', Validators.required],
    });
  }

  addItemDescription(index): void {
    this.items().push(this.createItemDetail())
  }

  removeItemDetail(itemIndex) {
    this.items().removeAt(itemIndex);
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

  getTotal(): number {
    let total = 0;
    for (let index = 0; index < this.items().length; index++) {
      total += (this.getItemAtIndex(index).get('rate').value ? Number(this.getItemAtIndex(index).get('rate').value) : 0 ) *
      ( this.getItemAtIndex(index).get('nos').value ? Number(this.getItemAtIndex(index).get('nos').value) : 0 ) *
      ( this.getItemAtIndex(index).get('quantity').value ? Number(this.getItemAtIndex(index).get('quantity').value) : 0 )
    }
    return total;
  }

  onSubmit(): void {
    this.submitted = true;
    if(this.billForm.invalid){
      return;
    }
    var obj = {
      estimateId: this.estimateId,
      estimatebillDate: this.formatDate(this.billForm.value.estimatebillDate, "12:00 AM"),
      partyName: this.billForm.value.partyName,
      remarks: this.billForm.value.remarks ? this.billForm.value.remarks : '',
      finalTotal: this.getTotal(),
      ItemsDetails: []
    }
    let item = [];
    for (let index = 0; index < this.items().length; index++) {

      let itemDetailObj = {
        billEstimateItemId : this.getItemAtIndex(index).value.billEstimateItemId ? this.getItemAtIndex(index).value.billEstimateItemId : '',
        name: this.getItemAtIndex(index).value.name ? this.getItemAtIndex(index).value.name : '',
        nos: this.getItemAtIndex(index).value.nos ? this.getItemAtIndex(index).value.nos : '',
        quantity: this.getItemAtIndex(index).value.quantity ? Number(this.getItemAtIndex(index).value.quantity) : 0,
        rate: this.getItemAtIndex(index).value.rate ? Number(this.getItemAtIndex(index).value.rate) : 0,
        total: this.getItemAtIndex(index).value.nos * this.getItemAtIndex(index).value.rate * this.getItemAtIndex(index).value.quantity
      }
      item.push(itemDetailObj);

    }
    obj.ItemsDetails = item;
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.Estimate.SaveEstimateBillWithOutFile;
    this.commonService.doPost(apiUrl, obj).pipe().subscribe({
      next: (response) => {
        if (response.success) {
          this.spinner.hide();
          this.toastr.success(response.message);
          this.router.navigate(['estimate']);
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

  backToEstimate() {
    this.router.navigate(['estimate']);
  }

  total(index: any) {
    let rate = this.getItemAtIndex(index).get('rate').value;
    let nos = this.getItemAtIndex(index).get('nos').value;
    let quantity = this.getItemAtIndex(index).get('quantity').value;
    let total = (rate && rate > 0 ? rate : 0) * (nos && nos > 0 ? nos : 0) * (quantity && quantity > 0 ? quantity : 0)
    return total;
  }

  getEstimateBillDetails() {
    this.spinner.show();
    const apiUrl = this.apiUrl.apiUrl.Estimate.GetSiteBillDetails.replace('{estimateBillId}', this.estimateId);
    this.commonService.doGet(apiUrl).pipe().subscribe({
      next: (response) => {
        this.editedEstimateBillDetails = response.data;
        this.billForm.patchValue({
          estimateId: this.estimateId,
          estimatebillDate: this.editedEstimateBillDetails.estimateBillDate,
          estimatebillNumber: this.editedEstimateBillDetails.estimateBillDate,
          remarks: this.editedEstimateBillDetails.remarks,
          partyName: this.editedEstimateBillDetails.partyName
        });
        while (this.items().controls.length !== 0) {
          this.items().controls.splice(0, 1);
        }
        this.editedEstimateBillDetails.itemsDetails.forEach(item => {
          const itemDetailsArray = this.items() as FormArray;
          // while (itemDetailsArray.length !== 0) {
          //   itemDetailsArray.removeAt(0);
          // }
          const newItemDetail = this.createItemDetail();
          newItemDetail.patchValue({
            billEstimateItemId: item.billEstimateItemId,
            name: item.name,
            nos: item.nos,
            quantity: item.quantity,
            rate: item.rate,
          });
          this.items().push(newItemDetail);
        });
        this.spinner.hide();
      },
      error: (err) => {
        this.spinner.hide();
        console.log(err);
      }
    });
  }
}