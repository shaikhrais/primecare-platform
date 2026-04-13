import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { hashPassword, comparePassword } from '@primecare/infrastructure';
import { logAudit } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const changePasswordRoute = createRoute({
    method: 'post',
    path: '/change-password',
    summary: 'Change Password',
    description: 'Allows authenticated users to change their password.',
    tags: ['User'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        currentPassword: z.string().min(1, 'Current password required'),
                        newPassword: z.string().min(8, 'Password must be at least 8 characters')
                            .regex(/[A-Z]/, 'Must contain uppercase letter')
                            .regex(/[a-z]/, 'Must contain lowercase letter')
                            .regex(/[0-9]/, 'Must contain a number')
                            .regex(/[^A-Za-z0-9]/, 'Must contain a special character'),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ success: z.boolean(), message: z.string() }) } },
            description: 'Password changed successfully',
        },
        400: { description: 'Validation error or same password' },
        401: { description: 'Current password incorrect' },
        404: { description: 'User not found' },
        500: { description: 'Server error' },
    },
});

r.openapi(changePasswordRoute, async (c) => {
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload');
    const userId = payload?.sub;

    if (!userId) return c.json({ error: 'Unauthorized' }, 401);

    const { currentPassword, newPassword } = c.req.valid('json');

    // Prevent setting same password
    if (currentPassword === newPassword) {
        return c.json({ error: 'New password must be different from current password' }, 400);
    }

    const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { id: true, passwordHash: true, tenantId: true },
    });

    if (!user) return c.json({ error: 'User not found' }, 404);

    if (!user.passwordHash) {
        return c.json({ error: 'Password change not available for OAuth accounts' }, 400);
    }

    // Verify current password
    const isValid = await comparePassword(currentPassword, user.passwordHash);
    if (!isValid) {
        // Audit failed password change attempt
        await logAudit(prisma, userId, 'password_change_failed', 'user', userId, { tenantId: user.tenantId });
        return c.json({ error: 'Current password is incorrect' }, 401);
    }

    // Hash and save new password (PBKDF2)
    const newHash = await hashPassword(newPassword);
    await prisma.user.update({
        where: { id: userId },
        data: { passwordHash: newHash },
    });

    // Audit successful password change
    await logAudit(prisma, userId, 'password_changed', 'user', userId, { tenantId: user.tenantId });

    return c.json({ success: true, message: 'Password changed successfully' }, 200);
});

export default r;
