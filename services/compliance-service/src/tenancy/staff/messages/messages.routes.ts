import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const listMessagesRoute = createRoute({
    ...ROUTE_METADATA.STAFF.MESSAGES,
    method: 'get',
    path: '/hub',
    summary: 'List Messages',
    tags: ['Staff', 'Messages'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'Unified message hub for staff',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
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
        orderBy: { createdAt: 'desc' }
    });

    // Map to UI-expected shape: { id, sender, role, lastMessage, time, unread, status }
    const mapped = threads.map((t: any) => {
        const lastMsg = t.messages?.[0];
        return {
            id: t.id,
            sender: lastMsg?.senderUserId || 'Unknown',
            role: t.threadType === 'multidisciplinary' ? 'Coordinator' : 'Staff',
            lastMessage: lastMsg?.bodyText || '',
            time: lastMsg?.createdAt ? new Date(lastMsg.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : '',
            unread: false,
            status: 'online' as const,
        };
    });

    return c.json(mapped, 200);
});
// Feature 42: Secure Chat Auditing
const auditChatsRoute = createRoute({
    method: 'get',
    path: '/hub/audit',
    summary: 'QA Encrypted Pull of target Message Threads',
    tags: ['Staff', 'Messages'],
    request: { query: z.object({ targetUserId: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'Audit pulled' },
        403: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Unauthorized' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
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
        where: { OR: [{ clientId: targetUserId }, { providerId: targetUserId }] },
        include: { messages: true, client: { select: { id: true, fullName: true } } }
    });

    await prisma.auditLog.create({
        data: {
            tenantId: caller.tenantId || 'system', actorUserId: userId,
            action: 'SECURE_CHAT_AUDIT', resourceType: 'USER', resourceId: targetUserId,
            metadata: `Pulled ${threads.length} threads for Incident tracking.`
        }
    });

    return c.json(threads, 200);
});

// Feature 45: Multi-Disciplinary Thread Board
const multiDisciplinaryThreadRoute = createRoute({
    method: 'post',
    path: '/hub/multidisciplinary',
    summary: 'Establish a shared Care Thread connecting RN, PSW, and Client',
    tags: ['Staff', 'Messages'],
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
    const client = await prisma.clientProfile.findUnique({ where: { id: clientId } });
    if (!client) return c.json({ error: 'Client not found' }, 404);

    const activeVisit = await prisma.visit.findFirst({
        where: { clientId, status: { in: ['scheduled', 'in_progress'] } }, include: { psw: { include: { user: true } } }
    });
    
    const supervisingRn = await prisma.user.findFirst({ where: { tenantId, roles: { contains: 'rn' } } });
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
            threadType: 'multidisciplinary',
            clientId,
        }
    });

    await prisma.message.create({
        data: {
            threadId: thread.id, senderUserId: supervisingRn?.id || guardianUser?.id || '',
            bodyText: `Multi-Disciplinary Thread initialized regarding Care Plan for ${client.fullName}.`
        }
    });

    return c.json(thread, 200);
});

export default r;
