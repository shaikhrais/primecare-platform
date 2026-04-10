import { OpenAPIHono, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

type AppType = OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>;

// Schemas
export const ValidatePromoCodeSchema = z.object({
    code: z.string().min(1).max(50),
});

export const ApplyPromoCodeSchema = z.object({
    code: z.string().min(1).max(50),
});

export function registerSaaSPromoRoutes(app: AppType) {
    // Validate Promo Code
    app.post('/v1/saas/promo/validate', async (c) => {
        try {
            const body = await c.req.json() as any;
            const parsed = ValidatePromoCodeSchema.safeParse(body);
            if (!parsed.success) {
                return c.json({ error: 'Validation failed', details: parsed.error.flatten() }, 400);
            }

            const prisma = c.get('prisma');
            if (!prisma) {
                return c.json({ error: 'Database unavailable' }, 500);
            }

            // [SECURITY AUDIT] Extract tenantId directly from context (securely validated by Auth Middleware)
            // NEVER trust client-provided tenantId bodies for horizontal logic.
            const tenantId = c.get('tenantId' as any);
            if (!tenantId) {
                return c.json({ error: 'Tenant context required' }, 403);
            }

            const { code } = parsed.data;

            // Find valid promo code
            const promo = await prisma.promoCode.findUnique({
                where: { code },
            });

            if (!promo) {
                return c.json({ isValid: false, error: 'Promo code not found' }, 404);
            }

            if (!promo.isActive) {
                return c.json({ isValid: false, error: 'Promo code is inactive' }, 400);
            }

            if (promo.validUntil && promo.validUntil < new Date()) {
                return c.json({ isValid: false, error: 'Promo code expired' }, 400);
            }

            if (promo.maxUses && promo.currentUses >= promo.maxUses) {
                return c.json({ isValid: false, error: 'Promo code usage limit reached' }, 400);
            }

            return c.json({
                isValid: true,
                code: promo.code,
                discountPercent: promo.discountPercent,
                targetTier: promo.targetTier
            }, 200);

        } catch (e: any) {
            console.error('[SaaS.Promo] Validate Error:', e.message);
            return c.json({ error: 'Internal server error' }, 500);
        }
    });

    // Apply Promo Code
    app.post('/v1/saas/promo/apply', async (c) => {
        try {
            const body = await c.req.json() as any;
            const parsed = ApplyPromoCodeSchema.safeParse(body);
            if (!parsed.success) {
                return c.json({ error: 'Validation failed', details: parsed.error.flatten() }, 400);
            }

            const prisma = c.get('prisma');
            if (!prisma) {
                return c.json({ error: 'Database unavailable' }, 500);
            }

            // [SECURITY AUDIT] Prevent BOLA/Mass Assignment attacks
            const tenantId = c.get('tenantId' as any);
            if (!tenantId) {
                return c.json({ error: 'Tenant context required' }, 403);
            }

            const { code } = parsed.data;

            return await prisma.$transaction(async (tx: any) => {
                // Find and lock code conceptually
                const promo = await tx.promoCode.findUnique({
                    where: { code },
                });

                if (!promo || !promo.isActive || (promo.validUntil && promo.validUntil < new Date()) || (promo.maxUses && promo.currentUses >= promo.maxUses)) {
                    throw new Error('Promo code is invalid, expired, or fully used');
                }

                // Verify tenant
                const tenant = await tx.tenant.findUnique({ where: { id: tenantId } });
                if (!tenant) {
                    throw new Error('Tenant not found');
                }

                // Create the upgrade record
                const upgrade = await tx.subscriptionUpgrade.create({
                    data: {
                        tenantId: tenant.id,
                        promoCodeId: promo.id,
                        previousTier: tenant.subscriptionTier || 'FREE',
                        newTier: promo.targetTier || 'PREMIUM'
                    }
                });

                // Increment usage using optimistic concurrency check (Atomic condition) 
                const updatedPromo = await tx.promoCode.update({
                    where: { id: promo.id },
                    data: { currentUses: { increment: 1 } }
                });
                
                // Transaction rollback triggered securely if race condition surpassed limit
                if (promo.maxUses && updatedPromo.currentUses > promo.maxUses) {
                    throw new Error('Concurrency limit violation: Promo code usage limit reached');
                }

                // Update tenant tier
                await tx.tenant.update({
                    where: { id: tenant.id },
                    data: { subscriptionTier: promo.targetTier || 'PREMIUM' }
                });

                return c.json({
                    success: true,
                    upgrade,
                    message: 'Subscription successfully upgraded'
                }, 200);
            });

        } catch (e: any) {
            console.error('[SaaS.Promo] Apply Error:', e.message);
            return c.json({ success: false, error: e.message || 'Internal server error' }, 500);
        }
    });
}
