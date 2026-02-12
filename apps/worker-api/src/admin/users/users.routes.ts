import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { logAudit } from '../../_shared/utils/audit';
import { AdminUserService } from './users.service';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// List Users
r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const service = new AdminUserService(prisma);
    const users = await service.listUsers();
    return c.json(users);
});

// Verify User
r.post('/:id/verify', async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const service = new AdminUserService(prisma);

    const user = await service.verifyUser(id);

    return c.json(user);
});

// Update Roles
r.patch('/:id/roles', zValidator('json', z.object({
    roles: z.array(z.enum(['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'manager', 'rn']))
})), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const { roles } = c.req.valid('json');
    const user = c.get('user');
    const service = new AdminUserService(prisma);

    const updatedUser = await service.updateRoles(id, roles);

    await logAudit(prisma, user.id, 'UPDATE_USER_ROLES', 'User', id, { roles });

    return c.json(updatedUser);
});

// Elevate User (Super User)
r.post('/:id/elevate', async (c) => {
    const id = c.req.param('id');
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
