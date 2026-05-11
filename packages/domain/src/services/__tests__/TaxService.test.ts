import { describe, it, expect } from 'vitest';
import { TaxService } from '../TaxService';
import { Prisma } from '@primecare/database';

describe('TaxService', () => {
    it('should resolve correct rates for regions', async () => {
        expect((await TaxService.getRateForRegion('ON')).data.rate).toBe(0.13);
        expect((await TaxService.getRateForRegion('BC')).data.rate).toBe(0.12);
        expect((await TaxService.getRateForRegion('AB')).data.rate).toBe(0.05);
        expect((await TaxService.getRateForRegion('QC')).data.rate).toBe(0.14975);
        expect((await TaxService.getRateForRegion('UNKNOWN')).data.rate).toBe(0.05);
    });

    describe('calculateTax - Exclusive (Tax Added)', () => {
        it('should calculate 13% tax for Ontario correctly', async () => {
            const result = await TaxService.calculateTax(100, 'ON', false);
            expect(result.data.baseAmount.toNumber()).toBe(100);
            expect(result.data.taxAmount.toNumber()).toBe(13);
            expect(result.data.totalAmount.toNumber()).toBe(113);
        });

        it('should calculate 5% tax for Alberta correctly', async () => {
            const result = await TaxService.calculateTax(200, 'AB', false);
            expect(result.data.baseAmount.toNumber()).toBe(200);
            expect(result.data.taxAmount.toNumber()).toBe(10);
            expect(result.data.totalAmount.toNumber()).toBe(210);
        });
    });

    describe('calculateTax - Inclusive (Tax Included)', () => {
        it('should calculate 13% tax split for $113 total in Ontario', async () => {
            const result = await TaxService.calculateTax(113, 'ON', true);
            expect(result.data.totalAmount.toNumber()).toBe(113);
            expect(result.data.baseAmount.toNumber()).toBe(100);
            expect(result.data.taxAmount.toNumber()).toBe(13);
        });

        it('should handle floating point amounts correctly (13% of $100 total)', async () => {
            const result = await TaxService.calculateTax(100, 'ON', true);
            // 100 / 1.13 = 88.495575... -> 88.50
            // Tax = 100 - 88.50 = 11.50
            expect(result.data.baseAmount.toNumber()).toBe(88.50);
            expect(result.data.taxAmount.toNumber()).toBe(11.50);
            expect(result.data.totalAmount.toNumber()).toBe(100);
        });
    });
});
