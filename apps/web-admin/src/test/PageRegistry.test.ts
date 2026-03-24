/**
 * PageRegistry Unit Tests
 *
 * Validates the PageRegistry: page entries have required fields,
 * type/owner distributions are healthy, lookup helpers work correctly,
 * and no duplicate IDs or category codes exist.
 */
import { describe, it, expect } from 'vitest';
import {
    PageRegistry, getPageById, getPagesByType, getPagesByOwner,
    getPageTypeStats, getMasterList, MASTER_REGISTRY, MASTER_REGISTRY_COUNT,
    PAGE_REGISTRY_COUNT, DashboardRegistry, ListRegistry, HubRegistry,
} from 'prime-care-shared';

describe('PageRegistry', () => {
    // ── Structural Validation ─────────────────────────────────────────────
    describe('structural validation', () => {
        it('should contain at least 100 pages', () => {
            expect(PAGE_REGISTRY_COUNT).toBeGreaterThanOrEqual(100);
        });

        it('every page should have required fields', () => {
            PageRegistry.forEach((page, i) => {
                expect(page.id, `Page #${i} missing id`).toBeDefined();
                expect(page.label, `Page ${page.id} missing label`).toBeDefined();
                expect(page.route, `Page ${page.id} missing route`).toBeDefined();
                expect(page.type, `Page ${page.id} missing type`).toBeDefined();
                expect(page.owner, `Page ${page.id} missing owner`).toBeDefined();
                expect(page.srNo, `Page ${page.id} missing srNo`).toBeDefined();
                expect(page.categoryCode, `Page ${page.id} missing categoryCode`).toBeDefined();
            });
        });

        it('should have no duplicate page IDs', () => {
            const ids = PageRegistry.map(p => p.id);
            const dupes = ids.filter((id, i) => ids.indexOf(id) !== i);
            expect(dupes).toEqual([]);
        });

        it('should have no duplicate category codes', () => {
            const codes = PageRegistry.map(p => p.categoryCode);
            const dupes = codes.filter((c, i) => codes.indexOf(c) !== i);
            expect(dupes).toEqual([]);
        });

        it('every route should start with /', () => {
            PageRegistry.forEach(page => {
                expect(page.route.startsWith('/'), `Page ${page.id} route "${page.route}" should start with /`).toBe(true);
            });
        });
    });

    // ── Type Distribution ─────────────────────────────────────────────────
    describe('type distribution', () => {
        it('should have pages of every type', () => {
            const stats = getPageTypeStats();
            const types = ['home', 'form', 'list', 'hub', 'tool'];
            types.forEach(type => {
                expect(stats[type as keyof typeof stats], `No pages of type: ${type}`).toBeGreaterThan(0);
            });
        });

        it('should have more than 5 homes', () => {
            expect(getPagesByType('home').length).toBeGreaterThan(5);
        });

        it('should have more than 10 forms', () => {
            expect(getPagesByType('form').length).toBeGreaterThanOrEqual(10);
        });
    });

    // ── Owner Coverage ────────────────────────────────────────────────────
    describe('owner coverage', () => {
        const requiredOwners = ['admin', 'psw', 'rn', 'coordinator', 'client', 'manager'];

        requiredOwners.forEach(owner => {
            it(`should have pages owned by ${owner}`, () => {
                const pages = getPagesByOwner(owner as any);
                expect(pages.length, `No pages owned by ${owner}`).toBeGreaterThan(0);
            });
        });
    });

    // ── Lookup Helpers ────────────────────────────────────────────────────
    describe('lookup helpers', () => {
        it('getPageById should return a page', () => {
            const firstPage = PageRegistry[0];
            const found = getPageById(firstPage.id);
            expect(found).toBeDefined();
            expect(found!.id).toBe(firstPage.id);
        });

        it('getPageById should return undefined for unknown ID', () => {
            expect(getPageById('nonexistent-page')).toBeUndefined();
        });

        it('getMasterList should return same count as PageRegistry', () => {
            const list = getMasterList();
            expect(list.length).toBe(PAGE_REGISTRY_COUNT);
        });
    });

    // ── Master Registry ───────────────────────────────────────────────────
    describe('MASTER_REGISTRY', () => {
        it('should have entries', () => {
            expect(MASTER_REGISTRY_COUNT).toBeGreaterThan(50);
        });

        it('every master entry should have file, label, type, owner', () => {
            Object.entries(MASTER_REGISTRY).forEach(([code, entry]) => {
                expect(entry.file, `${code} missing file`).toBeDefined();
                expect(entry.label, `${code} missing label`).toBeDefined();
                expect(entry.type, `${code} missing type`).toBeDefined();
                expect(entry.owner, `${code} missing owner`).toBeDefined();
            });
        });
    });

    // ── Sub-Registries ────────────────────────────────────────────────────
    describe('sub-registries', () => {
        it('DashboardRegistry should have entries', () => {
            expect(DashboardRegistry.length).toBeGreaterThan(3);
        });

        it('every home should have statsEndpoints and widgets', () => {
            DashboardRegistry.forEach(dash => {
                expect(Array.isArray(dash.statsEndpoints), `Home ${dash.id} missing statsEndpoints`).toBe(true);
                expect(Array.isArray(dash.widgets), `Home ${dash.id} missing widgets`).toBe(true);
            });
        });

        it('ListRegistry should have entries', () => {
            expect(ListRegistry.length).toBeGreaterThan(3);
        });

        it('every list should have fetchEndpoint and columns', () => {
            ListRegistry.forEach(list => {
                expect(list.fetchEndpoint, `List ${list.id} missing fetchEndpoint`).toBeDefined();
                expect(Array.isArray(list.columns), `List ${list.id} missing columns`).toBe(true);
            });
        });

        it('HubRegistry should have entries', () => {
            expect(HubRegistry.length).toBeGreaterThan(3);
        });
    });
});
