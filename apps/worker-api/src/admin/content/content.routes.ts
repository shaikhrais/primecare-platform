import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// Blog List
r.get('/blog', async (c) => {
    const prisma = c.get('prisma');
    const posts = await prisma.blogPost.findMany({ orderBy: { createdAt: 'desc' } });
    return c.json(posts);
});

// Create Blog Post
r.post('/blog', zValidator('json', z.object({
    title: z.string(),
    content: z.string(),
    slug: z.string(),
    status: z.string(),
})), async (c) => {
    const prisma = c.get('prisma');
    const data = c.req.valid('json');
    const post = await prisma.blogPost.create({
        data: {
            title: data.title,
            slug: data.slug,
            contentHtml: data.content,
            status: data.status,
            tenantId: c.get('jwtPayload').tenantId
        }
    });
    return c.json(post, 201);
});

// FAQ List
r.get('/faqs', async (c) => {
    const prisma = c.get('prisma');
    const faqs = await prisma.fAQ.findMany();
    return c.json(faqs);
});

// Create FAQ
r.post('/faqs', zValidator('json', z.object({
    question: z.string(),
    answer: z.string(),
    category: z.string(),
})), async (c) => {
    const prisma = c.get('prisma');
    const data = c.req.valid('json');
    const faq = await prisma.fAQ.create({
        data: {
            ...data,
            tenantId: c.get('jwtPayload').tenantId
        }
    });
    return c.json(faq, 201);
});

export default r;
