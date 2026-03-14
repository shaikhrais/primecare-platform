/**
 * ThemeRegistry Tests
 *
 * Validates CSS variable definitions, color presets, and structural integrity.
 */
import { describe, it, expect } from 'vitest';
import { ThemeRegistry } from 'prime-care-shared';

describe('ThemeRegistry · Structure', () => {
    it('exports ThemeRegistry as an object', () => {
        expect(ThemeRegistry).toBeDefined();
        expect(typeof ThemeRegistry).toBe('object');
    });

    it('has COLORS and PRESETS top-level keys', () => {
        expect(ThemeRegistry).toHaveProperty('COLORS');
        expect(ThemeRegistry).toHaveProperty('PRESETS');
    });
});

describe('ThemeRegistry · COLORS', () => {
    it('has PRIMARY, PRIMARY_DARK, ACCENT, BACKGROUND, SURFACE, BORDER', () => {
        const { COLORS } = ThemeRegistry;
        expect(COLORS.PRIMARY).toBeDefined();
        expect(COLORS.PRIMARY_DARK).toBeDefined();
        expect(COLORS.ACCENT).toBeDefined();
        expect(COLORS.BACKGROUND).toBeDefined();
        expect(COLORS.SURFACE).toBeDefined();
        expect(COLORS.BORDER).toBeDefined();
    });

    it('all root-level color values are CSS custom property strings', () => {
        const rootColors = ['PRIMARY', 'PRIMARY_DARK', 'ACCENT', 'BACKGROUND', 'SURFACE', 'BORDER'] as const;
        for (const key of rootColors) {
            expect((ThemeRegistry.COLORS as any)[key]).toMatch(/^--pc-/);
        }
    });

    it('has TEXT sub-group with BASE, MUTED, ON_PRIMARY', () => {
        const { TEXT } = ThemeRegistry.COLORS;
        expect(TEXT.BASE).toMatch(/^--pc-/);
        expect(TEXT.MUTED).toMatch(/^--pc-/);
        expect(TEXT.ON_PRIMARY).toMatch(/^--pc-/);
    });

    it('has STATUS sub-group with SUCCESS, WARNING, ERROR, INFO', () => {
        const { STATUS } = ThemeRegistry.COLORS;
        expect(STATUS.SUCCESS).toMatch(/^--pc-/);
        expect(STATUS.WARNING).toMatch(/^--pc-/);
        expect(STATUS.ERROR).toMatch(/^--pc-/);
        expect(STATUS.INFO).toMatch(/^--pc-/);
    });

    it('no duplicate CSS variables', () => {
        const allVars: string[] = [];
        const collect = (obj: any) => {
            for (const val of Object.values(obj)) {
                if (typeof val === 'string') allVars.push(val);
                else if (typeof val === 'object' && val !== null) collect(val);
            }
        };
        collect(ThemeRegistry.COLORS);
        const unique = new Set(allVars);
        expect(unique.size).toBe(allVars.length);
    });
});

describe('ThemeRegistry · PRESETS', () => {
    it('has at least 3 presets', () => {
        const presetKeys = Object.keys(ThemeRegistry.PRESETS);
        expect(presetKeys.length).toBeGreaterThanOrEqual(3);
    });

    it('PRIMECARE_STANDARD preset has primary, primaryDark, accent', () => {
        const standard = ThemeRegistry.PRESETS.PRIMECARE_STANDARD;
        expect(standard.primary).toBeDefined();
        expect(standard.primaryDark).toBeDefined();
        expect(standard.accent).toBeDefined();
    });

    it('all preset colors are valid hex codes', () => {
        const hexRegex = /^#[0-9a-fA-F]{6}$/;
        for (const [name, preset] of Object.entries(ThemeRegistry.PRESETS)) {
            expect((preset as any).primary).toMatch(hexRegex);
            expect((preset as any).primaryDark).toMatch(hexRegex);
            expect((preset as any).accent).toMatch(hexRegex);
        }
    });

    it('PRIMECARE_STANDARD primary is teal (#00897b)', () => {
        expect(ThemeRegistry.PRESETS.PRIMECARE_STANDARD.primary).toBe('#00897b');
    });

    it('DUSK_MODE primary is slate (#1e293b)', () => {
        expect(ThemeRegistry.PRESETS.DUSK_MODE.primary).toBe('#1e293b');
    });
});
