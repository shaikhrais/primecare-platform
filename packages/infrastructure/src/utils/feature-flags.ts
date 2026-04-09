/**
 * Feature Flags System
 * Controls feature availability per tenant via database config.
 * Defaults to enabled for all features unless explicitly disabled.
 *
 * Usage in routes:
 *   if (!await isFeatureEnabled(prisma, tenantId, 'real_time_chat')) {
 *     return apiResponse.error(c, 'Feature not available', 403);
 *   }
 *
 * Usage in frontend (via API):
 *   const flags = await apiClient.get('/v1/features');
 */

// Default feature flags — all enabled unless overridden per tenant
const DEFAULT_FLAGS: Record<string, boolean> = {
    real_time_chat: true,
    telehealth: true,
    billing: true,
    compliance_home: true,
    sos_alerts: true,
    dispatch_map: true,
    knowledge_base: true,
    training_modules: true,
    advanced_reporting: true,
    api_webhooks: false,         // opt-in
    multi_currency: false,       // opt-in
    data_export: true,
    impersonation: true,
    digital_property_manager: true,
};

/**
 * Check if a feature is enabled for a specific tenant.
 * Reads from TenantConfig table, falls back to defaults.
 */
export async function isFeatureEnabled(
    prisma: any,
    tenantId: string,
    featureKey: string
): Promise<boolean> {
    try {
        // Check tenant-specific override
        const config = await prisma.tenantConfig?.findFirst?.({
            where: { tenantId, key: `feature:${featureKey}` },
        });

        if (config) {
            return config.value === 'true' || config.value === '1';
        }
    } catch {
        // TenantConfig table might not exist — fall through to defaults
    }

    // Fall back to global defaults
    return DEFAULT_FLAGS[featureKey] ?? true;
}

/**
 * Get all feature flags for a tenant (used by frontend).
 */
export async function getAllFeatureFlags(
    prisma: any,
    tenantId: string
): Promise<Record<string, boolean>> {
    const flags = { ...DEFAULT_FLAGS };

    try {
        const overrides = await prisma.tenantConfig?.findMany?.({
            where: { tenantId, key: { startsWith: 'feature:' } },
        });

        if (overrides) {
            for (const override of overrides) {
                const key = override.key.replace('feature:', '');
                flags[key] = override.value === 'true' || override.value === '1';
            }
        }
    } catch {
        // TenantConfig table might not exist — return defaults
    }

    return flags;
}

/**
 * Middleware to check feature flags before route execution.
 */
export function requireFeature(featureKey: string) {
    return async (c: any, next: any) => {
        const tenantId = c.get('tenantId') || c.get('jwtPayload')?.tenantId;
        if (!tenantId) {
            return c.json({ error: 'Tenant context required' }, 403);
        }

        const prisma = c.get('prisma');
        const enabled = await isFeatureEnabled(prisma, tenantId, featureKey);

        if (!enabled) {
            return c.json({
                error: 'Feature Not Available',
                message: `The "${featureKey}" feature is not enabled for your organization.`,
            }, 403);
        }

        await next();
    };
}
