import { LedgerService, RecordTransactionInput } from '@primecare/domain/src/services/LedgerService';
import { CurrencyService } from '@primecare/domain/src/services/CurrencyService';
import { TaxService } from '@primecare/domain/src/services/TaxService';

export class FinanceController {
  static async recordTransaction(c: any) {
    try {
      const tenantId = c.req.header('x-tenant-id');
      const payload = c.get('jwtPayload');
      const clientIp = c.req.header('CF-Connecting-IP') || '127.0.0.1';

      if (!tenantId) {
        return c.json({ error: 'Missing x-tenant-id header' }, 400);
      }

      const body = await c.req.json();

      const input: RecordTransactionInput = {
        tenantId: tenantId as string,
        type: body.type || 'PAYMENT',
        referenceId: body.referenceId,
        entries: body.entries,
        description: body.description,
        actorUserId: payload?.sub || body.actorUserId,
        ipAddress: clientIp,
        currency: body.currency,
        exchangeRate: body.exchangeRate,
        region: body.region,
        taxIncluded: body.taxIncluded
      };

      const result = await LedgerService.recordTransaction(c.get('prisma'), input);
      return result.fold(
        (data) => c.json(data, 201),
        (error) => c.json({ error }, 400)
      );
    } catch (error: any) {
      return c.json({ error: 'Invalid request body' }, 400);
    }
  }

  static async voidTransaction(c: any) {
    try {
      const tenantId = c.req.header('x-tenant-id');
      const transactionId = c.req.param('transactionId');
      const payload = c.get('jwtPayload');

      if (!tenantId) {
        return c.json({ error: 'Missing x-tenant-id header' }, 400);
      }

      if (!transactionId) {
        return c.json({ error: 'Missing transactionId parameter' }, 400);
      }

      const result = await LedgerService.voidTransaction(c.get('prisma'), transactionId, tenantId as string, payload?.sub);
      return result.fold(
        (data) => c.json(data, 200),
        (error) => c.json({ error }, 400)
      );
    } catch (error: any) {
      return c.json({ error: 'Internal Server Error' }, 500);
    }
  }

  static async getTaxReport(c: any) {
    try {
      const tenantId = c.req.header('x-tenant-id');
      if (!tenantId) {
        return c.json({ error: 'Missing x-tenant-id header' }, 400);
      }

      const { startDate, endDate } = c.req.query();
      const start = startDate ? new Date(startDate as string) : undefined;
      const end = endDate ? new Date(endDate as string) : undefined;

      const result = await LedgerService.generateTaxFilingReport(c.get('prisma'), tenantId as string, start, end);
      return result.fold(
        (data) => c.json(data, 200),
        (error) => c.json({ error }, 500)
      );
    } catch (error: any) {
      return c.json({ error: 'Internal Server Error' }, 500);
    }
  }

  static async convertCurrency(c: any) {
    try {
      const tenantId = c.req.header('x-tenant-id');
      const { amount, from } = c.req.query();

      if (!tenantId || !amount || !from) {
        return c.json({ error: 'Missing required parameters' }, 400);
      }

      const result = await CurrencyService.convertToBase(
        c.get('prisma'),
        parseFloat(amount as string),
        from as string,
        tenantId as string
      );

      return result.fold(
        (data) => c.json(data, 200),
        (error) => c.json({ error }, 400)
      );
    } catch (error: any) {
      return c.json({ error: 'Internal Server Error' }, 500);
    }
  }

  static async calculateTax(c: any) {
    try {
      const { amount, region, inclusive } = c.req.query();

      if (!amount || !region) {
        return c.json({ error: 'Missing amount or region' }, 400);
      }

      const result = await TaxService.calculateTax(
        parseFloat(amount as string),
        region as string,
        inclusive === 'true'
      );

      return result.fold(
        (data) => c.json(data, 200),
        (error) => c.json({ error }, 400)
      );
    } catch (error: any) {
      return c.json({ error: 'Internal Server Error' }, 500);
    }
  }
}
