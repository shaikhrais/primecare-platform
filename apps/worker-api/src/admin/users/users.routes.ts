import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { logAudit } from '../../_shared/utils/audit';
import { AdminUserService } from './users.service';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const UserParamsSchema = z.object({
    id: z.string().openapi({
        param: {
            name: 'id',
            in: 'path',
        },
        example: 'user_123',
    }),
});

// List Users
const listUsersRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.USERS_LIST,
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of users',
        },
    },
});

r.openapi(listUsersRoute, async (c) => {
    const prisma = c.get('prisma');
    const service = new AdminUserService(prisma);
    const users = await service.listUsers();
    return c.json(users);
});

// Verify User
const verifyUserRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.USERS_VERIFY,
    method: 'post',
    path: '/{id}/verify',
    request: {
        params: UserParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'User verified successfully',
        },
    },
});

r.openapi(verifyUserRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const service = new AdminUserService(prisma);
    const user = await service.verifyUser(id);
    return c.json(user);
});

// Update Roles
const updateRolesRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.USERS_ROLES,
    method: 'patch',
    path: '/{id}/roles',
    request: {
        params: UserParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        roles: z.array(z.enum(['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'manager', 'rn']))
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'User roles updated successfully',
        },
    },
});

r.openapi(updateRolesRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { roles } = c.req.valid('json');
    const user = c.get('user');
    const service = new AdminUserService(prisma);

    const updatedUser = await service.updateRoles(id, roles);
    await logAudit(prisma, user.id, 'UPDATE_USER_ROLES', 'User', id, { roles });

    return c.json(updatedUser);
});

// Elevate User (Super User)
const elevateUserRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.USERS_ELEVATE,
    method: 'post',
    path: '/{id}/elevate',
    request: {
        params: UserParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'User elevated successfully',
        },
    },
});

r.openapi(elevateUserRoute, async (c) => {
    const { id } = c.req.valid('param');
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload');

    const roles = ['admin', 'staff', 'manager', 'psw', 'client', 'coordinator', 'finance', 'rn'];

    const user = await prisma.user.update({
        where: { id },
        data: { roles: roles as any }
    });

    await logAudit(prisma, payload.sub, 'SUPER_USER_ELEVATED', 'User', id, { roles });

    return c.json(user);
});

export default r;
