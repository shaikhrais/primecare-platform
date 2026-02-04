import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { PrismaClient, Role } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { generateToken } from './auth';
import clientApp from './routes/client';
import pswApp from './routes/psw';
// import adminApp from './routes/admin';

const LeadSchema = z.object({
    full_name: z.string().min(2),
    email: z.string().email(),
    phone: z.string().optional(),
    message: z.string().optional(),
    source: z.enum(['contact_form', 'book_consultation', 'careers']),
});

const LoginSchema = z.object({
    email: z.string().email(),
    password: z.string().min(8),
});

const RegisterSchema = z.object({
    email: z.string().email(),
    password: z.string().min(8),
    role: z.enum(['client', 'psw']),
});

type Bindings = {
    DATABASE_URL: string;
    JWT_SECRET: string;
    DOCS_BUCKET: R2Bucket;
};

const app = new Hono<{ Bindings: Bindings }>();

// Prisma middleware
const getPrisma = (database_url: string) => {
    return new PrismaClient({
        datasourceUrl: database_url,
    }).$extends(withAccelerate());
};

app.get('/v1/health', (c) => {
    return c.json({ status: 'ok', time: new Date().toISOString() });
});

/**
 * @openapi
 * /v1/auth/register:
 *   post:
 *     summary: Register a new user (Client or PSW)
 *     requestBody:
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *               role:
 *                 type: string
 *                 enum: [client, psw]
 *     responses:
 *       201:
 *         description: User created successfully
 *       400:
 *         description: User already exists
 */
app.post('/v1/auth/register', zValidator('json', RegisterSchema), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const { email, password, role } = c.req.valid('json');

    // Check if user exists
    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) return c.json({ error: 'User already exists' }, 400);

    // Hash password (simplified for now, recommend PBKDF2 in production)
    const passwordHash = password; // TODO: Implement proper hashing

    const user = await prisma.user.create({
        data: {
            email,
            passwordHash,
            role: role as Role,
        },
    });

    // Create profile based on role
    if (role === 'client') {
        await prisma.clientProfile.create({ data: { userId: user.id, fullName: email.split('@')[0] } });
    } else if (role === 'psw') {
        await prisma.pswProfile.create({ data: { userId: user.id, fullName: email.split('@')[0] } });
    }

    const token = await generateToken(user, c.env.JWT_SECRET || 'fallback_secret');
    return c.json({ user, token }, 201);
});

/**
 * @openapi
 * /v1/auth/login:
 *   post:
 *     summary: Login user and return JWT token
 *     requestBody:
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Login successful
 *       401:
 *         description: Invalid credentials
 */
app.post('/v1/auth/login', zValidator('json', LoginSchema), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const { email, password } = c.req.valid('json');

    const user = await prisma.user.findUnique({ where: { email } });
    if (!user || user.passwordHash !== password) {
        return c.json({ error: 'Invalid credentials' }, 401);
    }

    const token = await generateToken(user, c.env.JWT_SECRET || 'fallback_secret');
    return c.json({ user, token });
});

/**
 * @openapi
 * /v1/public/leads:
 *   post:
 *     summary: Submit a new lead (Contact Form)
 */
app.post('/v1/public/leads', zValidator('json', LeadSchema), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const data = c.req.valid('json');

    const lead = await prisma.lead.create({
        data: {
            fullName: data.full_name,
            email: data.email,
            phone: data.phone,
            message: data.message,
            source: data.source,
        },
    });

    return c.json(lead, 201);
});

/**
 * @openapi
 * /v1/public/services:
 *   get:
 *     summary: List all active services
 */
app.get('/v1/public/services', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const services = await prisma.service.findMany({ where: { isActive: true } });
    return c.json(services);
});

/**
 * @openapi
 * /v1/public/blog:
 *   get:
 *     summary: List published blog posts
 */
app.get('/v1/public/blog', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const posts = await prisma.blogPost.findMany({
        where: { status: 'published' },
        orderBy: { publishedAt: 'desc' },
    });
    return c.json(posts);
});

app.get('/v1/public/blog/:slug', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const slug = c.req.param('slug');
    const post = await prisma.blogPost.findUnique({
        where: { slug },
    });
    if (!post) return c.json({ error: 'Post not found' }, 404);
    return c.json(post);
});

app.get('/v1/openapi.yaml', async (c) => {
    return c.text('OpenAPI Spec placeholder');
});

// Mount Routes
app.route('/v1/client', clientApp);
app.route('/v1/psw', pswApp);
// app.route('/v1/admin', adminApp);

export default app;
