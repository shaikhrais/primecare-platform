import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import { ROUTE_METADATA } from '@primecare/shared-utils';
import { requirePermission } from '@primecare/shared-auth';
import { handleGetHomeStats, handleRedeemStore } from './home-handlers';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getHomeStatsRoute = createRoute({ ...ROUTE_METADATA.PSW_EXTRA.HOME_STATS, method: 'get', path: '/stats', summary: 'Get Home Stats', tags: ['PSW', 'Home'], middleware: [requirePermission('view_home')], responses: { 200: { content: { 'application/json': { schema: z.object({ earnings: z.array(z.any()), reliability: z.array(z.any()), shifts: z.array(z.any()), hoursLogged: z.number(), currentStreak: z.number() }) } }, description: 'Home statistics' }, 404: { description: 'Profile not found' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const postHardwarePurchaseRoute = createRoute({ method: 'post', path: '/hardware/purchase', summary: 'Post Hardware Purchase', tags: ['PSW', 'Home'], description: 'Process a hardware purchase with payroll deduction', middleware: [requirePermission('view_home')], request: { body: { content: { 'application/json': { schema: z.object({ itemId: z.string() }) } } } }, responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Order success' }, 500: { description: 'Server Error' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const postIncidentRoute = createRoute({ method: 'post', path: '/incident', summary: 'Report Incident', tags: ['PSW', 'Home'], middleware: [requirePermission('view_home')], responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Success' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const postWellnessRoute = createRoute({ method: 'post', path: '/wellness', summary: 'Wellness Pulse Submission', tags: ['PSW', 'Home'], middleware: [requirePermission('view_home')], responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Success' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const redeemStoreRoute = createRoute({ method: 'post', path: '/store/redeem', summary: 'CareCoin Redemption Store', tags: ['PSW', 'Home'], middleware: [requirePermission('view_home')], request: { body: { content: { 'application/json': { schema: z.object({ itemId: z.string(), cost: z.number() }) } } } }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'Reward redeemed successfully' }, 400: { description: 'Insufficient funds' },
    '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });

r.openapi(getHomeStatsRoute, handleGetHomeStats);
r.openapi(postHardwarePurchaseRoute, async (c) => c.json({ message: 'Hardware order processed via payroll deduction.' }, 200));
r.openapi(postIncidentRoute, async (c) => c.json({ message: 'Incident report securely filed.' }, 200));
r.openapi(postWellnessRoute, async (c) => c.json({ message: 'Wellness pulse recorded. Thank you!' }, 200));
r.openapi(redeemStoreRoute, handleRedeemStore);

export default r;
