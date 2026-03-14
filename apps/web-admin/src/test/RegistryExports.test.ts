/**
 * Registry Exports Unit Tests
 *
 * Verifies that all registries are properly exported from the shared package
 * and contain expected data shapes.
 */
import { describe, it, expect } from 'vitest';
import {
    AdminRegistry,
    LinkRegistry,
    FormRegistry,
    getLinksForRole,
    getButtonsForPage,
} from 'prime-care-shared';

describe('Registry Exports', () => {
    // ── AdminRegistry ────────────────────────────────────────────────────
    describe('AdminRegistry', () => {
        it('should export RouteRegistry', () => {
            expect(AdminRegistry.RouteRegistry).toBeDefined();
            expect(AdminRegistry.RouteRegistry.LOGIN).toBeDefined();
            expect(AdminRegistry.RouteRegistry.ADMIN).toBeDefined();
        });

        it('should export ContentRegistry', () => {
            expect(AdminRegistry.ContentRegistry).toBeDefined();
        });
    });

    // ── LinkRegistry ─────────────────────────────────────────────────────
    describe('LinkRegistry', () => {
        it('should contain link entries', () => {
            expect(Array.isArray(LinkRegistry)).toBe(true);
            expect(LinkRegistry.length).toBeGreaterThan(30);
        });

        it('each link should have id, label, role, path', () => {
            LinkRegistry.forEach(link => {
                expect(link.id).toBeDefined();
                expect(link.label).toBeDefined();
                expect(link.role).toBeDefined();
                expect(link.path).toBeDefined();
            });
        });
    });

    // ── getLinksForRole() ────────────────────────────────────────────────
    describe('getLinksForRole()', () => {
        it('should return links for admin', () => {
            const adminLinks = getLinksForRole('admin');
            expect(adminLinks.length).toBeGreaterThan(5);
            expect(adminLinks.every(l => l.role === 'admin')).toBe(true);
        });

        it('should return links for psw', () => {
            const pswLinks = getLinksForRole('psw');
            expect(pswLinks.length).toBeGreaterThan(0);
            expect(pswLinks.every(l => l.role === 'psw')).toBe(true);
        });

        it('should return empty for unknown role', () => {
            expect(getLinksForRole('nonexistent')).toEqual([]);
        });
    });

    // ── FormRegistry ─────────────────────────────────────────────────────
    describe('FormRegistry', () => {
        it('should be importable', () => {
            expect(FormRegistry).toBeDefined();
        });
    });

    // ── getButtonsForPage() ──────────────────────────────────────────────
    describe('getButtonsForPage()', () => {
        it('should be a function', () => {
            expect(typeof getButtonsForPage).toBe('function');
        });
    });
});
