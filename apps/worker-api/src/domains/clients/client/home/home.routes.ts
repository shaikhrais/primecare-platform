import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import { ROUTE_METADATA } from '../../../../_shared/constants/route_metadata';
import { requirePermission, requireAnyPermission } from '../../../../_shared/middleware/rbac';
import { handleGetClientStats, handleUpdateProfile } from './home-handlers';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ProfileUpdateSchema = z.object({ fullName: z.string().min(2).optional(), phone: z.string().optional(), addressLine1: z.string().optional(), city: z.string().optional(), province: z.string().optional(), postalCode: z.string().optional(), emergencyName: z.string().optional(), emergencyPhone: z.string().optional() });

const getProfileRoute = createRoute({ ...ROUTE_METADATA.CLIENT.GET_PROFILE, method: 'get', path: '/profile', summary: 'Get Profile', tags: ['Client', 'Home'], middleware: [requireAnyPermission(['view_own_medical', 'clinical_oversight', 'view_users'])], responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'Client profile details' }, 404: { description: 'Profile not found' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const updateProfileRoute = createRoute({ ...ROUTE_METADATA.CLIENT.UPDATE_PROFILE, method: 'put', path: '/profile', summary: 'Update Profile', tags: ['Client', 'Home'], middleware: [requirePermission('view_own_medical')], request: { body: { content: { 'application/json': { schema: ProfileUpdateSchema } } } }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'Profile updated successfully' }, 401: { description: 'Unauthorized' }, 403: { description: 'Forbidden' }, 404: { description: 'Profile not found' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const getClientStatsRoute = createRoute({ ...ROUTE_METADATA.CLIENT.STATS, method: 'get', path: '/stats', summary: 'Get Client Stats', tags: ['Client', 'Home'], middleware: [requirePermission('view_home')], responses: { 200: { content: { 'application/json': { schema: z.object({ budget: z.array(z.any()), wellness: z.array(z.any()), continuity: z.array(z.any()), nextVisit: z.any().nullable().optional() }) } }, description: 'Client home statistics' }, 404: { description: 'Profile not found' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });

r.openapi(getProfileRoute, async (c) => { const prisma = c.get('prisma'); const userId = c.get('jwtPayload').sub; const profile = await prisma.clientProfile.findUnique({ where: { userId }, include: { user: { select: { email: true, phone: true } } } }); if (!profile) return c.json({ error: 'Profile not found' }, 404); return c.json(profile, 200); });
r.openapi(updateProfileRoute, handleUpdateProfile);
r.openapi(getClientStatsRoute, handleGetClientStats);

export default r;
