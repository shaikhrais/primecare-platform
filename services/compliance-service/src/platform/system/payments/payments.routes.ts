import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import Stripe from 'stripe';
import { Bindings, Variables } from '@primecare/shared-types';
import { logAudit } from '@primecare/shared-utils';
import { ROUTE_METADATA } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const PaymentIntentSchema = z.object({
    amount: z.number().min(100, 'Minimum amount is $1.00').max(5000000, 'Maximum amount is $50,000'),
    currency: z.string().default('cad'),
});

const createPaymentIntentRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.PAYMENT_INTENT,
    method: 'post',
    path: '/create-payment-intent',
    summary: 'Create Payment Intent',
    tags: ['System', 'Payments'],
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
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
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
        // R10: Don't leak Stripe internal error messages
        return c.json({ error: 'Payment processing failed. Please try again.' }, 400);
    }
});

export default r;
