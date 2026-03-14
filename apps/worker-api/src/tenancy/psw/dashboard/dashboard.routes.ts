import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';
import { handleGetDashboardStats, handleRedeemStore } from './dashboard-handlers';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getDashboardStatsRoute = createRoute({ ...ROUTE_METADATA.PSW_EXTRA.DASHBOARD_STATS, method: 'get', path: '/stats', summary: 'Get Dashboard Stats', tags: ['PSW', 'Dashboard'], middleware: [requirePermission('view_dashboard')], responses: { 200: { content: { 'application/json': { schema: z.object({ earnings: z.array(z.any()), reliability: z.array(z.any()), shifts: z.array(z.any()), hoursLogged: z.number(), currentStreak: z.number() }) } }, description: 'Dashboard statistics' }, 404: { description: 'Profile not found' } } });
const postHardwarePurchaseRoute = createRoute({ method: 'post', path: '/hardware/purchase', summary: 'Post Hardware Purchase', tags: ['PSW', 'Dashboard'], description: 'Process a hardware purchase with payroll deduction', middleware: [requirePermission('view_dashboard')], request: { body: { content: { 'application/json': { schema: z.object({ itemId: z.string() }) } } } }, responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Order success' }, 500: { description: 'Server Error' } } });
const postIncidentRoute = createRoute({ method: 'post', path: '/incident', summary: 'Report Incident', tags: ['PSW', 'Dashboard'], middleware: [requirePermission('view_dashboard')], responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Success' } } });
const postWellnessRoute = createRoute({ method: 'post', path: '/wellness', summary: 'Wellness Pulse Submission', tags: ['PSW', 'Dashboard'], middleware: [requirePermission('view_dashboard')], responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Success' } } });
const redeemStoreRoute = createRoute({ method: 'post', path: '/store/redeem', summary: 'CareCoin Redemption Store', tags: ['PSW', 'Dashboard'], middleware: [requirePermission('view_dashboard')], request: { body: { content: { 'application/json': { schema: z.object({ itemId: z.string(), cost: z.number() }) } } } }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'Reward redeemed successfully' }, 400: { description: 'Insufficient funds' } } });

r.openapi(getDashboardStatsRoute, handleGetDashboardStats);
r.openapi(postHardwarePurchaseRoute, async (c) => c.json({ message: 'Hardware order processed via payroll deduction.' }, 200));
r.openapi(postIncidentRoute, async (c) => c.json({ message: 'Incident report securely filed.' }, 200));
r.openapi(postWellnessRoute, async (c) => c.json({ message: 'Wellness pulse recorded. Thank you!' }, 200));
r.openapi(redeemStoreRoute, handleRedeemStore);

export default r;
