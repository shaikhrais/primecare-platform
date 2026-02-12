import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import Stripe from 'stripe';
import { Bindings, Variables } from '../../bindings';
import { logAudit } from '../../utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const PaymentIntentSchema = z.object({
    amount: z.number().min(100),
    currency: z.string().default('cad'),
});

r.post('/create-payment-intent', zValidator('json', PaymentIntentSchema), async (c) => {
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
        });
    } catch (error: any) {
        return c.json({ error: error.message }, 400);
    }
});

export default r;
