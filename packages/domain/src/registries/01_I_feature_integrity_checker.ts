// ──────────────────────────────────────────────────────────────────────────────
// FeatureIntegrityChecker — Cross-validates all registries to detect
// incomplete feature implementations (missing routes, APIs, buttons, forms).
//
// Designed to run as part of the Scrum Master Response Bot sweep.
// ──────────────────────────────────────────────────────────────────────────────

import { PageRegistry, getPageById } from './PageRegistry';
import { ButtonRegistry, getButtonById } from './ButtonRegistry';
import { FormRegistry, getFormById } from './FormRegistry';
import { PageActionRegistry } from './PageActionRegistry';

// ── Types ────────────────────────────────────────────────────────────────────

export type IssueSeverity = 'error' | 'warning' | 'info';
export type IssueCategory = 'ORPHAN_PAGE' | 'ORPHAN_BUTTON' | 'ORPHAN_FORM' | 'MISSING_BUTTON' | 'MISSING_FORM' | 'MISSING_API' | 'MISSING_ROUTE' | 'DEAD_LINK';

export interface IntegrityIssue {
    severity: IssueSeverity;
    category: IssueCategory;
    source: string;
    target: string;
    message: string;
}

export interface IntegrityReport {
    timestamp: string;
    totalChecks: number;
    errors: IntegrityIssue[];
    warnings: IntegrityIssue[];
    info: IntegrityIssue[];
    summary: {
        pages: number;
        buttons: number;
        forms: number;
        pagesWithButtons: number;
        pagesWithoutButtons: number;
        formsWithMissingEndpoints: number;
        buttonsWithMissingApi: number;
        orphanButtons: number;
    };
}

// ── Checker Functions ────────────────────────────────────────────────────────

function checkPageIntegrity(issues: IntegrityIssue[]) {
    const actionedPageIds = new Set(Object.keys(PageActionRegistry));
    const buttonPageIds = new Set<string>();

    // Check: every page that has a form type should have a FormRegistry entry
    for (const page of PageRegistry) {
        if (page.type === 'form' && page.formRegistryId) {
            const form = getFormById(page.formRegistryId);
            if (!form) {
                issues.push({ severity: 'error', category: 'MISSING_FORM', source: `Page:${page.id}`, target: `Form:${page.formRegistryId}`, message: `Page "${page.label}" (${page.id}) references form "${page.formRegistryId}" but it doesn't exist in FormRegistry.` });
            }
        }

        // Check: every page should ideally have at least one button in PageActionRegistry
        if (!actionedPageIds.has(page.id) && !['error', 'settings', 'portal'].includes(page.type)) {
            issues.push({ severity: 'warning', category: 'MISSING_BUTTON', source: `Page:${page.id}`, target: 'PageActionRegistry', message: `Page "${page.label}" (${page.id}) has no buttons defined in PageActionRegistry.` });
        }
    }

    // Check: every PageActionRegistry entry should reference a valid page
    for (const [pageId, actions] of Object.entries(PageActionRegistry)) {
        const page = getPageById(pageId);
        if (!page) {
            issues.push({ severity: 'warning', category: 'ORPHAN_PAGE', source: `PageActionRegistry:${pageId}`, target: 'PageRegistry', message: `PageActionRegistry defines actions for "${pageId}" but no matching page exists in PageRegistry.` });
        }

        // Check: every button ID in PageActionRegistry should exist in ButtonRegistry
        const allIds = [actions.primary, ...actions.actions].filter(Boolean) as string[];
        for (const btnId of allIds) {
            const btn = getButtonById(btnId);
            if (!btn) {
                issues.push({ severity: 'error', category: 'ORPHAN_BUTTON', source: `PageActionRegistry:${pageId}`, target: `Button:${btnId}`, message: `Page "${pageId}" references button "${btnId}" but it doesn't exist in ButtonRegistry.` });
            } else {
                buttonPageIds.add(btnId);
            }
        }
    }

    return buttonPageIds;
}

function checkButtonIntegrity(issues: IntegrityIssue[], referencedButtons: Set<string>) {
    let orphanCount = 0;
    let missingApiCount = 0;

    for (const btn of ButtonRegistry) {
        // Skip link/interaction/touchpoint types — they're navigational, not page-bound
        if (['link', 'interaction', 'touchpoint'].includes(btn.type)) continue;

        // Check: buttons with API actions should have valid apiPath
        if (['API_TRIGGER', 'API_SIGNATURE', 'API_DISPATCH', 'GEOLOCATION_STAMP'].includes(btn.action)) {
            if (!btn.apiPath) {
                issues.push({ severity: 'warning', category: 'MISSING_API', source: `Button:${btn.id}`, target: 'apiPath', message: `Button "${btn.label}" (${btn.id}) has action "${btn.action}" but no apiPath defined.` });
                missingApiCount++;
            }
        }

        // Check: primary/secondary buttons should be referenced by at least one page
        if (!referencedButtons.has(btn.id)) {
            issues.push({ severity: 'info', category: 'ORPHAN_BUTTON', source: `Button:${btn.id}`, target: 'PageActionRegistry', message: `Button "${btn.label}" (${btn.id}) is not referenced by any page in PageActionRegistry.` });
            orphanCount++;
        }
    }

    return { orphanCount, missingApiCount };
}

function checkFormIntegrity(issues: IntegrityIssue[]) {
    let missingEndpoints = 0;

    for (const form of FormRegistry) {
        // Check: forms should have a valid apiEndpoint
        if (!form.apiEndpoint || form.apiEndpoint === '') {
            issues.push({ severity: 'error', category: 'MISSING_API', source: `Form:${form.id}`, target: 'apiEndpoint', message: `Form "${form.label}" (${form.id}) has no API endpoint defined.` });
            missingEndpoints++;
        }

        // Check: forms should have a valid route
        if (!form.route || form.route === '') {
            issues.push({ severity: 'error', category: 'MISSING_ROUTE', source: `Form:${form.id}`, target: 'route', message: `Form "${form.label}" (${form.id}) has no route defined.` });
        }

        // Check: form dependencies should have valid endpoints
        if (form.dependencies) {
            for (const dep of form.dependencies) {
                if (!dep.inlineCreateEndpoint) {
                    issues.push({ severity: 'warning', category: 'MISSING_API', source: `Form:${form.id}:dep:${dep.field}`, target: 'inlineCreateEndpoint', message: `Form "${form.label}" dependency "${dep.field}" has no inline create endpoint.` });
                }
            }
        }
    }

    return missingEndpoints;
}

function checkLinkIntegrity(issues: IntegrityIssue[]) {
    const links = ButtonRegistry.filter(b => b.type === 'link');
    for (const link of links) {
        if (!link.path || link.path === '' || link.path === '/shared/404') {
            issues.push({ severity: 'error', category: 'DEAD_LINK', source: `Link:${link.id}`, target: link.path || '(empty)', message: `Link "${link.label}" (${link.id}) points to a dead or empty path.` });
        }
    }
}

// ── Main Entry Point ─────────────────────────────────────────────────────────

export function runIntegrityCheck(): IntegrityReport {
    const issues: IntegrityIssue[] = [];

    // Run all checks
    const referencedButtons = checkPageIntegrity(issues);
    const { orphanCount, missingApiCount } = checkButtonIntegrity(issues, referencedButtons);
    const missingEndpoints = checkFormIntegrity(issues);
    checkLinkIntegrity(issues);

    // Categorize
    const errors = issues.filter(i => i.severity === 'error');
    const warnings = issues.filter(i => i.severity === 'warning');
    const info = issues.filter(i => i.severity === 'info');

    const pagesWithButtons = new Set(Object.keys(PageActionRegistry)).size;

    return {
        timestamp: new Date().toISOString(),
        totalChecks: issues.length,
        errors,
        warnings,
        info,
        summary: {
            pages: PageRegistry.length,
            buttons: ButtonRegistry.filter(b => !['link', 'interaction', 'touchpoint'].includes(b.type)).length,
            forms: FormRegistry.length,
            pagesWithButtons,
            pagesWithoutButtons: PageRegistry.length - pagesWithButtons,
            formsWithMissingEndpoints: missingEndpoints,
            buttonsWithMissingApi: missingApiCount,
            orphanButtons: orphanCount,
        },
    };
}
