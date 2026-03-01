import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Blog List
const listBlogPostsRoute = createRoute({
    method: 'get',
    path: '/blog',
    summary: 'List Blog Posts',
    description: 'Retrieve a list of all blog posts.',
    tags: ['Admin Content'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of blog posts',
        },
    },
});

r.openapi(listBlogPostsRoute, async (c) => {
    const prisma = c.get('prisma');
    const posts = await prisma.blogPost.findMany({ orderBy: { createdAt: 'desc' } });
    return c.json(posts, 200);
});

// Create Blog Post
const createBlogPostRoute = createRoute({
    method: 'post',
    path: '/blog',
    summary: 'Create Blog Post',
    description: 'Add a new blog post to the platform.',
    tags: ['Admin Content'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        title: z.string(),
                        content: z.string(),
                        slug: z.string(),
                        status: z.string(),
                    }),
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
            description: 'Blog post created successfully',
        },
    },
});

r.openapi(createBlogPostRoute, async (c) => {
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
const listFaqsRoute = createRoute({
    method: 'get',
    path: '/faqs',
    summary: 'List FAQs',
    description: 'Retrieve a list of all frequently asked questions.',
    tags: ['Admin Content'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of FAQs',
        },
    },
});

r.openapi(listFaqsRoute, async (c) => {
    const prisma = c.get('prisma');
    const faqs = await prisma.fAQ.findMany();
    return c.json(faqs, 200);
});

// Create FAQ
const createFaqRoute = createRoute({
    method: 'post',
    path: '/faqs',
    summary: 'Create FAQ',
    description: 'Add a new FAQ entry.',
    tags: ['Admin Content'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        question: z.string(),
                        answer: z.string(),
                        category: z.string(),
                    }),
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
            description: 'FAQ created successfully',
        },
    },
});

r.openapi(createFaqRoute, async (c) => {
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
