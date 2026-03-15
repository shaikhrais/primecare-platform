/**
 * UsageTracker & Services Tests
 *
 * Tests UsageTracker types, snapshot factory, storage constants,
 * and the service module structure.
 */
import { describe, it, expect } from 'vitest';
import {
    createEmptySnapshot, STORAGE_KEY, DB_SYNC_INTERVAL,
    type UsageSnapshot, type RouteVisit, type FormEntry, type ApiCall, type ClickEvent,
} from '@/shared/services/UsageTrackerTypes';

// ── UsageTracker Types ────────────────────────────────────────────────────

describe('UsageTrackerTypes', () => {
    describe('Constants', () => {
        it('STORAGE_KEY is pc_usage_stats', () => {
            expect(STORAGE_KEY).toBe('pc_usage_stats');
        });

        it('DB_SYNC_INTERVAL is 30 seconds', () => {
            expect(DB_SYNC_INTERVAL).toBe(30_000);
        });
    });

    describe('createEmptySnapshot', () => {
        it('returns an object', () => {
            const snapshot = createEmptySnapshot();
            expect(typeof snapshot).toBe('object');
        });

        it('has empty routes', () => {
            expect(createEmptySnapshot().routes).toEqual({});
        });

        it('has empty forms', () => {
            expect(createEmptySnapshot().forms).toEqual({});
        });

        it('has empty apiCalls', () => {
            expect(createEmptySnapshot().apiCalls).toEqual({});
        });

        it('has empty clicks', () => {
            expect(createEmptySnapshot().clicks).toEqual({});
        });

        it('has sessionStart as number', () => {
            const s = createEmptySnapshot();
            expect(typeof s.sessionStart).toBe('number');
            expect(s.sessionStart).toBeGreaterThan(0);
        });

        it('has totalSessions as 0', () => {
            expect(createEmptySnapshot().totalSessions).toBe(0);
        });

        it('has lastActivity as number', () => {
            const s = createEmptySnapshot();
            expect(typeof s.lastActivity).toBe('number');
            expect(s.lastActivity).toBeGreaterThan(0);
        });

        it('has totalClicks as 0', () => {
            expect(createEmptySnapshot().totalClicks).toBe(0);
        });

        it('has totalFormSubmits as 0', () => {
            expect(createEmptySnapshot().totalFormSubmits).toBe(0);
        });

        it('sessionStart is close to current time', () => {
            const before = Date.now();
            const s = createEmptySnapshot();
            const after = Date.now();
            expect(s.sessionStart).toBeGreaterThanOrEqual(before);
            expect(s.sessionStart).toBeLessThanOrEqual(after);
        });

        it('creates independent instances', () => {
            const a = createEmptySnapshot();
            const b = createEmptySnapshot();
            a.routes['test'] = { path: '/test', count: 1, lastVisit: 0, totalTimeMs: 0, maxScrollDepth: 0 };
            expect(b.routes['test']).toBeUndefined();
        });
    });

    describe('Type shape validation', () => {
        it('RouteVisit has all required fields', () => {
            const visit: RouteVisit = {
                path: '/dashboard', count: 5, lastVisit: Date.now(),
                totalTimeMs: 30000, maxScrollDepth: 85,
            };
            expect(visit.path).toBe('/dashboard');
            expect(visit.count).toBe(5);
            expect(visit.maxScrollDepth).toBe(85);
        });

        it('RouteVisit supports optional label', () => {
            const visit: RouteVisit = {
                path: '/visits', count: 1, lastVisit: 0,
                totalTimeMs: 0, maxScrollDepth: 0, label: 'Visits',
            };
            expect(visit.label).toBe('Visits');
        });

        it('FormEntry has all required fields', () => {
            const form: FormEntry = { formId: 'create-visit', count: 3, lastEntry: Date.now() };
            expect(form.formId).toBe('create-visit');
            expect(form.count).toBe(3);
        });

        it('ApiCall has all required fields', () => {
            const call: ApiCall = {
                endpoint: '/api/visits', method: 'GET',
                count: 42, lastCall: Date.now(), errors: 2,
            };
            expect(call.endpoint).toBe('/api/visits');
            expect(call.errors).toBe(2);
        });

        it('ClickEvent has all required fields', () => {
            const click: ClickEvent = {
                target: '#create-btn', count: 10,
                lastClick: Date.now(), elementType: 'button',
            };
            expect(click.elementType).toBe('button');
        });

        it('UsageSnapshot has all metric fields', () => {
            const snap: UsageSnapshot = createEmptySnapshot();
            expect(Object.keys(snap)).toEqual([
                'routes', 'forms', 'apiCalls', 'clicks',
                'sessionStart', 'totalSessions', 'lastActivity',
                'totalClicks', 'totalFormSubmits',
            ]);
        });
    });
});

// ── UsageTracker Service Module ───────────────────────────────────────────

describe('UsageTracker Service Module', () => {
    it('exports UsageTracker class', async () => {
        const mod = await import('@/shared/services/UsageTracker');
        expect(mod.UsageTracker).toBeDefined();
    });
});
