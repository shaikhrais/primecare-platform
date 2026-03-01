import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import Stripe from 'stripe';
import { Bindings, Variables } from '../../../';
import { logAudit } from '../../../utils/audit';
import { ROUTE_METADATA } from '../../../constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const PaymentIntentSchema = z.object({
    amount: z.number().min(100),
    currency: z.string().default('cad'),
});

const createPaymentIntentRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.PAYMENT_INTENT,
    method: 'post',
    path: '/create-payment-intent',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: PaymentIntentSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientSecret: z.string().nullable(),
                    }),
                },
            },
            description: 'Payment intent created successfully',
        },
        400: {
            description: 'Bad request (Stripe error)',
        },
        500: {
            description: 'Server error (Stripe not configured)',
        },
    },
});

r.openapi(createPaymentIntentRoute, async (c) => {
    const { amount, currency } = c.req.valid('json');

    if (!c.env.STRIPE_SECRET_KEY) {
        return c.json({ error: 'Stripe not configured' }, 500);
    }

    const stripe = new Stripe(c.env.STRIPE_SECRET_KEY, {
        apiVersion: '2026-01-28.clover' as any,
    });

    try {
        const paymentIntent = await stripe.paymentIntents.create({
            amount,
            currency,
            automatic_payment_methods: {
                enabled: true,
            },
        });

        const payload = c.get('jwtPayload');
        const prisma = c.get('prisma');
        await logAudit(prisma, payload.sub, 'CREATE_PAYMENT_INTENT', 'PAYMENT', paymentIntent.id, { amount, currency });

        return c.json({
            clientSecret: paymentIntent.client_secret,
        }, 200);
    } catch (error: any) {
        return c.json({ error: error.message }, 400);
    }
});

export default r;
