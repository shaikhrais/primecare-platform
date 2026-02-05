import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import Stripe from 'stripe';
import { Bindings } from '../bindings';
import { authMiddleware } from '../auth';

const app = new Hono<{ Bindings: Bindings }>();

// Auth Middleware (Client only)
app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});

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

        return c.json({
            clientSecret: paymentIntent.client_secret,
        });
    } catch (error: any) {
        return c.json({ error: error.message }, 400);
    }
});

export default app;
