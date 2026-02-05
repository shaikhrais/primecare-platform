import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { PrismaClient, VisitStatus } from '../../generated/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware } from '../auth';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const getPrisma = (database_url: string) => {
    return new PrismaClient({
        datasourceUrl: database_url,
    }).$extends(withAccelerate());
};

const AssignPswSchema = z.object({
    visitId: z.string().uuid(),
    pswId: z.string().uuid(),
});

// Middleware: Admin Only
app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', rbacMiddleware(['admin']));

/**
 * @openapi
 * /v1/admin/users:
 *   get:
 *     summary: List all users
 */
app.get('/users', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const users = await prisma.user.findMany({
        select: {
            id: true,
            email: true,
            role: true,
            status: true,
            createdAt: true,
            clientProfile: { select: { fullName: true } },
            pswProfile: { select: { fullName: true } },
        },
        orderBy: { createdAt: 'desc' },
    });
    return c.json(users);
});

/**
 * @openapi
 * /v1/admin/visits:
 *   get:
 *     summary: List all visits (Scheduling)
 */
app.get('/visits', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const visits = await prisma.visit.findMany({
        include: {
            client: { select: { fullName: true, addressLine1: true } },
            psw: { select: { fullName: true } },
            service: true,
        },
        orderBy: { requestedStartAt: 'desc' },
    });
    return c.json(visits);
});

/**
 * @openapi
 * /v1/admin/visits/assign:
 *   post:
 *     summary: Assign PSW to Visit
 */
app.post('/visits/assign', zValidator('json', AssignPswSchema), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const { visitId, pswId } = c.req.valid('json');

    // Verify PSW exists
    const psw = await prisma.pswProfile.findUnique({ where: { id: pswId } });
    if (!psw) return c.json({ error: 'PSW not found' }, 404);

    const visit = await prisma.visit.update({
        where: { id: visitId },
        data: {
            assignedPswId: pswId,
            status: 'scheduled',
        },
    });

    return c.json(visit);
});

/**
 * @openapi
 * /v1/admin/stats:
 *   get:
 *     summary: Dashboard Stats
 */
app.get('/stats', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);

    const [totalUsers, totalVisits, pendingVisits, totalLeads] = await Promise.all([
        prisma.user.count(),
        prisma.visit.count(),
        prisma.visit.count({ where: { status: 'requested' } }),
        prisma.lead.count(),
    ]);

    return c.json({
        totalUsers,
        totalVisits,
        pendingVisits,
        totalLeads,
    });
});

/**
 * @openapi
 * /v1/admin/leads:
 *   get:
 *     summary: List all leads from marketing
 */
app.get('/leads', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const leads = await prisma.lead.findMany({
        orderBy: { createdAt: 'desc' },
    });
    return c.json(leads);
});

/**
 * @openapi
 * /v1/admin/leads/:id:
 *   patch:
 *     summary: Update lead status
 */
app.patch('/leads/:id', zValidator('json', z.object({ status: z.string() })), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const id = c.req.param('id');
    const { status } = c.req.valid('json');

    const lead = await prisma.lead.update({
        where: { id },
        data: { status },
    });

    return c.json(lead);
});

/**
 * @openapi
 * /v1/admin/users/:id/verify:
 *   post:
 *     summary: Verify a user profile (e.g. PSW)
 */
app.post('/users/:id/verify', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const id = c.req.param('id');

    const user = await prisma.user.update({
        where: { id },
        data: { status: 'verified' },
    });

    return c.json(user);
});

// Services CRUD
app.get('/services', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const services = await prisma.service.findMany();
    return c.json(services);
});

app.post('/services', zValidator('json', z.object({
    name: z.string(),
    description: z.string().optional(),
    hourlyRate: z.number(),
    category: z.string().optional(),
})), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const data = c.req.valid('json');
    // Generate slug from name
    const slug = data.name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');

    const service = await prisma.service.create({
        data: {
            ...data,
            slug
        }
    });
    return c.json(service, 201);
});

app.put('/services/:id', zValidator('json', z.object({
    name: z.string().optional(),
    description: z.string().optional(),
    hourlyRate: z.number().optional(),
    category: z.string().optional(),
})), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const id = c.req.param('id');
    const data = c.req.valid('json');
    const service = await prisma.service.update({
        where: { id },
        data,
    });
    return c.json(service);
});

// Visit Modification
app.patch('/visits/:id', zValidator('json', z.object({
    status: z.string().optional(),
    requestedStartAt: z.string().datetime().optional(),
    durationMinutes: z.number().optional(),
})), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const id = c.req.param('id');
    const data = c.req.valid('json');

    // Explicitly handle status enum casting if present
    const updateData: any = { ...data };
    if (data.status) {
        updateData.status = data.status as VisitStatus;
    }

    const visit = await prisma.visit.update({
        where: { id },
        data: updateData,
    });
    return c.json(visit);
});

app.delete('/visits/:id', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const id = c.req.param('id');
    await prisma.visit.delete({ where: { id } });
    return c.json({ success: true });
});

// Blog Management
app.get('/blog', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const posts = await prisma.blogPost.findMany({ orderBy: { createdAt: 'desc' } });
    return c.json(posts);
});

app.post('/blog', zValidator('json', z.object({
    title: z.string(),
    content: z.string(),
    slug: z.string(),
    status: z.string(),
})), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const data = c.req.valid('json');
    // Map content to contentHtml for now or adjust schema
    const post = await prisma.blogPost.create({
        data: {
            title: data.title,
            slug: data.slug,
            contentHtml: data.content,
            status: data.status
        }
    });
    return c.json(post, 201);
});

// FAQ Management
app.get('/faqs', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    // Assuming model name became fAQ or FAQ in generated client. 
    // Usually camelCase of ModelName. If model is FAQ, client property is fAQ or faq.
    // We will assume fAQ as per previous error hints.
    const faqs = await prisma.fAQ.findMany();
    return c.json(faqs);
});

app.post('/faqs', zValidator('json', z.object({
    question: z.string(),
    answer: z.string(),
    category: z.string(),
})), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const data = c.req.valid('json');
    const faq = await prisma.fAQ.create({ data });
    return c.json(faq, 201);
});

export default app;
