import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import Stripe from 'stripe';
import { Bindings, Variables } from '../bindings';
import { authMiddleware } from '../auth';
import { tenantMiddleware } from '../middleware/tenant';
import { logAudit } from '../utils/audit';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// Auth Middleware (Client only)
app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', tenantMiddleware());

// Schema
const PaymentIntentSchema = z.object({
    amount: z.number().min(100), // Minimum $1.00
    currency: z.string().default('cad'),
});

app.post('/create-payment-intent', zValidator('json', PaymentIntentSchema), async (c) => {
    const { amount, currency } = c.req.valid('json');

    if (!c.env.STRIPE_SECRET_KEY) {
        return c.json({ error: 'Stripe not configured' }, 500);
    }

    const stripe = new Stripe(c.env.STRIPE_SECRET_KEY, {
        apiVersion: '2026-01-28.clover', // Updated to match typedefs
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
        });
    } catch (error: any) {
        return c.json({ error: error.message }, 400);
    }
});

export default app;
