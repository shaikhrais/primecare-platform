import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const GroupSchema = z.object({
    id: z.string(),
    name: z.string(),
    description: z.string().nullable(),
});

const CreateGroupSchema = z.object({
    name: z.string().min(1),
    description: z.string().optional(),
});

const AddMemberSchema = z.object({
    userId: z.string(),
    role: z.string().default('member'),
});

const getGroups = createRoute({
    method: 'get',
    path: '/',
    summary: 'Get Groups',
    tags: ['Admin', 'Staff Groups'],
    description: 'Get all staff groups for tenant',
    responses: {
        200: { content: { 'application/json': { schema: z.array(GroupSchema) } }, description: 'List of groups' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getGroups, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const groups = await prisma.staffGroup.findMany({
        where: { tenantId },
        include: { _count: { select: { members: true, tasks: true } } }
    });
    return c.json(groups, 200);
});

const createGroup = createRoute({
    method: 'post',
    path: '/',
    summary: 'Create Group',
    tags: ['Admin', 'Staff Groups'],
    description: 'Create a new staff group',
    request: { body: { content: { 'application/json': { schema: CreateGroupSchema } } } },
    responses: {
        200: { content: { 'application/json': { schema: GroupSchema } }, description: 'Group created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(createGroup, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const { name, description } = c.req.valid('json');

    const group = await prisma.staffGroup.create({
        data: { name, description, tenantId }
    });
    return c.json(group, 200);
});

const getMembers = createRoute({
    method: 'get',
    path: '/{id}/members',
    summary: 'Get Members',
    tags: ['Admin', 'Staff Groups'],
    description: 'Get members of a group',
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.any() } }, description: 'List of members' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getMembers, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const members = await prisma.staffGroupMember.findMany({
        where: { groupId: id },
        include: { user: { select: { id: true, email: true, roles: true } } }
    });
    return c.json(members, 200);
});

const addMember = createRoute({
    method: 'post',
    path: '/{id}/members',
    summary: 'Add Member',
    tags: ['Admin', 'Staff Groups'],
    description: 'Add a user to a group',
    request: { 
        params: z.object({ id: z.string() }),
        body: { content: { 'application/json': { schema: AddMemberSchema } } }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.any() } }, description: 'Member added' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(addMember, async (c) => {
    const prisma = c.get('prisma');
    const { id: groupId } = c.req.valid('param');
    const { userId, role } = c.req.valid('json');

    const member = await prisma.staffGroupMember.create({
        data: { groupId, userId, role }
    });
    return c.json(member, 200);
});

const removeMember = createRoute({
    method: 'delete',
    path: '/{id}/members/{userId}',
    summary: 'Remove Member',
    tags: ['Admin', 'Staff Groups'],
    description: 'Remove a user from a group',
    request: { params: z.object({ id: z.string(), userId: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.any() } }, description: 'Member removed' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(removeMember, async (c) => {
    const prisma = c.get('prisma');
    const { id: groupId, userId } = c.req.valid('param');

    await prisma.staffGroupMember.delete({
        where: { groupId_userId: { groupId, userId } }
    });
    return c.json({ success: true }, 200);
});

export default r;
