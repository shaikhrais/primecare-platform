/**
 * Users Route Definitions + Handlers
 * Extracted from users.routes.ts
 */
import { createRoute, z } from '@hono/zod-openapi';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { logAudit } from '../../../_shared/utils/audit';
import { AdminUserService } from './users.service';

const UserParamsSchema = z.object({ id: z.string().openapi({ param: { name: 'id', in: 'path' }, example: 'user_123' }) });

export const listUsersRoute = createRoute({ ...ROUTE_METADATA.ADMIN_EXTRA.USERS_LIST, method: 'get', path: '/', summary: 'List Users', tags: ['Admin', 'Users'], responses: { 200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'List of users' } } });
export const createUserRoute = createRoute({ ...ROUTE_METADATA.ADMIN_EXTRA.USERS_CREATE, method: 'post', path: '/', summary: 'Create User', tags: ['Admin', 'Users'], request: { body: { content: { 'application/json': { schema: z.object({ email: z.string().email(), roles: z.array(z.string()), fullName: z.string(), status: z.string().optional() }) } } } }, responses: { 201: { content: { 'application/json': { schema: z.any() } }, description: 'User created successfully' } } });
export const verifyUserRoute = createRoute({ ...ROUTE_METADATA.ADMIN_EXTRA.USERS_VERIFY, method: 'post', path: '/{id}/verify', summary: 'Verify User', tags: ['Admin', 'Users'], request: { params: UserParamsSchema }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'User verified successfully' } } });
export const updateRolesRoute = createRoute({ ...ROUTE_METADATA.ADMIN_EXTRA.USERS_ROLES, method: 'patch', path: '/{id}/roles', summary: 'Update Roles', tags: ['Admin', 'Users'], request: { params: UserParamsSchema, body: { content: { 'application/json': { schema: z.object({ roles: z.array(z.enum(['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'manager', 'rn'])) }) } } } }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'User roles updated successfully' } } });
export const elevateUserRoute = createRoute({ ...ROUTE_METADATA.ADMIN_EXTRA.USERS_ELEVATE, method: 'post', path: '/{id}/elevate', summary: 'Elevate User', tags: ['Admin', 'Users'], request: { params: UserParamsSchema }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'User elevated successfully' } } });
export const updateStatusRoute = createRoute({ ...ROUTE_METADATA.ADMIN_EXTRA.USERS_ROLES, method: 'patch', path: '/{id}/status', summary: 'Update Status', tags: ['Admin', 'Users'], request: { params: UserParamsSchema, body: { content: { 'application/json': { schema: z.object({ status: z.enum(['active', 'pending', 'suspended', 'terminated', 'archived']) }) } } } }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'User status updated successfully' } } });
export const churnHeatmapRoute = createRoute({ method: 'get', path: '/churn-heatmap', summary: 'Churn Risk X/Y Matrix', tags: ['Admin', 'Users'], responses: { 200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'Heatmap coordinates' } } });

export async function handleListUsers(c: any) { const prisma = c.get('prisma'); return c.json(await new AdminUserService(prisma).listUsers()); }
export async function handleCreateUser(c: any) { const prisma = c.get('prisma'); const data = await c.req.valid('json' as never) as any; const userRole = c.get('user' as any) as any; const newUser = await new AdminUserService(prisma).createUser({ ...data, tenantId: userRole?.tenantId || 'system' }); await logAudit(prisma, userRole?.id || 'system', 'CREATE_USER', 'User', newUser.id, data); return c.json(newUser, 201); }
export async function handleVerifyUser(c: any) { const prisma = c.get('prisma'); const { id } = c.req.valid('param'); return c.json(await new AdminUserService(prisma).verifyUser(id)); }
export async function handleUpdateRoles(c: any) { const prisma = c.get('prisma'); const { id } = c.req.valid('param'); const { roles } = c.req.valid('json'); const user = c.get('user'); const updatedUser = await new AdminUserService(prisma).updateRoles(id, roles); await logAudit(prisma, user.id, 'UPDATE_USER_ROLES', 'User', id, { roles }); return c.json(updatedUser); }
export async function handleElevateUser(c: any) { const { id } = c.req.valid('param'); const prisma = c.get('prisma'); const payload = c.get('jwtPayload'); const roles = ['admin', 'staff', 'manager', 'psw', 'client', 'coordinator', 'finance', 'rn']; const user = await prisma.user.update({ where: { id }, data: { roles: roles as any }, select: { id: true, email: true, roles: true, status: true, createdAt: true } }); await logAudit(prisma, payload.sub, 'SUPER_USER_ELEVATED', 'User', id, { roles }); return c.json(user); }
export async function handleUpdateStatus(c: any) {
    const prisma = c.get('prisma'); const { id } = c.req.valid('param'); const { status } = c.req.valid('json'); const userRole = c.get('user');
    const updatedUser = await prisma.user.update({ where: { id }, data: { status }, select: { id: true, email: true, roles: true, status: true, createdAt: true, tenantId: true } });
    if (['terminated', 'suspended', 'archived'].includes(status)) { try { await prisma.userDevice.deleteMany({ where: { userId: id } }); await prisma.auditLog.create({ data: { tenantId: updatedUser.tenantId || 'system', actorUserId: userRole.id, action: 'BADGE_DEACTIVATED', resourceType: 'USER', resourceId: id, metadata: JSON.stringify({ reason: `HR escalated profile status to ${status}. Tokens severed.` }) } }); console.log(`[Admin] Feature 30 Fired: Digital Badge deactivated for user ${id}. Devices expelled.`); } catch (e: any) { console.log(`[Admin] Token revocation passed with non-fatal constraints: ${e.message}`); } }
    await logAudit(prisma, userRole.id, 'UPDATE_USER_STATUS', 'User', id, { status }); return c.json(updatedUser);
}
export async function handleChurnHeatmap(c: any) {
    const prisma = c.get('prisma'); const tenantId = (c.get('jwtPayload') as any).tenantId;
    const profiles = await prisma.pswProfile.findMany({ where: { tenantId }, include: { user: { select: { fullName: true, id: true } }, gamification: true, wellnessPulse: { orderBy: { createdAt: 'desc' }, take: 5 } } });
    const data = profiles.map((p: any) => { const avgBurnout = p.wellnessPulse.length > 0 ? p.wellnessPulse.reduce((acc: number, curr: any) => acc + curr.score, 0) / p.wellnessPulse.length : 5; const coins = p.gamification?.careCoins || 0; return { pswId: p.id, name: p.user?.fullName || 'Unknown', xBurnoutScore: avgBurnout, yCareCoins: coins, riskLevel: (avgBurnout <= 3 && coins < 200) ? 'HIGH' : (avgBurnout >= 4 && coins > 1000) ? 'LOW' : 'MEDIUM' }; });
    console.log(`[Admin] Feature 33 Fired: Generated Churn Risk Heatmap matrix for ${data.length} profiles.`); return c.json(data);
}
