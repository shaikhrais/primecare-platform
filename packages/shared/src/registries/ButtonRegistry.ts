// ──────────────────────────────────────────────────────────────────────────────
// ButtonRegistry — Every actionable button across the platform.
// Each entry declares: role, module, action type, API path, and description.
//
// Data is split into sub-files under ./ButtonRegistry/
// This skeleton contains types, aggregate, derived maps, and helpers only.
// ──────────────────────────────────────────────────────────────────────────────

import { ApiRegistry } from './ApiRegistry';

// ── Types ────────────────────────────────────────────────────────────────────

export interface ButtonDef {
    id: string;
    label: string;
    role: string;
    module: string;
    type: 'primary' | 'secondary' | 'ghost' | 'danger';
    action: string;
    description: string;
    apiPath?: string;
    /** RouteRegistry key for UI_NAVIGATION buttons */
    routeKey?: string;
    /** Route parameter names this button's route requires */
    routeParams?: string[];
}

// ── Import sub-files ─────────────────────────────────────────────────────────

import { PLATFORM_BUTTONS } from './ButtonRegistry/platform-buttons';
import { TENANCY_BUTTONS } from './ButtonRegistry/tenancy-buttons';
import { OPERATIONS_BUTTONS } from './ButtonRegistry/operations-buttons';
import { BTN, PAGE_CODE_TO_ID } from './ButtonRegistry/btn-constants';
import type { ButtonId } from './ButtonRegistry/btn-constants';

// Re-export constants
export { BTN, PAGE_CODE_TO_ID };
export type { ButtonId };

// ── Aggregate ────────────────────────────────────────────────────────────────

export const ButtonRegistry: ButtonDef[] = [
    ...PLATFORM_BUTTONS,
    ...TENANCY_BUTTONS,
    ...OPERATIONS_BUTTONS,
];

// ── Derived: ButtonGroups — role → module → buttons ─────────────────────────

type NestedGroups = Record<string, Record<string, ButtonDef[]>>;

function buildButtonGroups(): NestedGroups {
    const groups: NestedGroups = {};
    for (const b of ButtonRegistry) {
        (groups[b.role] ??= {})[b.module] ??= [];
        groups[b.role][b.module].push(b);
    }
    return groups;
}

export const ButtonGroups: NestedGroups = buildButtonGroups();

// ── Derived: ButtonsByPage ───────────────────────────────────────────────────

import { PageActionRegistry } from './PageActionRegistry';

function buildButtonsByPage(): Record<string, ButtonDef[]> {
    const idx = new Map(ButtonRegistry.map(b => [b.id, b]));
    const result: Record<string, ButtonDef[]> = {};
    for (const [pageId, pa] of Object.entries(PageActionRegistry)) {
        const btns: ButtonDef[] = [];
        if (pa.primary) { const b = idx.get(pa.primary); if (b) btns.push(b); }
        for (const id of pa.actions) { const b = idx.get(id); if (b) btns.push(b); }
        if (btns.length) result[pageId] = btns;
    }
    return result;
}

export const ButtonsByPage: Record<string, ButtonDef[]> = buildButtonsByPage();

// ── Lookup Helpers ───────────────────────────────────────────────────────────

export function getButtonsForPage(code: string): ButtonDef[] {
    return ButtonsByPage[code] ?? [];
}

export function getButtonsByRole(role: string): ButtonDef[] {
    return ButtonRegistry.filter(b => b.role === role);
}

export function getButtonsByModule(module: string): ButtonDef[] {
    return ButtonRegistry.filter(b => b.module === module);
}

export function getButtonById(id: string): ButtonDef | undefined {
    return ButtonRegistry.find(b => b.id === id);
}

export const BUTTON_REGISTRY_COUNT = ButtonRegistry.length;
