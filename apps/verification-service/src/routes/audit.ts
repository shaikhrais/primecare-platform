import { AuditController } from '../controllers/audit.controller';

export function registerAuditRoutes(app: any) {
  app.get('/v1/audit/logs', (c: any) => AuditController.listLogs(c));
  app.post('/v1/audit/logs', (c: any) => AuditController.recordLog(c));
}
