import { describe, it, expect, vi, beforeEach } from 'vitest';
import { CurrencyService } from '../CurrencyService';
import { Prisma } from '@primecare/database';

const { mockPrisma } = vi.hoisted(() => {
    return {
        mockPrisma: {
            tenant: {
                findUnique: vi.fn(),
            },
        }
    };
});

vi.mock('@primecare/database', async (importOriginal) => {
    const actual: any = await importOriginal();
    return {
        ...actual,
        PrismaClient: class {
            constructor() {
                return mockPrisma;
            }
        },
        prisma: mockPrisma
    };
});

describe('CurrencyService', () => {
    beforeEach(() => {
        vi.clearAllMocks();
    });

    it('should return 1.0 for same currencies', async () => {
        const result = await CurrencyService.getExchangeRate('USD', 'USD');
        expect(result.data).toBe(1.0);
    });

    it('should return correct rate for USD to CAD', async () => {
        const result = await CurrencyService.getExchangeRate('USD', 'CAD');
        expect(result.data).toBe(1.35);
    });

    it('should return correct rate for CAD to USD', async () => {
        const result = await CurrencyService.getExchangeRate('CAD', 'USD');
        expect(result.data).toBe(0.74);
    });

    it('should convert amount to base currency (CAD default)', async () => {
        mockPrisma.tenant.findUnique.mockResolvedValue({ baseCurrency: 'CAD' });

        const amount = 100;
        const result = await CurrencyService.convertToBase(mockPrisma as any, amount, 'USD', 'tenant-123');

        expect(result.data.rate).toBe(1.35);
        expect(result.data.baseAmount.toNumber()).toBe(135);
        expect(result.data.baseCurrency).toBe('CAD');
    });

    it('should convert amount correctly for GBP based tenant', async () => {
        mockPrisma.tenant.findUnique.mockResolvedValue({ baseCurrency: 'GBP' });

        const amount = 100;
        const result = await CurrencyService.convertToBase(mockPrisma as any, amount, 'CAD', 'tenant-789');

        expect(result.data.rate).toBe(0.58);
        expect(result.data.baseAmount.toNumber()).toBe(58);
        expect(result.data.baseCurrency).toBe('GBP');
    });
});
