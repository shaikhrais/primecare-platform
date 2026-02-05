import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { PrismaClient } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { generateToken } from './auth';
import { cors } from 'hono/cors';
import clientApp from './routes/client';
import pswApp from './routes/psw';
import adminApp from './routes/admin';
import paymentApp from './routes/payments';

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


import { DurableObject } from 'cloudflare:workers';

// Re-export Durable Object class so it can be found by Wrangler
export { ChatServer } from './durable_objects/ChatServer';

type Bindings = {
    DATABASE_URL: string;
    JWT_SECRET: string;
    DOCS_BUCKET: R2Bucket;
    CHAT_SERVER: DurableObjectNamespace;
};

const app = new Hono<{ Bindings: Bindings }>();

// Enable CORS for all routes
app.use('*', cors({
    origin: '*',
    allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowHeaders: ['Content-Type', 'Authorization'],
    exposeHeaders: ['Content-Length'],
    maxAge: 600,
    credentials: true,
}));

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
            role: role as any,
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
import storageApp from './routes/storage';
import notificationApp from './routes/notifications';
import voiceApp from './routes/voice';

app.route('/v1/client', clientApp);
app.route('/v1/psw', pswApp);
app.route('/v1/admin', adminApp);
app.route('/v1/storage', storageApp);
app.route('/v1/notifications', notificationApp);
app.route('/v1/voice', voiceApp);

// WebSocket and Chat Routes
app.get('/ws/chat', async (c) => {
    const upgradeHeader = c.req.header('Upgrade');
    if (!upgradeHeader || upgradeHeader !== 'websocket') {
        return c.text('Expected Upgrade: websocket', 426);
    }

    const userId = c.req.query('userId');
    if (!userId) {
        return c.text('Missing userId param', 400);
    }

    // Identify the Durable Object by userId (one DO per user/chat)
    const id = c.env.CHAT_SERVER.idFromName(userId);
    const stub = c.env.CHAT_SERVER.get(id);

    return stub.fetch(c.req.raw);
});

app.post('/webhook/n8n/chat', async (c) => {
    const { userId, message, type } = await c.req.json();

    if (!userId || !message) {
        return c.json({ error: 'Missing userId or message' }, 400);
    }

    const id = c.env.CHAT_SERVER.idFromName(userId);
    const stub = c.env.CHAT_SERVER.get(id);

    // Call the DO to broadcast/send message to the user
    await stub.fetch(new Request('https://worker/broadcast', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            message,
            sender: 'AI',
            type: type || 'text'
        })
    }));

    return c.json({ success: true });
});

export default app;
