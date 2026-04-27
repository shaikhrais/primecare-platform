import { AdminController } from '../controllers/admin.controller';

export function registerAdminRoutes(app: any) {
  app.post('/v1/admin/provision-staff', (c: any) => AdminController.provisionStaff(c));
  app.get('/v1/admin/staff', (c: any) => AdminController.listStaff(c));
  app.post('/v1/admin/staff/:userId/deactivate', (c: any) => AdminController.deactivateStaff(c));
  app.get('/v1/admin/departments', (c: any) => AdminController.getDepartments(c));
}
