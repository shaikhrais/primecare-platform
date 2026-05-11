/**
 * Admin Infrastructure Sub-App
 * System data, audit export, webhooks, cron, interop, AI/IoT, platform stats,
 * risk surveillance, predictive staffing, reseller
 */
import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { systemDataRoutes } from '../system-data/system-data.routes';
import auditExportRoutes from '../audit-export/audit-export.routes';
import webhookRoutes from '../webhooks/webhooks.routes';
import cronRoutes from '../cron/cron.routes';
import interopRoutes from '../interop/interop.routes';
import aiStubRoutes from '../ai-stubs/ai-stubs.routes';
import { platformStats } from '../routes/platform-stats.routes';
import { riskSurveillanceRoutes } from '../routes/risk-surveillance.routes';
import { predictiveStaffingRoutes } from '../routes/predictive-staffing.routes';
import { resellerRoutes } from '../routes/reseller.routes';

const infra = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

infra.route('/system-data', systemDataRoutes);
infra.route('/audit-export', auditExportRoutes);
infra.route('/webhooks', webhookRoutes);
infra.route('/cron', cronRoutes);
infra.route('/interop', interopRoutes);
infra.route('/ai-iot', aiStubRoutes);
infra.route('/system/platform', platformStats);
infra.route('/system/risk-surveillance', riskSurveillanceRoutes);
infra.route('/insights/predictive-staffing', predictiveStaffingRoutes);
infra.route('/reseller', resellerRoutes);

export default infra;
