import { ComplianceService } from '@primecare/domain/src/services/ComplianceService';
import { TrainingService } from '@primecare/domain/src/services/TrainingService';

export class ComplianceController {
  static async getTrainingSummary(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';

    const result = await TrainingService.getTrainingComplianceSummary(
      c.get('prisma'),
      tenantId as string
    );

    return result.fold(
      (data) => c.json({
        success: true,
        data,
        timestamp: new Date().toISOString()
      }),
      (error) => c.json({ success: false, error }, 500)
    );
  }

  static async verifyCertificate(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const body = await c.req.json();

    const result = await TrainingService.verifyCertificate(
      c.get('prisma'),
      tenantId as string,
      {
        staffName: body.staffName,
        certName: body.certName
      }
    );

    return result.fold(
      (data) => c.json({
        success: true,
        ...data,
        timestamp: new Date().toISOString()
      }),
      (error) => c.json({ success: false, error: error.message || error }, 500)
    );
  }

  static async getRecentActivity(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const { limit } = c.req.query();

    const result = await TrainingService.getRecentActivity(
      c.get('prisma'),
      tenantId as string,
      limit ? parseInt(limit as string) : 10
    );

    return result.fold(
      (data) => c.json({
        success: true,
        count: data.length,
        data,
        timestamp: new Date().toISOString()
      }),
      (error) => c.json({ success: false, error }, 500)
    );
  }

  static async getAuditReport(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const { startDate, endDate } = c.req.query();

    const result = await ComplianceService.getAuditReportData(
      c.get('prisma'),
      tenantId as string,
      startDate,
      endDate
    );

    return result.fold(
      (data) => c.json({
        success: true,
        count: data.length,
        data,
        timestamp: new Date().toISOString()
      }),
      (error) => c.json({ success: false, error }, 500)
    );
  }

  static async getClinicalReport(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const { startDate, endDate } = c.req.query();

    const result = await ComplianceService.getClinicalComplianceData(
      c.get('prisma'),
      tenantId as string,
      startDate,
      endDate
    );

    return result.fold(
      (data) => c.json({
        success: true,
        count: data.length,
        data,
        timestamp: new Date().toISOString()
      }),
      (error) => c.json({ success: false, error }, 500)
    );
  }

  static async getStaffActivityReport(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const { startDate, endDate } = c.req.query();

    const result = await ComplianceService.getStaffActivityReport(
      c.get('prisma'),
      tenantId as string,
      startDate,
      endDate
    );

    return result.fold(
      (data) => c.json({
        success: true,
        count: data.length,
        data,
        timestamp: new Date().toISOString()
      }),
      (error) => c.json({ success: false, error }, 500)
    );
  }

  static async getCurricula(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const result = await TrainingService.getCurricula(c.get('prisma'), tenantId as string);
    return result.fold(
      (data) => c.json({ success: true, count: data.length, data }),
      (error) => c.json({ success: false, error }, 500)
    );
  }

  static async getCertifications(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const result = await TrainingService.getCertifications(c.get('prisma'), tenantId as string);
    return result.fold(
      (data) => c.json({ success: true, count: data.length, data }),
      (error) => c.json({ success: false, error }, 500)
    );
  }

  static async createModule(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const body = await c.req.json();
    const result = await TrainingService.createModule(c.get('prisma'), tenantId as string, body);
    return result.fold(
      (data) => c.json({ success: true, data }),
      (error) => c.json({ success: false, error: error.message || error }, 500)
    );
  }

  static async updateModule(c: any) {
    const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
    const id = c.req.param('id');
    const body = await c.req.json();
    const result = await TrainingService.updateModule(c.get('prisma'), tenantId as string, id, body);
    return result.fold(
      (data) => c.json({ success: true, data }),
      (error) => c.json({ success: false, error: error.message || error }, 500)
    );
  }
}
