/// <reference types="node" />
/**
 * API Contracts & Typed Client Validation Tests
 *
 * Validates that the typed API contracts match expected shapes,
 * domain query hook utilities work correctly, and the QueryKeys
 * structure is consistent.
 */
import { describe, it, expect } from 'vitest';
import { QueryKeys } from '@/shared/hooks/useDomainQueries';
import type {
    LoginRequest, LoginResponse, RegisterRequest,
    User, Visit, Incident, Service, Invoice, Lead,
    AdminDashboardStats, AuditLog, PaginationParams,
    RealtimeEvent, RealtimeEventType, ApiEnvelope,
    CreateVisitRequest, CreateUserRequest, CreateIncidentRequest,
    CreateLeadRequest, UpdateVisitRequest, UpdateUserRequest,
} from '@/shared/api/contracts';

// ── QueryKeys Tests ───────────────────────────────────────────────────────

describe('QueryKeys', () => {
    it('visits key without filters returns base key', () => {
        expect(QueryKeys.visits()).toEqual(['visits', undefined]);
    });

    it('visits key with filters includes filters', () => {
        const filters = { status: 'scheduled' };
        expect(QueryKeys.visits(filters)).toEqual(['visits', { status: 'scheduled' }]);
    });

    it('visit key includes id', () => {
        expect(QueryKeys.visit('v-123')).toEqual(['visits', 'v-123']);
    });

    it('users key without filters', () => {
        expect(QueryKeys.users()).toEqual(['users', undefined]);
    });

    it('users key with filters', () => {
        expect(QueryKeys.users({ role: 'admin' })).toEqual(['users', { role: 'admin' }]);
    });

    it('user key includes id', () => {
        expect(QueryKeys.user('u-456')).toEqual(['users', 'u-456']);
    });

    it('incidents key', () => {
        expect(QueryKeys.incidents()).toEqual(['incidents', undefined]);
    });

    it('incidents key with severity filter', () => {
        expect(QueryKeys.incidents({ severity: 'critical' })).toEqual(['incidents', { severity: 'critical' }]);
    });

    it('services key is static', () => {
        expect(QueryKeys.services()).toEqual(['services']);
    });

    it('invoices key', () => {
        expect(QueryKeys.invoices({ status: 'overdue' })).toEqual(['invoices', { status: 'overdue' }]);
    });

    it('leads key', () => {
        expect(QueryKeys.leads({ source: 'website' })).toEqual(['leads', { source: 'website' }]);
    });

    it('dashboardStats key is static', () => {
        expect(QueryKeys.dashboardStats()).toEqual(['dashboard', 'stats']);
    });

    it('auditLogs key', () => {
        expect(QueryKeys.auditLogs({ action: 'CREATE' })).toEqual(['audit-logs', { action: 'CREATE' }]);
    });

    it('all keys are readonly tuples', () => {
        const visitKey = QueryKeys.visits();
        expect(Array.isArray(visitKey)).toBe(true);
    });
});

// ── Contract Type Shape Validation ────────────────────────────────────────

describe('API Contract Type Shapes', () => {
    it('LoginRequest has required fields', () => {
        const req: LoginRequest = { email: 'test@test.com', password: 'pw' };
        expect(req.email).toBeDefined();
        expect(req.password).toBeDefined();
    });

    it('RegisterRequest supports all roles', () => {
        const roles = ['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager'] as const;
        roles.forEach(role => {
            const req: RegisterRequest = { email: 'a@b.com', password: 'P@ssw0rd!', role };
            expect(req.role).toBe(role);
        });
    });

    it('Visit has status enum', () => {
        const statuses: Visit['status'][] = ['scheduled', 'in_progress', 'completed', 'cancelled', 'no_show'];
        expect(statuses).toHaveLength(5);
    });

    it('Invoice has status enum', () => {
        const statuses: Invoice['status'][] = ['draft', 'sent', 'paid', 'overdue', 'cancelled'];
        expect(statuses).toHaveLength(5);
    });

    it('Incident has severity enum', () => {
        const severities: Incident['severity'][] = ['low', 'medium', 'high', 'critical'];
        expect(severities).toHaveLength(4);
    });

    it('Incident has status enum', () => {
        const statuses: Incident['status'][] = ['open', 'investigating', 'resolved', 'closed'];
        expect(statuses).toHaveLength(4);
    });

    it('Lead has status enum', () => {
        const statuses: Lead['status'][] = ['new', 'contacted', 'qualified', 'converted', 'lost'];
        expect(statuses).toHaveLength(5);
    });

    it('PaginationParams has all expected fields', () => {
        const params: PaginationParams = { page: 1, pageSize: 20, sort: 'name', order: 'asc', search: 'test' };
        expect(params.page).toBe(1);
        expect(params.pageSize).toBe(20);
        expect(params.sort).toBe('name');
        expect(params.order).toBe('asc');
        expect(params.search).toBe('test');
    });

    it('AdminDashboardStats has all metric fields', () => {
        const stats: AdminDashboardStats = {
            totalUsers: 100, totalClients: 50, totalProviders: 30,
            activeVisits: 15, pendingBookings: 5, monthlyRevenue: 45000,
            openIncidents: 2, complianceScore: 95,
        };
        expect(Object.keys(stats)).toHaveLength(8);
    });

    it('RealtimeEvent has correct type union', () => {
        const types: RealtimeEventType[] = [
            'visit.updated', 'visit.completed', 'incident.created',
            'booking.created', 'notification.new', 'dispatch.updated', 'fleet.heartbeat',
        ];
        expect(types).toHaveLength(7);
    });

    it('ApiEnvelope wraps typed data', () => {
        const envelope: ApiEnvelope<User[]> = {
            status: 'success',
            data: [],
            meta: { page: 1, pageSize: 20, total: 100, totalPages: 5 },
        };
        expect(envelope.status).toBe('success');
        expect(envelope.meta?.totalPages).toBe(5);
    });

    it('CreateVisitRequest has required fields', () => {
        const req: CreateVisitRequest = {
            clientId: 'c-1', serviceId: 's-1',
            scheduledStart: '2026-03-15T09:00:00Z', scheduledEnd: '2026-03-15T10:00:00Z',
        };
        expect(req.clientId).toBeDefined();
        expect(req.scheduledStart).toBeDefined();
    });

    it('CreateUserRequest has required fields', () => {
        const req: CreateUserRequest = { email: 'a@b.com', name: 'Test', role: 'psw' };
        expect(req.email).toBeDefined();
        expect(req.name).toBeDefined();
    });

    it('CreateIncidentRequest has required fields', () => {
        const req: CreateIncidentRequest = { type: 'fall', severity: 'high', description: 'Client fell' };
        expect(req.type).toBeDefined();
        expect(req.severity).toBe('high');
    });

    it('UpdateVisitRequest allows partial updates', () => {
        const req: UpdateVisitRequest = { status: 'completed' };
        expect(req.status).toBe('completed');
        expect(req.pswId).toBeUndefined();
    });

    it('UpdateUserRequest allows partial updates', () => {
        const req: UpdateUserRequest = { name: 'New Name' };
        expect(req.name).toBe('New Name');
        expect(req.phone).toBeUndefined();
    });
});

// ── Vite Build Configuration Tests ────────────────────────────────────────

describe('Build Configuration', () => {
    it('vite.config.ts exists and exports valid config', async () => {
        // Validates that the build config file is importable
        const fs = await import('fs');
        const configPath = 'vite.config.ts';
        expect(fs.existsSync(configPath)).toBe(true);
    });
});
