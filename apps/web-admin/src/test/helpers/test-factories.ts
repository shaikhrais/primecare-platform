/**
 * Test Factories — Web Admin Shared Entity Builders
 *
 * Lighter-weight factories for client-side test data.
 * Mirrors worker-api factories for consistency across apps.
 *
 * Usage:
 *   import { buildUser, buildVisit } from './helpers/test-factories';
 *   const user = buildUser({ role: 'admin' });
 */

let counter = 0;
function nextId(): string { return `test-${++counter}`; }

// ── User ──────────────────────────────────────────────────────────────

export function buildUser(overrides?: Record<string, any>): Record<string, any> {
    const id = nextId();
    return {
        id,
        email: `user-${id}@primecare.test`,
        name: `Test User ${id}`,
        role: 'client',
        tenantId: 'tenant-default',
        status: 'active',
        createdAt: new Date('2026-01-01T00:00:00Z').toISOString(),
        ...overrides,
    };
}

// ── Visit ─────────────────────────────────────────────────────────────

export function buildVisit(overrides?: Record<string, any>): Record<string, any> {
    const id = nextId();
    return {
        id,
        clientId: 'client-1',
        pswId: 'psw-1',
        serviceId: 'service-1',
        tenantId: 'tenant-default',
        status: 'scheduled',
        scheduledStart: '2026-03-15T09:00:00Z',
        scheduledEnd: '2026-03-15T10:00:00Z',
        notes: '',
        ...overrides,
    };
}

// ── Invoice ───────────────────────────────────────────────────────────

export function buildInvoiceItem(overrides?: Record<string, any>): Record<string, any> {
    return {
        description: 'Home Care Visit',
        quantity: 1,
        unitPrice: 45.00,
        taxRate: 0.13,
        ...overrides,
    };
}

export function buildInvoice(overrides?: Record<string, any>): Record<string, any> {
    const id = nextId();
    return {
        id,
        clientId: 'client-1',
        tenantId: 'tenant-default',
        status: 'draft',
        items: [buildInvoiceItem()],
        dueDate: '2026-04-15',
        createdAt: new Date('2026-03-01T00:00:00Z').toISOString(),
        ...overrides,
    };
}

// ── Service ───────────────────────────────────────────────────────────

export function buildService(overrides?: Record<string, any>): Record<string, any> {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        name: `Service ${id}`,
        category: 'Care',
        hourlyRate: 45,
        isActive: true,
        ...overrides,
    };
}

// ── Incident ──────────────────────────────────────────────────────────

export function buildIncident(overrides?: Record<string, any>): Record<string, any> {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        type: 'fall',
        severity: 'high',
        description: 'Client fell while walking to the bathroom',
        reportedBy: 'psw-1',
        createdAt: new Date('2026-03-01T00:00:00Z').toISOString(),
        ...overrides,
    };
}

// ── Lead ──────────────────────────────────────────────────────────────

export function buildLead(overrides?: Record<string, any>): Record<string, any> {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        name: `Lead ${id}`,
        source: 'referral',
        status: 'new',
        createdAt: new Date('2026-03-01T00:00:00Z').toISOString(),
        ...overrides,
    };
}

// ── Reset counter ─────────────────────────────────────────────────────

export function resetFactoryCounter(): void {
    counter = 0;
}
