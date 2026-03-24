/**
 * Feature Flag System — Per-tenant runtime feature control
 *
 * Enables gradual rollout, A/B testing, and kill-switches.
 * Flags can be set at tenant level (DB) or global level (env vars).
 *
 * Usage:
 *   const { isEnabled } = useFeatureFlag('telehealth');
 *   if (isEnabled) return <TelehealthHome />;
 *
 *   <FeatureGate flag="new-billing-ui">
 *       <NewBillingUI />
 *   </FeatureGate>
 */
import React, { createContext, useContext, useMemo, type ReactNode } from 'react';
import { useAuthStore } from '@/shared/stores';

// ── Flag Definitions ──────────────────────────────────────────────────────

export type FeatureFlagName =
    | 'telehealth'
    | 'new-billing-ui'
    | 'ai-care-plans'
    | 'gamification'
    | 'dark-mode'
    | 'offline-mode'
    | 'advanced-analytics'
    | 'client-portal'
    | 'real-time-dispatch'
    | 'document-signing'
    | 'multi-currency'
    | 'sms-notifications';

interface FeatureFlagConfig {
    /** Default enabled state */
    defaultEnabled: boolean;
    /** Roles that can access (empty = all roles) */
    allowedRoles?: string[];
    /** Minimum tenant tier (free/starter/pro/enterprise) */
    minTier?: string;
    /** Description for admin panel */
    description: string;
}

// ── Flag Registry ─────────────────────────────────────────────────────────

export const FLAG_REGISTRY: Record<FeatureFlagName, FeatureFlagConfig> = {
    'telehealth': {
        defaultEnabled: true,
        allowedRoles: ['admin', 'manager', 'rn'],
        minTier: 'pro',
        description: 'Video consultations and remote health monitoring',
    },
    'new-billing-ui': {
        defaultEnabled: true,
        allowedRoles: ['admin', 'finance'],
        description: 'Redesigned billing and invoicing interface',
    },
    'ai-care-plans': {
        defaultEnabled: false,
        allowedRoles: ['admin', 'manager', 'rn'],
        minTier: 'enterprise',
        description: 'AI-generated personalized care plans (requires enterprise tier)',
    },
    'gamification': {
        defaultEnabled: true,
        description: 'PSW achievement badges, leaderboards, streaks',
    },
    'dark-mode': {
        defaultEnabled: true,
        description: 'Dark mode theme toggle',
    },
    'offline-mode': {
        defaultEnabled: true,
        allowedRoles: ['psw', 'rn'],
        description: 'PWA offline caching for field workers',
    },
    'advanced-analytics': {
        defaultEnabled: true,
        allowedRoles: ['admin', 'manager', 'finance'],
        minTier: 'pro',
        description: 'AI-powered analytics homes and forecasting',
    },
    'client-portal': {
        defaultEnabled: true,
        allowedRoles: ['client'],
        description: 'Client self-service portal access',
    },
    'real-time-dispatch': {
        defaultEnabled: true,
        allowedRoles: ['admin', 'coordinator', 'manager'],
        minTier: 'pro',
        description: 'Live map dispatch with GPS tracking',
    },
    'document-signing': {
        defaultEnabled: true,
        minTier: 'pro',
        description: 'Digital document signing (e-signatures)',
    },
    'multi-currency': {
        defaultEnabled: false,
        allowedRoles: ['admin', 'finance'],
        minTier: 'enterprise',
        description: 'Multi-currency billing and international payments (requires enterprise tier)',
    },
    'sms-notifications': {
        defaultEnabled: true,
        minTier: 'starter',
        description: 'SMS notification delivery channel',
    },
};

// ── Context ───────────────────────────────────────────────────────────────

interface FeatureFlagContextValue {
    isEnabled: (flag: FeatureFlagName) => boolean;
    getEnabledFlags: () => FeatureFlagName[];
    overrides: Partial<Record<FeatureFlagName, boolean>>;
}

const FeatureFlagContext = createContext<FeatureFlagContextValue>({
    isEnabled: () => false,
    getEnabledFlags: () => [],
    overrides: {},
});

// ── Provider ──────────────────────────────────────────────────────────────

interface FeatureFlagProviderProps {
    children: ReactNode;
    /** Server-side overrides (from tenant settings API) */
    overrides?: Partial<Record<FeatureFlagName, boolean>>;
}

export const FeatureFlagProvider: React.FC<FeatureFlagProviderProps> = ({ children, overrides = {} }) => {
    const activeRole = useAuthStore((s) => s.user?.activeRole);

    const value = useMemo<FeatureFlagContextValue>(() => ({
        isEnabled: (flag: FeatureFlagName) => {
            // 1. Check explicit override
            if (overrides[flag] !== undefined) return overrides[flag]!;

            // 2. Check flag registry
            const config = FLAG_REGISTRY[flag];
            if (!config) return false;

            // 3. Check role restriction
            if (config.allowedRoles && activeRole && !config.allowedRoles.includes(activeRole)) {
                return false;
            }

            // 4. Return default
            return config.defaultEnabled;
        },
        getEnabledFlags: () => {
            return (Object.keys(FLAG_REGISTRY) as FeatureFlagName[]).filter(flag => {
                if (overrides[flag] !== undefined) return overrides[flag];
                const config = FLAG_REGISTRY[flag];
                if (config.allowedRoles && activeRole && !config.allowedRoles.includes(activeRole)) return false;
                return config.defaultEnabled;
            });
        },
        overrides,
    }), [overrides, activeRole]);

    return <FeatureFlagContext.Provider value={value}>{children}</FeatureFlagContext.Provider>;
};

// ── Hooks ─────────────────────────────────────────────────────────────────

export function useFeatureFlag(flag: FeatureFlagName) {
    const ctx = useContext(FeatureFlagContext);
    return {
        isEnabled: ctx.isEnabled(flag),
        config: FLAG_REGISTRY[flag],
    };
}

export function useFeatureFlags() {
    return useContext(FeatureFlagContext);
}

// ── Guard Component ───────────────────────────────────────────────────────

interface FeatureGateProps {
    flag: FeatureFlagName;
    children: ReactNode;
    fallback?: ReactNode;
}

/** Conditionally renders children based on feature flag */
export const FeatureGate: React.FC<FeatureGateProps> = ({ flag, children, fallback = null }) => {
    const { isEnabled } = useFeatureFlag(flag);
    return <>{isEnabled ? children : fallback}</>;
};

export default FeatureFlagProvider;
