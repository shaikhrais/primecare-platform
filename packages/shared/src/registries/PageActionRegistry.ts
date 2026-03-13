// ──────────────────────────────────────────────────────────────────────────────
// PageActionRegistry — Maps each page to its action buttons.
// Single source of truth: "which buttons appear on which page?"
//
// Data is split into sub-files under ./PageActionRegistry/
// This skeleton contains types, aggregate, and re-exports only.
// ──────────────────────────────────────────────────────────────────────────────

export interface PageActions {
    /** The primary CTA button for this page */
    primary?: string;
    /** Secondary/utility action buttons */
    actions: string[];
}

// ── Import page action data from sub-files ───────────────────────────────────

import { PLATFORM_ACTIONS } from './PageActionRegistry/platform-actions';
import { TENANCY_ACTIONS } from './PageActionRegistry/tenancy-actions';

// ── Aggregate Export ─────────────────────────────────────────────────────────

/**
 * Maps PageEntry.id → { primary, actions[] } where values are ButtonDef.id strings.
 * 
 * Usage:
 *   import { PageActionRegistry } from 'prime-care-shared';
 *   const actions = PageActionRegistry['admin.dashboard'];
 *   // { primary: 'btn-admin-user-invite', actions: [...] }
 */
export const PageActionRegistry: Record<string, PageActions> = {
    ...PLATFORM_ACTIONS,
    ...TENANCY_ACTIONS,
};
