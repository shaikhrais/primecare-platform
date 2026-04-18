import { describe, it, expect, vi, beforeEach } from 'vitest';
import { CurrencyService } from '../CurrencyService';
import { Decimal } from '@prisma/client/runtime/library';

const { mockPrisma } = vi.hoisted(() => {
    return {
        mockPrisma: {
            tenant: {
                findUnique: vi.fn(),
            },
        }
    };
});

vi.mock('@primecare/database', () => {
    return {
        PrismaClient: class {
            constructor() {
                return mockPrisma;
            }
        }
    };
});

describe('CurrencyService', () => {
    beforeEach(() => {
        vi.clearAllMocks();
    });

    it('should return 1.0 for same currencies', async () => {
        const rate = await CurrencyService.getExchangeRate('USD', 'USD');
        expect(rate).toBe(1.0);
    });

    it('should return correct rate for USD to CAD', async () => {
        const rate = await CurrencyService.getExchangeRate('USD', 'CAD');
        expect(rate).toBe(1.35);
    });

    it('should return correct rate for CAD to USD', async () => {
        const rate = await CurrencyService.getExchangeRate('CAD', 'USD');
        expect(rate).toBe(0.74);
    });

    it('should convert amount to base currency (CAD default)', async () => {
        mockPrisma.tenant.findUnique.mockResolvedValue({ baseCurrency: 'CAD' });

        const amount = 100;
        const result = await CurrencyService.convertToBase(amount, 'USD', 'tenant-123');

        expect(result.rate).toBe(1.35);
        expect(result.baseAmount.toNumber()).toBe(135);
        expect(result.baseCurrency).toBe('CAD');
    });

    it('should convert amount correctly for GBP based tenant', async () => {
        mockPrisma.tenant.findUnique.mockResolvedValue({ baseCurrency: 'GBP' });

        const amount = 100;
        const result = await CurrencyService.convertToBase(amount, 'CAD', 'tenant-789');

        expect(result.rate).toBe(0.58);
        expect(result.baseAmount.toNumber()).toBe(58);
        expect(result.baseCurrency).toBe('GBP');
    });
});
