import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
    name: 'CustomCurrency'
})
export class CurrencyFormat implements PipeTransform {
    transform(value: number): string {
        if (value == null) {
            return '';
        }

        // Handle negative values
        const sign = value < 0 ? '-' : '';
        value = Math.abs(value);

        // Use Intl.NumberFormat for locale-aware formatting
        const formatter = new Intl.NumberFormat('en-IN', {
            minimumFractionDigits: 0, // Adjust as needed
            maximumFractionDigits: 0  // Adjust as needed
        });

        const formattedValue = formatter.format(value);

        // Split into integer and fractional parts (optional for decimal places)
        // const parts = formattedValue.split('.');

        return `${sign}${formattedValue}`;
    }
}