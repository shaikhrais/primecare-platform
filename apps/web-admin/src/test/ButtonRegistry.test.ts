/**
 * ButtonRegistry Unit Tests
 *
 * Validates the unified ButtonRegistry: entry counts, type distribution,
 * role coverage, helper functions, backward-compatible aliases,
 * and ButtonGroups/ButtonsByPage derived structures.
 */
import { describe, it, expect } from 'vitest';
import {
    ButtonRegistry, LinkRegistry, InteractionARegistry, InteractiveElementRegistry,
    ButtonGroups, ButtonsByPage, BUTTON_REGISTRY_COUNT,
    getButtonById, getButtonsByRole, getButtonsByModule,
    getLinksForRole, getTouchpointsForSweep, getInteractionsByTrigger,
    getButtonsForPage,
} from 'prime-care-shared';

describe('ButtonRegistry', () => {
    // ── Entry Counts ──────────────────────────────────────────────────────
    describe('entry counts', () => {
        it('should contain at least 200 buttons', () => {
            expect(BUTTON_REGISTRY_COUNT).toBeGreaterThanOrEqual(200);
        });

        it('total should equal sum of sub-arrays', () => {
            const linkCount = LinkRegistry.length;
            const interactionCount = InteractionARegistry.length;
            const touchpointCount = InteractiveElementRegistry.length;
            // Platform, Tenancy, Operations buttons make up the rest
            expect(BUTTON_REGISTRY_COUNT).toBeGreaterThanOrEqual(
                linkCount + interactionCount + touchpointCount
            );
        });
    });

    // ── Structural Validation ─────────────────────────────────────────────
    describe('structural validation', () => {
        it('every button should have id, label, role, module, type', () => {
            ButtonRegistry.forEach((btn, i) => {
                expect(btn.id, `Button #${i} missing id`).toBeDefined();
                expect(btn.label, `Button ${btn.id} missing label`).toBeDefined();
                expect(btn.role, `Button ${btn.id} missing role`).toBeDefined();
                expect(btn.module, `Button ${btn.id} missing module`).toBeDefined();
                expect(btn.type, `Button ${btn.id} missing type`).toBeDefined();
            });
        });

        it('should have no duplicate button IDs', () => {
            const ids = ButtonRegistry.map(b => b.id);
            const dupes = ids.filter((id, i) => ids.indexOf(id) !== i);
            expect(dupes).toEqual([]);
        });

        it('every type should be valid', () => {
            const validTypes = ['primary', 'secondary', 'ghost', 'danger', 'link', 'interaction', 'touchpoint'];
            ButtonRegistry.forEach(btn => {
                expect(validTypes.includes(btn.type), `Button ${btn.id} has invalid type: ${btn.type}`).toBe(true);
            });
        });
    });

    // ── Type Distribution ─────────────────────────────────────────────────
    describe('type distribution', () => {
        it('should have link-type buttons', () => {
            const links = ButtonRegistry.filter(b => b.type === 'link');
            expect(links.length).toBeGreaterThan(30);
        });

        it('should have interaction-type buttons', () => {
            const interactions = ButtonRegistry.filter(b => b.type === 'interaction');
            expect(interactions.length).toBeGreaterThan(5);
        });

        it('should have touchpoint-type buttons', () => {
            const touchpoints = ButtonRegistry.filter(b => b.type === 'touchpoint');
            expect(touchpoints.length).toBeGreaterThan(5);
        });

        it('should have primary/secondary/ghost action buttons', () => {
            const actions = ButtonRegistry.filter(b => ['primary', 'secondary', 'ghost', 'danger'].includes(b.type));
            expect(actions.length).toBeGreaterThan(10);
        });
    });

    // ── Role Coverage ────────────────────────────────────────────────────
    describe('role coverage', () => {
        const coreRoles = ['admin', 'psw', 'rn', 'coordinator', 'client', 'manager', 'scrum_master'];

        coreRoles.forEach(role => {
            it(`should have buttons for ${role}`, () => {
                const buttons = getButtonsByRole(role);
                expect(buttons.length, `No buttons for role: ${role}`).toBeGreaterThan(0);
            });
        });
    });

    // ── Lookup Helpers ────────────────────────────────────────────────────
    describe('lookup helpers', () => {
        it('getButtonById should find a button', () => {
            const btn = getButtonById('lnk-admin-users');
            expect(btn).toBeDefined();
            expect(btn!.label).toBeDefined();
            expect(btn!.role).toBe('admin');
        });

        it('getButtonById returns undefined for unknown ID', () => {
            expect(getButtonById('nonexistent-button')).toBeUndefined();
        });

        it('getButtonsByModule should return buttons', () => {
            const adminButtons = getButtonsByModule('ADMIN');
            expect(adminButtons.length).toBeGreaterThan(5);
        });

        it('getTouchpointsForSweep returns touchpoints', () => {
            const touchpoints = getTouchpointsForSweep();
            expect(touchpoints.length).toBeGreaterThan(10);
            touchpoints.forEach(tp => {
                expect(tp.type).toBe('touchpoint');
            });
        });

        it('getInteractionsByTrigger returns click interactions', () => {
            const clicks = getInteractionsByTrigger('click');
            expect(clicks.length).toBeGreaterThan(3);
            clicks.forEach(ia => {
                expect(ia.trigger).toBe('click');
            });
        });

        it('getInteractionsByTrigger returns submit interactions', () => {
            const submits = getInteractionsByTrigger('submit');
            expect(submits.length).toBeGreaterThan(0);
        });
    });

    // ── Backward Compatibility ────────────────────────────────────────────
    describe('backward compatibility', () => {
        it('LinkRegistry should be the same as type=link buttons', () => {
            LinkRegistry.forEach(link => {
                expect(link.type).toBe('link');
            });
        });

        it('InteractionARegistry should be type=interaction buttons', () => {
            InteractionARegistry.forEach(ia => {
                expect(ia.type).toBe('interaction');
            });
        });

        it('InteractiveElementRegistry should be type=touchpoint buttons', () => {
            InteractiveElementRegistry.forEach(tp => {
                expect(tp.type).toBe('touchpoint');
            });
        });
    });

    // ── Derived: ButtonGroups ────────────────────────────────────────────
    describe('ButtonGroups (role→module→buttons)', () => {
        it('should have an admin group', () => {
            expect(ButtonGroups['admin']).toBeDefined();
        });

        it('admin group should have modules', () => {
            const adminModules = Object.keys(ButtonGroups['admin'] || {});
            expect(adminModules.length).toBeGreaterThan(3);
        });
    });

    // ── Derived: ButtonsByPage ────────────────────────────────────────────
    describe('ButtonsByPage', () => {
        it('should be a non-empty object', () => {
            expect(Object.keys(ButtonsByPage).length).toBeGreaterThan(0);
        });

        it('every page should map to at least one button', () => {
            Object.entries(ButtonsByPage).forEach(([pageId, buttons]) => {
                expect(buttons.length, `${pageId} has no buttons`).toBeGreaterThan(0);
            });
        });
    });

    // ── Link Path Validity ──────────────────────────────────────────────
    describe('link path validity', () => {
        it('every link should have a valid path starting with /', () => {
            LinkRegistry.forEach(link => {
                expect(link.path, `Link ${link.id} missing path`).toBeDefined();
                expect(link.path!.startsWith('/'), `Link ${link.id} path "${link.path}" invalid`).toBe(true);
            });
        });
    });

    // ── Touchpoint Validation ────────────────────────────────────────────
    describe('touchpoint validation', () => {
        it('every touchpoint should have checkType', () => {
            const touchpoints = getTouchpointsForSweep();
            touchpoints.forEach(tp => {
                expect(
                    ['ROUTE', 'API', 'EXTERNAL'].includes(tp.checkType!),
                    `Touchpoint ${tp.id} has invalid checkType: ${tp.checkType}`
                ).toBe(true);
            });
        });
    });
});
