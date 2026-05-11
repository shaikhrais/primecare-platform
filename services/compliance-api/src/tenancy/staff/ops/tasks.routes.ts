import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { ROUTE_METADATA } from '@primecare/infrastructure';
// RBAC: Inherits requireAnyPermission(['view_home', 'view_ops_home']) from staff.module.ts
import { logAudit } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const StaffTaskSchema = z.object({
    id: z.string().uuid().optional(),
    title: z.string().min(1),
    description: z.string().optional(),
    status: z.enum(['todo', 'in_progress', 'completed', 'blocked']).default('todo'),
    priority: z.enum(['low', 'medium', 'high', 'urgent']).default('medium'),
    dueDate: z.string().datetime().optional().nullable(),
    assigneeId: z.string().uuid().optional().nullable(),
    groupId: z.string().uuid().optional().nullable(),
});

const listTasksRoute = createRoute({
    ...ROUTE_METADATA.STAFF.TASKS,
    method: 'get',
    path: '/grid',
    summary: 'List Tasks',
    tags: ['Staff', 'Ops'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of staff tasks',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const createTaskRoute = createRoute({
    summary: 'Create Staff Task',
    description: 'Create a new operational task for the staff team.',
    tags: ['Staff Operations'],
    method: 'post',
    path: '/',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: StaffTaskSchema.omit({ id: true }),
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Task created successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const updateTaskRoute = createRoute({
    summary: 'Update Staff Task',
    description: 'Update status, priority, or details of an existing staff task.',
    tags: ['Staff Operations'],
    method: 'patch',
    path: '/{id}',
    request: {
        params: z.object({
            id: z.string().uuid().openapi({ param: { name: 'id', in: 'path' } }),
        }),
        body: {
            content: {
                'application/json': {
                    schema: StaffTaskSchema.partial().omit({ id: true }),
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
            description: 'Task updated successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listTasksRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const tasks = await prisma.staffTask.findMany({
        where: { tenantId },
        orderBy: { createdAt: 'desc' },
        include: {
            assignee: { select: { id: true, email: true, roles: true, providerProfile: { select: { fullName: true } }, clientProfile: { select: { fullName: true } } } },
            group: { select: { id: true, name: true } }
        }
    });

    return c.json(tasks, 200);
});

r.openapi(createTaskRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;
    const data = c.req.valid('json');

    const task = await prisma.staffTask.create({
        data: {
            ...data,
            tenantId,
        },
    });

    await logAudit(prisma, userId, 'CREATE_TASK', 'STAFF_TASK', task.id, { title: task.title });

    return c.json(task, 201);
});

r.openapi(updateTaskRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id } = c.req.valid('param');
    const data = c.req.valid('json');

    const task = await prisma.staffTask.update({
        where: { id },
        data,
    });

    await logAudit(prisma, userId, 'UPDATE_TASK', 'STAFF_TASK', task.id, { status: task.status });

    return c.json(task, 200);
});

export default r;
