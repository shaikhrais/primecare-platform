import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';

const engagement = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /v1/client/engagement/feed
engagement.openapi(
    createRoute({
        ...ROUTE_METADATA.CLIENT.FAMILY_FEED,
        method: 'get',
        path: '/feed',
        responses: {
            200: {
                description: 'Success',
                content: {
                    'application/json': {
                        schema: z.object({
                            notifications: z.array(z.any()),
                            visits: z.array(z.any()),
                        }),
                    },
                },
            },
            404: {
                description: 'Profile not found',
                content: {
                    'application/json': {
                        schema: z.object({
                            error: z.string(),
                        }),
                    },
                },
            },
        },
    }),
    async (c) => {
        const prisma = c.get('prisma');
        const jwt = c.get('jwtPayload') as any;
        const userId = jwt.sub;
        const tenantId = jwt.tenantId;

        const clientProfile = await prisma.clientProfile.findUnique({
            where: { userId },
        });

        if (!clientProfile) {
            return c.json({ error: 'Client profile not found' }, 404);
        }

        const [notifications, visits] = await Promise.all([
            prisma.familyNotification.findMany({
                where: { clientId: clientProfile.id, tenantId },
                orderBy: { createdAt: 'desc' },
                take: 20,
            }),
            prisma.visit.findMany({
                where: { clientId: clientProfile.id, tenantId },
                include: {
                    psw: { select: { fullName: true, avatarUrl: true } },
                    service: { select: { name: true } }
                },
                orderBy: { requestedStartAt: 'desc' },
                take: 10,
            })
        ]);

        return c.json({ notifications, visits }, 200) as any;
    }
);

// POST /v1/client/engagement/feedback
engagement.openapi(
    createRoute({
        ...ROUTE_METADATA.CLIENT.FEEDBACK_SUBMIT,
        method: 'post',
        path: '/feedback',
        request: {
            body: {
                content: {
                    'application/json': {
                        schema: z.object({
                            visitId: z.string(),
                            rating: z.number().min(1).max(5),
                            comment: z.string().optional(),
                        }),
                    },
                },
            },
        },
        responses: {
            201: {
                description: 'Feedback submitted',
                content: {
                    'application/json': {
                        schema: z.object({
                            success: z.boolean(),
                        }),
                    },
                },
            },
            404: {
                description: 'Profile not found',
                content: {
                    'application/json': {
                        schema: z.object({
                            error: z.string(),
                        }),
                    },
                },
            },
        },
    }),
    async (c) => {
        const prisma = c.get('prisma');
        const body = c.req.valid('json');
        const jwt = c.get('jwtPayload') as any;
        const userId = jwt.sub;
        const tenantId = jwt.tenantId;

        const clientProfile = await prisma.clientProfile.findUnique({
            where: { userId },
        });

        if (!clientProfile) {
            return c.json({ error: 'Client profile not found' }, 404);
        }

        await prisma.careFeedback.create({
            data: {
                clientId: clientProfile.id,
                visitId: body.visitId,
                rating: body.rating,
                comment: body.comment,
                tenantId,
            },
        });

        return c.json({ success: true }, 201) as any;
    }
);

// POST /v1/client/engagement/pay-invoice
engagement.openapi(
    createRoute({
        ...ROUTE_METADATA.CLIENT.INVOICE_PAY,
        method: 'post',
        path: '/pay-invoice',
        request: {
            body: {
                content: {
                    'application/json': {
                        schema: z.object({
                            invoiceId: z.string(),
                        }),
                    },
                },
            },
        },
        responses: {
            200: {
                description: 'Payment initiated',
                content: {
                    'application/json': {
                        schema: z.object({
                            message: z.string(),
                        }),
                    },
                },
            },
        },
    }),
    async (c) => {
        const body = c.req.valid('json');
        // In a real app, this would integrate with Stripe
        return c.json({ message: 'Payment flow initiated for invoice ' + body.invoiceId }, 200) as any;
    }
);

export default engagement;
