import { ClinicalService } from '@primecare/domain/src/services/ClinicalService';

export class ClinicalController {
  static async captureVitals(c: any) {
    const tenantId = c.req.header('x-tenant-id');
    if (!tenantId) {
      return c.json({ error: 'Missing x-tenant-id header' }, 400);
    }

    try {
      const body = await c.req.json();
      const result = await ClinicalService.captureVitals(c.get('prisma'), {
        ...body,
        tenantId,
        actorUserId: (c.get('user') as any)?.id || 'SYSTEM'
      });

      return result.fold(
        (data) => c.json(data, 201),
        (error) => c.json({ error }, 400)
      );
    } catch (e: any) {
      return c.json({ error: 'Invalid request body' }, 400);
    }
  }

  static async processPatientIntake(c: any) {
    const tenantId = c.req.header('x-tenant-id');
    if (!tenantId) {
      return c.json({ error: 'Missing x-tenant-id header' }, 400);
    }

    try {
      const body = await c.req.json();
      const result = await ClinicalService.processPatientIntake(c.get('prisma'), {
        ...body,
        tenantId,
        actorUserId: (c.get('user') as any)?.id || 'SYSTEM'
      });

      return result.fold(
        (data) => c.json(data, 201),
        (error) => c.json({ error }, 400)
      );
    } catch (e: any) {
      return c.json({ error: 'Invalid request body' }, 400);
    }
  }

  static async checkEmail(c: any) {
    const tenantId = c.req.header('x-tenant-id');
    const email = c.req.query('email');
    if (!tenantId || !email) {
      return c.json({ error: 'Missing x-tenant-id header or email query param' }, 400);
    }

    const result = await ClinicalService.checkPatientEmail(c.get('prisma'), tenantId, email);

    return result.fold(
      (data) => c.json(data),
      (error) => c.json({ error }, 400)
    );
  }

  static async getQ3Extrapolations(c: any) {
    const tenantId = c.req.header('x-tenant-id');
    if (!tenantId) {
      return c.json({ error: 'Missing x-tenant-id header' }, 400);
    }

    const result = await ClinicalService.getQ3FinancialExtrapolations(c.get('prisma'), tenantId);

    return result.fold(
      (data) => c.json(data),
      (error) => c.json({ error }, 400)
    );
  }
}
