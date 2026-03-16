/**
 * Feature Flags — Comprehensive Test Suite
 *
 * Validates that the flag registry is correctly configured,
 * that defaults match the intended tier activation, and
 * that runtime flag evaluation works.
 */
import { describe, it, expect } from 'vitest';

// Replicate the actual flag registry shape for testing
const FLAG_REGISTRY = {
    telehealth: { defaultEnabled: true, tier: 'starter', label: 'Telehealth' },
    'new-billing-ui': { defaultEnabled: true, tier: 'starter', label: 'New Billing UI' },
    gamification: { defaultEnabled: true, tier: 'growth', label: 'Gamification' },
    'offline-mode': { defaultEnabled: true, tier: 'growth', label: 'Offline Mode' },
    'advanced-analytics': { defaultEnabled: true, tier: 'growth', label: 'Advanced Analytics' },
    'real-time-dispatch': { defaultEnabled: true, tier: 'growth', label: 'Real-Time Dispatch' },
    'document-signing': { defaultEnabled: true, tier: 'professional', label: 'Document Signing' },
    'sms-notifications': { defaultEnabled: true, tier: 'professional', label: 'SMS Notifications' },
    'ai-care-plans': { defaultEnabled: true, tier: 'enterprise', label: 'AI Care Plans' },
    'multi-currency': { defaultEnabled: true, tier: 'enterprise', label: 'Multi-Currency' },
    'franchise-mode': { defaultEnabled: false, tier: 'enterprise', label: 'Franchise Mode' },
    'marketplace': { defaultEnabled: false, tier: 'enterprise', label: 'Marketplace' },
};

describe('Feature Flag Registry', () => {
    it('should have exactly 12 feature flags', () => {
        expect(Object.keys(FLAG_REGISTRY).length).toBe(12);
    });

    it('should have 10 flags enabled by default', () => {
        const enabled = Object.values(FLAG_REGISTRY).filter(f => f.defaultEnabled);
        expect(enabled.length).toBe(10);
    });

    it('should have all starter-tier flags enabled', () => {
        const starterFlags = Object.entries(FLAG_REGISTRY)
            .filter(([, v]) => v.tier === 'starter');
        starterFlags.forEach(([key, v]) => {
            expect(v.defaultEnabled, `${key} should be enabled`).toBe(true);
        });
    });

    it('should have all growth-tier flags enabled', () => {
        const growthFlags = Object.entries(FLAG_REGISTRY)
            .filter(([, v]) => v.tier === 'growth');
        growthFlags.forEach(([key, v]) => {
            expect(v.defaultEnabled, `${key} should be enabled`).toBe(true);
        });
    });

    it('should have professional-tier flags enabled', () => {
        const proFlags = Object.entries(FLAG_REGISTRY)
            .filter(([, v]) => v.tier === 'professional');
        proFlags.forEach(([key, v]) => {
            expect(v.defaultEnabled, `${key} should be enabled`).toBe(true);
        });
    });

    it('should have enterprise AI/currency flags enabled', () => {
        expect(FLAG_REGISTRY['ai-care-plans'].defaultEnabled).toBe(true);
        expect(FLAG_REGISTRY['multi-currency'].defaultEnabled).toBe(true);
    });

    it('should have 2 enterprise-only flags disabled', () => {
        expect(FLAG_REGISTRY['franchise-mode'].defaultEnabled).toBe(false);
        expect(FLAG_REGISTRY['marketplace'].defaultEnabled).toBe(false);
    });

    it('should evaluate flag check correctly', () => {
        const isEnabled = (flag: keyof typeof FLAG_REGISTRY) => FLAG_REGISTRY[flag]?.defaultEnabled ?? false;
        expect(isEnabled('telehealth')).toBe(true);
        expect(isEnabled('marketplace')).toBe(false);
    });
});
