import { describe, it, expect } from 'vitest';
import { TaxService } from '../TaxService';
import { Decimal } from '@prisma/client/runtime/library';

describe('TaxService', () => {
    it('should resolve correct rates for regions', () => {
        expect(TaxService.getRateForRegion('ON').rate).toBe(0.13);
        expect(TaxService.getRateForRegion('BC').rate).toBe(0.12);
        expect(TaxService.getRateForRegion('AB').rate).toBe(0.05);
        expect(TaxService.getRateForRegion('QC').rate).toBe(0.14975);
        expect(TaxService.getRateForRegion('UNKNOWN').rate).toBe(0.05);
    });

    describe('calculateTax - Exclusive (Tax Added)', () => {
        it('should calculate 13% tax for Ontario correctly', () => {
            const result = TaxService.calculateTax(100, 'ON', false);
            expect(result.baseAmount.toNumber()).toBe(100);
            expect(result.taxAmount.toNumber()).toBe(13);
            expect(result.totalAmount.toNumber()).toBe(113);
        });

        it('should calculate 5% tax for Alberta correctly', () => {
            const result = TaxService.calculateTax(200, 'AB', false);
            expect(result.baseAmount.toNumber()).toBe(200);
            expect(result.taxAmount.toNumber()).toBe(10);
            expect(result.totalAmount.toNumber()).toBe(210);
        });
    });

    describe('calculateTax - Inclusive (Tax Included)', () => {
        it('should calculate 13% tax split for $113 total in Ontario', () => {
            const result = TaxService.calculateTax(113, 'ON', true);
            expect(result.totalAmount.toNumber()).toBe(113);
            expect(result.baseAmount.toNumber()).toBe(100);
            expect(result.taxAmount.toNumber()).toBe(13);
        });

        it('should handle floating point amounts correctly (13% of $100 total)', () => {
            const result = TaxService.calculateTax(100, 'ON', true);
            // 100 / 1.13 = 88.495575... -> 88.50
            // Tax = 100 - 88.50 = 11.50
            expect(result.baseAmount.toNumber()).toBe(88.50);
            expect(result.taxAmount.toNumber()).toBe(11.50);
            expect(result.totalAmount.toNumber()).toBe(100);
        });
    });
});
