/**
 * FormRegistry Unit Tests
 *
 * Validates that all form definitions have required fields,
 * API endpoints, no duplicate IDs, and proper field structures.
 */
import { describe, it, expect } from 'vitest';
import { FormRegistry } from 'prime-care-shared';

describe('FormRegistry', () => {
    // ── Basic Coverage ────────────────────────────────────────────────────
    describe('basic coverage', () => {
        it('should contain at least 20 forms', () => {
            expect(FormRegistry.length).toBeGreaterThanOrEqual(20);
        });

        it('should be an array', () => {
            expect(Array.isArray(FormRegistry)).toBe(true);
        });
    });

    // ── Structural Validation ─────────────────────────────────────────────
    describe('structural validation', () => {
        it('every form should have id and label', () => {
            FormRegistry.forEach((form: any) => {
                expect(form.id, `Form missing id`).toBeDefined();
                expect(form.label, `Form ${form.id} missing label`).toBeDefined();
            });
        });

        it('should have no duplicate form IDs', () => {
            const ids = FormRegistry.map((f: any) => f.id);
            const dupes = ids.filter((id: string, i: number) => ids.indexOf(id) !== i);
            expect(dupes).toEqual([]);
        });

        it('every form should have a category', () => {
            FormRegistry.forEach((form: any) => {
                expect(form.category, `Form ${form.id} missing category`).toBeDefined();
            });
        });
    });

    // ── Field Validation ──────────────────────────────────────────────────
    describe('field validation', () => {
        it('every form with fields should have at least 1 field', () => {
            FormRegistry.forEach((form: any) => {
                if (form.fields) {
                    expect(
                        Array.isArray(form.fields),
                        `Form ${form.id} fields should be an array`
                    ).toBe(true);
                    expect(
                        form.fields.length,
                        `Form ${form.id} has empty fields array`
                    ).toBeGreaterThan(0);
                }
            });
        });

        it('every field should have name and type', () => {
            FormRegistry.forEach((form: any) => {
                if (form.fields) {
                    form.fields.forEach((field: any, i: number) => {
                        expect(field.name, `Form ${form.id} field #${i} missing name`).toBeDefined();
                        expect(field.type, `Form ${form.id} field "${field.name}" missing type`).toBeDefined();
                    });
                }
            });
        });
    });

    // ── API Endpoint Wiring ───────────────────────────────────────────────
    describe('API endpoint wiring', () => {
        it('forms with apiEndpoint should have non-empty string', () => {
            FormRegistry.forEach((form: any) => {
                if (form.apiEndpoint) {
                    expect(
                        typeof form.apiEndpoint === 'string' && form.apiEndpoint.length > 0,
                        `Form ${form.id} has invalid apiEndpoint`
                    ).toBe(true);
                }
            });
        });
    });

    // ── Category Distribution ─────────────────────────────────────────────
    describe('category distribution', () => {
        it('should have forms in at least 3 different categories', () => {
            const categories = new Set(FormRegistry.map((f: any) => f.category));
            expect(categories.size).toBeGreaterThanOrEqual(3);
        });
    });
});
