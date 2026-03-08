import { Context, Next } from 'hono';
import { Bindings, Variables } from '../../bindings';

/**
 * Ensures that if the user is a PSW, they are only accessing resources for a client assigned to them.
 */
export const requireClientAssignedToPSW = async (c: Context<{ Bindings: Bindings; Variables: Variables }>, next: Next) => {
    const user = c.get('jwtPayload');
    if (!user) return c.json({ error: 'Unauthorized' }, 401);

    // Only enforce for PSW role
    if (!user.roles.includes('psw')) return await next();

    // Check request body or params for clientId
    const body = await c.req.json().catch(() => ({}));
    const paramClientId = c.req.param('clientId');
    const clientId = body.clientId || paramClientId;

    if (!clientId) {
        // If no clientId is involved in the action, we might skip or fail depending on the route.
        // For now, if specified, we enforce it.
        return await next();
    }

    const prisma = c.get('prisma');

    // R23 (L26): Actually verify the PSW is assigned to this client
    // Check if the PSW has any visits/assignments linking them to this client
    const assignment = await prisma.visit.findFirst({
        where: {
            clientId: clientId,
            assignedPswId: user.sub,
            tenantId: user.tenantId,
        },
        select: { id: true }
    });

    if (!assignment) {
        // Fallback: check if there's a direct client profile assignment
        const profileAssignment = await prisma.clientProfile.findFirst({
            where: {
                id: clientId,
                tenantId: user.tenantId,
                assignedPswId: user.sub,
            },
            select: { id: true }
        });

        if (!profileAssignment) {
            return c.json({ error: 'Forbidden: Client not assigned to you' }, 403);
        }
    }

    await next();
};

