/**
 * Shared Package API Surface — Comprehensive Export Tests
 *
 * Tests the prime-care-shared AdminRegistry, including all sub-registries,
 * route configurations, API paths, and type exports.
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Import the shared package
// ═══════════════════════════════════════════════════════════════════════════

let AdminRegistry: any;
let PageRegistry: any;
let ApiRegistry: any;
let RouteRegistry: any;

describe('SharedPackage AdminRegistry', () => {
    it('imports successfully', async () => {
        const mod: any = await import('prime-care-shared');
        AdminRegistry = mod.AdminRegistry;
        expect(AdminRegistry).toBeDefined();
    });

    it('has PageRegistry', async () => {
        const mod: any = await import('prime-care-shared');
        PageRegistry = mod.AdminRegistry.PageRegistry;
        expect(PageRegistry).toBeDefined();
    });

    it('has ApiRegistry', async () => {
        const mod: any = await import('prime-care-shared');
        ApiRegistry = mod.AdminRegistry.ApiRegistry;
        expect(ApiRegistry).toBeDefined();
    });

    it('has RouteRegistry', async () => {
        const mod: any = await import('prime-care-shared');
        RouteRegistry = mod.AdminRegistry.RouteRegistry;
        expect(RouteRegistry).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// RouteRegistry Paths
// ═══════════════════════════════════════════════════════════════════════════

describe('RouteRegistry Critical Paths', () => {
    it('has LOGIN route', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(AdminRegistry.RouteRegistry.LOGIN).toBeDefined();
        expect(typeof AdminRegistry.RouteRegistry.LOGIN).toBe('string');
    });

    it('has REGISTER route', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(AdminRegistry.RouteRegistry.REGISTER).toBeDefined();
    });

    it('RouteRegistry LOGIN is a string path', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(AdminRegistry.RouteRegistry.LOGIN.startsWith('/')).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// ApiRegistry Auth Paths
// ═══════════════════════════════════════════════════════════════════════════

describe('ApiRegistry Auth Paths', () => {
    it('has AUTH namespace', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(AdminRegistry.ApiRegistry.AUTH).toBeDefined();
    });

    it('has AUTH.LOGIN path', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(AdminRegistry.ApiRegistry.AUTH.LOGIN).toBeDefined();
        expect(typeof AdminRegistry.ApiRegistry.AUTH.LOGIN).toBe('string');
    });

    it('has AUTH.REFRESH path', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(AdminRegistry.ApiRegistry.AUTH.REFRESH).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Additional Data Types Validation
// ═══════════════════════════════════════════════════════════════════════════

describe('Shared Package Type Integrity', () => {
    it('AdminRegistry is an object', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(typeof AdminRegistry).toBe('object');
    });

    it('AdminRegistry has multiple keys', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(Object.keys(AdminRegistry).length).toBeGreaterThan(2);
    });

    it('RouteRegistry has multiple routes', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(Object.keys(AdminRegistry.RouteRegistry).length).toBeGreaterThan(3);
    });

    it('ApiRegistry has multiple namespaces', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(Object.keys(AdminRegistry.ApiRegistry).length).toBeGreaterThan(1);
    });
});
