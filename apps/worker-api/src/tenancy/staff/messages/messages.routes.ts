import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const listMessagesRoute = createRoute({
    ...ROUTE_METADATA.STAFF.MESSAGES,
    method: 'get',
    path: '/hub',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'Unified message hub for staff',
        },
    },
});

r.openapi(listMessagesRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    // Aggregates staff-to-staff messages
    const threads = await prisma.messageThread.findMany({
        where: { tenantId },
        include: {
            messages: {
                orderBy: { createdAt: 'desc' },
                take: 1
            }
        },
        orderBy: { updatedAt: 'desc' }
    });

    return c.json(threads, 200);
});
// Feature 42: Secure Chat Auditing
const auditChatsRoute = createRoute({
    method: 'get',
    path: '/hub/audit',
    summary: 'QA Encrypted Pull of target Message Threads',
    request: { query: z.object({ targetUserId: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'Audit pulled' },
        403: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Unauthorized' }
    },
});

r.openapi(auditChatsRoute, async (c) => {
    const prisma = c.get('prisma');
    const { targetUserId } = c.req.valid('query');
    const userId = c.get('jwtPayload').sub;

    const caller = await prisma.user.findUnique({ where: { id: userId } });
    if (!caller?.roles.includes('admin') && !caller?.roles.includes('manager')) {
        return c.json({ error: 'Unauthorized to perform QA Audits' }, 403);
    }

    const threads = await prisma.messageThread.findMany({
        where: { participants: { some: { id: targetUserId } } },
        include: { messages: true, participants: { select: { id: true, fullName: true, role: true } } }
    });

    await prisma.auditLog.create({
        data: {
            tenantId: caller.tenantId || 'system', actorUserId: userId,
            action: 'SECURE_CHAT_AUDIT', resourceType: 'USER', resourceId: targetUserId,
            metadataString: `Pulled ${threads.length} threads for Incident tracking.`
        }
    });

    return c.json(threads, 200);
});

// Feature 45: Multi-Disciplinary Thread Board
const multiDisciplinaryThreadRoute = createRoute({
    method: 'post',
    path: '/hub/multidisciplinary',
    summary: 'Establish a shared Care Thread connecting RN, PSW, and Client',
    request: { body: { content: { 'application/json': { schema: z.object({ clientId: z.string() }) } } } },
    responses: {
        200: { content: { 'application/json': { schema: z.any() } }, description: 'Thread created' },
        400: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not enough mapping' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Client not found' }
    },
});

r.openapi(multiDisciplinaryThreadRoute, async (c) => {
    const prisma = c.get('prisma');
    const { clientId } = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;

    // Look up connected profiles
    const client = await prisma.client.findUnique({ where: { id: clientId } });
    if (!client) return c.json({ error: 'Client not found' }, 404);

    const activeVisit = await prisma.visit.findFirst({
        where: { clientId, status: { in: ['scheduled', 'in_progress'] } }, include: { psw: { include: { user: true } } }
    });
    
    const supervisingRn = await prisma.user.findFirst({ where: { tenantId, role: 'rn' } });
    const participantIds = [];
    if (activeVisit?.psw?.user?.id) participantIds.push({ id: activeVisit.psw.user.id });
    if (supervisingRn) participantIds.push({ id: supervisingRn.id });
    
    // Guardian mapping check
    const guardianUser = await prisma.user.findFirst({ where: { tenantId, roles: { has: 'client' } } });
    if (guardianUser) participantIds.push({ id: guardianUser.id });

    if (participantIds.length < 2) return c.json({ error: 'Not enough participants mapped' }, 400);

    const thread = await prisma.messageThread.create({
        data: {
            tenantId,
            relatedEntityId: clientId,
            relatedEntityType: 'Client',
            participants: { connect: participantIds }
        }
    });

    await prisma.message.create({
        data: {
            threadId: thread.id, senderId: supervisingRn?.id || guardianUser?.id || '',
            content: `Multi-Disciplinary Thread initialized regarding Care Plan for ${client.fullName}.`, tenantId
        }
    });

    return c.json(thread, 200);
});

export default r;
