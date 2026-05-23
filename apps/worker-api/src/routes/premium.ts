// Governance - Category: middleware | Purpose: Extract index, e.g., feature-1 -> 1 Extract tenantId from jwtPayload or fallback
import { Hono } from 'hono';

export const premiumRouter = new Hono();

premiumRouter.get('/:featureId', async (c) => {
  const featureId = c.req.param('featureId'); // e.g., 'feature-1'
  const prisma = (c as any).get('prisma') as any;
  
  // Extract index, e.g., feature-1 -> 1
  const featureIndex = featureId.split('-').pop();
  const screenId = `SCREEN_PREMIUM_FEATURE_${featureIndex}`;
  
  // Extract tenantId from jwtPayload or fallback
  const payload = (c as any).get('jwtPayload');
  const tenantId = payload?.tenantId || 'default_tenant';

  if (prisma) {
    try {
      const status = await prisma.premiumFeatureStatus.findUnique({
        where: {
          tenantId_screenId: {
            tenantId,
            screenId
          }
        }
      });
      
      return c.json({
        screenId,
        featureName: `PremiumFeature${featureIndex}`,
        status: status?.isActive ? 'active' : 'inactive',
        data: {
          message: `Hydrated data for Premium Feature ${featureIndex} from database`,
          usageCount: status?.usageCount || 0,
          metadata: status?.metadata || null
        }
      });
    } catch (e: any) {
      console.error('[PREMIUM_FEATURE_ERROR]', e.message);
    }
  }

  // Fallback if Prisma is unavailable or query fails
  return c.json({
    screenId,
    featureName: `PremiumFeature${featureIndex}`,
    status: 'active',
    data: {
      message: `Hydrated data for Premium Feature ${featureIndex} (Fallback)`
    }
  });
});
