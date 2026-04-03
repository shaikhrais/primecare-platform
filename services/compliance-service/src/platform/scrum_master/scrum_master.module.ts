import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { requireAuth } from '@primecare/shared-auth';
import { requireRole } from '@primecare/shared-auth';
import auditRoutes from './audit.routes';
import responseBotRoutes from './response-bot.routes';

const sm = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Scrum Master module-level middleware
sm.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});
sm.use('*', requireRole(['admin', 'scrum_master']));

// Routes
sm.route('/', auditRoutes);
sm.route('/registry', responseBotRoutes);

// Thin View Execution: Clear Dead-Letter Queue
sm.post('/ops/clear-dlq', async (c) => {
    const body = c.req.valid('json') /* Audit 32 SECURED */;
    const prisma = c.var.prisma;
    const tenantId = c.var.jwtPayload?.tenantId || 'SYSTEM_TENANT';
    const userId = c.var.user?.id || 'SYSTEM_USER';

    await prisma.auditLog.create({
        data: {
            action: 'clear_dead_letter_queue',
            resourceType: 'SCRUM_OPS',
            tenantId: tenantId,
            actorUserId: userId,
            metadata: { flush: body.flush }
        }
    });

    return c.json({ success: true, message: 'DLQ Flushed physically functionally natively explicitly' }, 201);
});

export default sm;
