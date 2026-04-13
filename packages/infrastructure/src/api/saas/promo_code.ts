import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

type AppType = OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>;

// Schemas
export const ValidatePromoCodeSchema = z.object({
    code: z.string().min(1).max(50),
});

export const ApplyPromoCodeSchema = z.object({
    code: z.string().min(1).max(50),
});

const ValidatePromoRoute = createRoute({
    method: 'post',
    path: '/v1/saas/promo/validate',
    summary: 'Validate Promo Code',
    request: {
        body: {
            content: {
                'application/json': { schema: ValidatePromoCodeSchema }
            }
        }
    },
    responses: {
        200: { description: 'Validation success' },
        400: { description: 'Invalid promo code' },
        403: { description: 'Forbidden' },
        404: { description: 'Promo code not found' },
        500: { description: 'Internal server error' }
    }
});

const ApplyPromoRoute = createRoute({
    method: 'post',
    path: '/v1/saas/promo/apply',
    summary: 'Apply Promo Code',
    request: {
        body: {
            content: {
                'application/json': { schema: ApplyPromoCodeSchema }
            }
        }
    },
    responses: {
        200: { description: 'Promo code applied' },
        400: { description: 'Invalid promo code' },
        403: { description: 'Forbidden' },
        500: { description: 'Internal server error' }
    }
});


export function registerSaaSPromoRoutes(app: AppType) {
    // Validate Promo Code
    app.openapi(ValidatePromoRoute, async (c) => {
        try {
            const parsed = c.req.valid('json');

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

            const { code } = parsed;

            // Find valid promo code scoped to tenant architecture
            // Promo codes can be global or tenant scoped. Assuming global codes apply.
            const promo = await prisma.promoCode.findUnique({
                where: { code }, // Promo codes are universally unique per their design
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
    app.openapi(ApplyPromoRoute, async (c) => {
        try {
            const parsed = c.req.valid('json');
            
            const prisma = c.get('prisma');
            if (!prisma) {
                return c.json({ error: 'Database unavailable' }, 500);
            }

            // [SECURITY AUDIT] Prevent BOLA/Mass Assignment attacks
            const tenantId = c.get('tenantId' as any);
            if (!tenantId) {
                return c.json({ error: 'Tenant context required' }, 403);
            }

            const { code } = parsed;

            return await prisma.$transaction(async (tx: any) => {
                // Find and lock code conceptually
                const promo = await tx.promoCode.findUnique({
                    where: { code },
                });

                if (!promo || !promo.isActive || (promo.validUntil && promo.validUntil < new Date()) || (promo.maxUses && promo.currentUses >= promo.maxUses)) {
                    throw new Error('Promo code is invalid, expired, or fully used');
                }

                // Verify tenant (Tenant isolation)
                const tenant = await tx.tenant.findUnique({ where: { id: tenantId } });
                if (!tenant) {
                    throw new Error('Tenant not found');
                }

                // Create the upgrade record with strictly scoped tenant
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

                // Update tenant tier scoped securely to the tenantId
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
            // DO NOT LEAK FULL ERROR
            return c.json({ success: false, error: 'Failed to apply promo code' }, 500);
        }
    });
}
