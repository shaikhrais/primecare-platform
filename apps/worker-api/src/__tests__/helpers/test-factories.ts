/**
 * Test Factories — Shared Entity Builders
 *
 * Builder-pattern factories for all core domain entities.
 * Each factory returns a valid default entity that can be overridden.
 *
 * Usage:
 *   const user = buildUser({ role: 'admin' });
 *   const visit = buildVisit({ clientId: user.id });
 */

let counter = 0;
function nextId(): string { return `test-${++counter}`; }

// ── User ──────────────────────────────────────────────────────────────

export interface TestUser {
    id: string;
    email: string;
    name: string;
    role: string;
    tenantId: string;
    status: string;
    createdAt: Date;
}

export function buildUser(overrides?: Partial<TestUser>): TestUser {
    const id = nextId();
    return {
        id,
        email: `user-${id}@primecare.test`,
        name: `Test User ${id}`,
        role: 'client',
        tenantId: 'tenant-default',
        status: 'active',
        createdAt: new Date('2026-01-01T00:00:00Z'),
        ...overrides,
    };
}

// ── Tenant ────────────────────────────────────────────────────────────

export interface TestTenant {
    id: string;
    name: string;
    slug: string;
    status: string;
    createdAt: Date;
}

export function buildTenant(overrides?: Partial<TestTenant>): TestTenant {
    const id = nextId();
    return {
        id,
        name: `Test Org ${id}`,
        slug: `test-org-${id}`,
        status: 'active',
        createdAt: new Date('2026-01-01T00:00:00Z'),
        ...overrides,
    };
}

// ── Visit ─────────────────────────────────────────────────────────────

export interface TestVisit {
    id: string;
    clientId: string;
    pswId: string;
    serviceId: string;
    tenantId: string;
    status: string;
    scheduledStart: Date;
    scheduledEnd: Date;
    notes: string;
}

export function buildVisit(overrides?: Partial<TestVisit>): TestVisit {
    const id = nextId();
    return {
        id,
        clientId: 'client-1',
        pswId: 'psw-1',
        serviceId: 'service-1',
        tenantId: 'tenant-default',
        status: 'scheduled',
        scheduledStart: new Date('2026-03-15T09:00:00Z'),
        scheduledEnd: new Date('2026-03-15T10:00:00Z'),
        notes: '',
        ...overrides,
    };
}

// ── Invoice ───────────────────────────────────────────────────────────

export interface TestInvoiceItem {
    description: string;
    quantity: number;
    unitPrice: number;
    taxRate: number;
}

export interface TestInvoice {
    id: string;
    clientId: string;
    tenantId: string;
    status: string;
    items: TestInvoiceItem[];
    dueDate: string;
    createdAt: Date;
}

export function buildInvoiceItem(overrides?: Partial<TestInvoiceItem>): TestInvoiceItem {
    return {
        description: 'Home Care Visit',
        quantity: 1,
        unitPrice: 45.00,
        taxRate: 0.13,
        ...overrides,
    };
}

export function buildInvoice(overrides?: Partial<TestInvoice>): TestInvoice {
    const id = nextId();
    return {
        id,
        clientId: 'client-1',
        tenantId: 'tenant-default',
        status: 'draft',
        items: [buildInvoiceItem()],
        dueDate: '2026-04-15',
        createdAt: new Date('2026-03-01T00:00:00Z'),
        ...overrides,
    };
}

// ── Journal Entry ─────────────────────────────────────────────────────

export interface TestJournalEntry {
    id: string;
    tenantId: string;
    accountId: string;
    debit: number;
    paidOutAmount: number;
    description: string;
    createdAt: Date;
}

export function buildJournalEntry(overrides?: Partial<TestJournalEntry>): TestJournalEntry {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        accountId: 'account-1',
        debit: 100,
        paidOutAmount: 0,
        description: 'Test entry',
        createdAt: new Date('2026-03-01T00:00:00Z'),
        ...overrides,
    };
}

// ── Chart of Account ──────────────────────────────────────────────────

export interface TestChartOfAccount {
    id: string;
    tenantId: string;
    name: string;
    code: string;
    type: string;
    journalEntries: TestJournalEntry[];
}

export function buildChartOfAccount(overrides?: Partial<TestChartOfAccount>): TestChartOfAccount {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        name: `Account ${id}`,
        code: '1000',
        type: 'ASSET',
        journalEntries: [],
        ...overrides,
    };
}

// ── Service ───────────────────────────────────────────────────────────

export interface TestService {
    id: string;
    tenantId: string;
    name: string;
    category: string;
    hourlyRate: number;
    isActive: boolean;
}

export function buildService(overrides?: Partial<TestService>): TestService {
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

export interface TestIncident {
    id: string;
    tenantId: string;
    type: string;
    severity: string;
    description: string;
    reportedBy: string;
    createdAt: Date;
}

export function buildIncident(overrides?: Partial<TestIncident>): TestIncident {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        type: 'fall',
        severity: 'high',
        description: 'Client fell while walking to the bathroom',
        reportedBy: 'psw-1',
        createdAt: new Date('2026-03-01T00:00:00Z'),
        ...overrides,
    };
}

// ── Lead ──────────────────────────────────────────────────────────────

export interface TestLead {
    id: string;
    tenantId: string;
    name: string;
    source: string;
    status: string;
    createdAt: Date;
}

export function buildLead(overrides?: Partial<TestLead>): TestLead {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        name: `Lead ${id}`,
        source: 'referral',
        status: 'new',
        createdAt: new Date('2026-03-01T00:00:00Z'),
        ...overrides,
    };
}

// ── Financial Transaction ─────────────────────────────────────────────

export interface TestFinancialTransaction {
    id: string;
    tenantId: string;
    type: string;
    amount: number;
    createdAt: Date;
    journalEntries: Array<TestJournalEntry & { account: TestChartOfAccount }>;
}

export function buildFinancialTransaction(overrides?: Partial<TestFinancialTransaction>): TestFinancialTransaction {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        type: 'PAYMENT',
        amount: 100,
        createdAt: new Date('2026-03-01T00:00:00Z'),
        journalEntries: [],
        ...overrides,
    };
}

// ── Tenant Config (Feature Flags) ─────────────────────────────────────

export interface TestTenantConfig {
    id: string;
    tenantId: string;
    key: string;
    value: string;
}

export function buildTenantConfig(overrides?: Partial<TestTenantConfig>): TestTenantConfig {
    const id = nextId();
    return {
        id,
        tenantId: 'tenant-default',
        key: 'feature:billing',
        value: 'true',
        ...overrides,
    };
}

// ── Reset counter (for deterministic tests) ───────────────────────────

export function resetFactoryCounter(): void {
    counter = 0;
}
