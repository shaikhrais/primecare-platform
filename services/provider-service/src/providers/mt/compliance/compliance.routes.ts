import { Hono } from 'hono';
import { AppEnv } from '../../../../../../app';
import { requirePermission } from '../../../../_shared/middleware/rbac';
import { Permission } from '@repo/shared/registries/PermissionRegistry';
import { MTComplianceController } from './compliance.controller';

const mtComplianceRouter = new Hono<AppEnv>();

/**
 * 🔐 ROLE RESTRICTION: MT & Superuser Only
 * Provides endpoints for MT-level compliance actions.
 */
mtComplianceRouter.use('*', requirePermission(Permission.MANAGE_SYSTEM)); 

// Verify user licenses (mocking third-party verification)
mtComplianceRouter.post('/verify-license', MTComplianceController.verifyLicense);

// Scan uploaded document for compliance status
mtComplianceRouter.post('/scan-document', MTComplianceController.scanDocument);

export { mtComplianceRouter };
