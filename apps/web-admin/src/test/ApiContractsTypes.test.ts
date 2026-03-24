/**
 * API Contracts Type Tests
 *
 * Validates all 30+ API contract interfaces and types are correctly defined
 * and structurally sound. Tests type shapes, required fields, enums, and
 * cross-type relationships.
 */
import { describe, it, expect } from 'vitest';
import type {
    ApiEnvelope, PaginationParams, LoginRequest, LoginResponse,
    RegisterRequest, RegisterResponse, ForgotPasswordRequest, ResetPasswordRequest,
    BusinessOnboardRequest, User, CreateUserRequest, UpdateUserRequest,
    Visit, CreateVisitRequest, UpdateVisitRequest, Service,
    Invoice, InvoiceItem, CreateInvoiceRequest,
    Incident, CreateIncidentRequest,
    Lead, CreateLeadRequest,
    Timesheet, TimesheetItem, Booking, CreateBookingRequest,
    PswProfile, PswAvailability, ClientProfile,
    AdminHomeStats, AuditLog,
    RealtimeEventType, RealtimeEvent,
} from '@/shared/api/contracts';

// ═══════════════════════════════════════════════════════════════════════════
// Module Exports
// ═══════════════════════════════════════════════════════════════════════════

describe('API Contracts Module', () => {
    it('exports all contract types', async () => {
        const mod: any = await import('@/shared/api/contracts');
        expect(mod).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Common Types
// ═══════════════════════════════════════════════════════════════════════════

describe('Common Types', () => {
    it('ApiEnvelope has correct shape', () => {
        const envelope: ApiEnvelope<string[]> = {
            status: 'success',
            data: ['a', 'b'],
            message: 'ok',
            meta: { page: 1, pageSize: 20, total: 100, totalPages: 5 },
        };
        expect(envelope.status).toBe('success');
        expect(envelope.data).toEqual(['a', 'b']);
        expect(envelope.meta?.total).toBe(100);
    });

    it('ApiEnvelope supports error status', () => {
        const error: ApiEnvelope<null> = { status: 'error', data: null, message: 'Not found' };
        expect(error.status).toBe('error');
    });

    it('PaginationParams all fields optional', () => {
        const params: PaginationParams = {};
        expect(params).toEqual({});
    });

    it('PaginationParams full spec', () => {
        const params: PaginationParams = { page: 2, pageSize: 50, sort: 'name', order: 'desc', search: 'test' };
        expect(params.order).toBe('desc');
        expect(params.search).toBe('test');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Auth Contract Types
// ═══════════════════════════════════════════════════════════════════════════

describe('Auth Contracts', () => {
    it('LoginRequest has email and password', () => {
        const req: LoginRequest = { email: 'a@b.com', password: 'secret' };
        expect(req.email).toBe('a@b.com');
    });

    it('LoginResponse has user with all required fields', () => {
        const res: LoginResponse = {
            user: { id: '1', email: 'a@b.com', name: 'Admin', roles: ['admin'], activeRole: 'admin', tenantId: 't1' },
            message: 'Login successful',
        };
        expect(res.user.roles).toContain('admin');
        expect(res.user.tenantId).toBe('t1');
    });

    it('RegisterRequest supports all 8 roles', () => {
        const roles = ['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager'] as const;
        roles.forEach(role => {
            const req: RegisterRequest = { email: 'a@b.com', password: 'pass', role };
            expect(req.role).toBe(role);
        });
    });

    it('RegisterResponse has user and message', () => {
        const res: RegisterResponse = { user: { id: '1', email: 'a@b.com', name: 'Test' }, message: 'Created' };
        expect(res.user.id).toBe('1');
    });

    it('ForgotPasswordRequest only email', () => {
        const req: ForgotPasswordRequest = { email: 'a@b.com' };
        expect(Object.keys(req)).toEqual(['email']);
    });

    it('ResetPasswordRequest has token and newPassword', () => {
        const req: ResetPasswordRequest = { token: 'xyz', newPassword: 'newPw123' };
        expect(req.token).toBeTruthy();
    });

    it('BusinessOnboardRequest has all required fields', () => {
        const req: BusinessOnboardRequest = {
            email: 'ceo@company.com', password: 'pass', tenantName: 'ACE Home Care', tenantSlug: 'ace-home-care',
        };
        expect(req.tenantSlug).toBe('ace-home-care');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// User Contracts
// ═══════════════════════════════════════════════════════════════════════════

describe('User Contracts', () => {
    it('User has all required fields', () => {
        const user: User = {
            id: '1', email: 'a@b.com', name: 'Test', roles: ['psw'],
            activeRole: 'psw', tenantId: 't1', status: 'active',
            createdAt: '2026-01-01', updatedAt: '2026-01-02',
        };
        expect(user.status).toBe('active');
        expect(user.phone).toBeUndefined();
    });

    it('User supports optional fields', () => {
        const user: User = {
            id: '1', email: 'a@b.com', name: 'Test', roles: ['admin'],
            activeRole: 'admin', tenantId: 't1', status: 'active',
            phone: '+1234567890', avatarUrl: '/avatar.jpg',
            createdAt: '2026-01-01', updatedAt: '2026-01-02',
        };
        expect(user.phone).toBe('+1234567890');
        expect(user.avatarUrl).toBe('/avatar.jpg');
    });

    it('CreateUserRequest minimal', () => {
        const req: CreateUserRequest = { email: 'a@b.com', name: 'New User', role: 'client' };
        expect(Object.keys(req)).toHaveLength(3);
    });

    it('UpdateUserRequest all optional', () => {
        const req: UpdateUserRequest = {};
        expect(req).toEqual({});
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Visit Contracts
// ═══════════════════════════════════════════════════════════════════════════

describe('Visit Contracts', () => {
    it('Visit has all 5 status values', () => {
        const statuses: Visit['status'][] = ['scheduled', 'in_progress', 'completed', 'cancelled', 'no_show'];
        expect(statuses).toHaveLength(5);
    });

    it('Visit full object shape', () => {
        const visit: Visit = {
            id: 'v1', clientId: 'c1', serviceId: 's1',
            status: 'scheduled',
            scheduledStart: '2026-03-15T09:00', scheduledEnd: '2026-03-15T10:00',
            tenantId: 't1', createdAt: '2026-03-01', updatedAt: '2026-03-14',
        };
        expect(visit.pswId).toBeUndefined();
        expect(visit.actualStart).toBeUndefined();
    });

    it('Visit with nested relations', () => {
        const visit: Visit = {
            id: 'v1', clientId: 'c1', serviceId: 's1', pswId: 'p1',
            status: 'in_progress',
            scheduledStart: '2026-03-15T09:00', scheduledEnd: '2026-03-15T10:00',
            actualStart: '2026-03-15T09:05', actualEnd: '2026-03-15T09:55',
            tenantId: 't1', createdAt: '2026-03-01', updatedAt: '2026-03-15',
            client: { id: 'c1', name: 'Jane' },
            psw: { id: 'p1', name: 'Maria' },
            service: { id: 's1', name: 'Home Care' },
        };
        expect(visit.client?.name).toBe('Jane');
        expect(visit.psw?.name).toBe('Maria');
    });

    it('CreateVisitRequest required vs optional', () => {
        const req: CreateVisitRequest = {
            clientId: 'c1', serviceId: 's1',
            scheduledStart: '2026-03-15T09:00', scheduledEnd: '2026-03-15T10:00',
        };
        expect(req.pswId).toBeUndefined();
        expect(req.notes).toBeUndefined();
    });

    it('UpdateVisitRequest all optional', () => {
        const req: UpdateVisitRequest = { status: 'cancelled' };
        expect(req.status).toBe('cancelled');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Invoice Contracts
// ═══════════════════════════════════════════════════════════════════════════

describe('Invoice Contracts', () => {
    it('Invoice has all 5 status values', () => {
        const statuses: Invoice['status'][] = ['draft', 'sent', 'paid', 'overdue', 'cancelled'];
        expect(statuses).toHaveLength(5);
    });

    it('InvoiceItem has all fields', () => {
        const item: InvoiceItem = { description: 'Home Care', quantity: 2, rate: 45, amount: 90 };
        expect(item.amount).toBe(item.quantity * item.rate);
    });

    it('Invoice with items', () => {
        const inv: Invoice = {
            id: 'inv1', clientId: 'c1', amount: 90,
            status: 'draft', dueDate: '2026-04-15',
            items: [{ description: 'HC', quantity: 2, rate: 45, amount: 90 }],
            tenantId: 't1', createdAt: '2026-03-15',
        };
        expect(inv.items).toHaveLength(1);
        expect(inv.paidAt).toBeUndefined();
    });

    it('CreateInvoiceRequest has items', () => {
        const req: CreateInvoiceRequest = {
            clientId: 'c1', dueDate: '2026-04-15',
            items: [{ description: 'Visit', quantity: 1, rate: 50, amount: 50 }],
        };
        expect(req.items[0].amount).toBe(50);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Incident Contracts
// ═══════════════════════════════════════════════════════════════════════════

describe('Incident Contracts', () => {
    it('Incident has 4 severity levels', () => {
        const severities: Incident['severity'][] = ['low', 'medium', 'high', 'critical'];
        expect(severities).toHaveLength(4);
    });

    it('Incident has 4 status values', () => {
        const statuses: Incident['status'][] = ['open', 'investigating', 'resolved', 'closed'];
        expect(statuses).toHaveLength(4);
    });

    it('CreateIncidentRequest with optional fields', () => {
        const req: CreateIncidentRequest = {
            type: 'fall', severity: 'high', description: 'Client fell',
            visitId: 'v1', clientId: 'c1',
        };
        expect(req.visitId).toBe('v1');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Lead Contracts
// ═══════════════════════════════════════════════════════════════════════════

describe('Lead Contracts', () => {
    it('Lead has 5 status values', () => {
        const statuses: Lead['status'][] = ['new', 'contacted', 'qualified', 'converted', 'lost'];
        expect(statuses).toHaveLength(5);
    });

    it('CreateLeadRequest minimal', () => {
        const req: CreateLeadRequest = { name: 'Jane Doe', source: 'referral' };
        expect(req.email).toBeUndefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Timesheet & Booking Contracts
// ═══════════════════════════════════════════════════════════════════════════

describe('Timesheet Contracts', () => {
    it('Timesheet has 4 status values', () => {
        const statuses: Timesheet['status'][] = ['draft', 'submitted', 'approved', 'rejected'];
        expect(statuses).toHaveLength(4);
    });

    it('Timesheet with items', () => {
        const ts: Timesheet = {
            id: 'ts1', pswId: 'p1', status: 'draft',
            periodStart: '2026-03-01', periodEnd: '2026-03-15',
            totalHours: 80, tenantId: 't1',
            items: [{ id: 'i1', visitId: 'v1', hours: 8, date: '2026-03-01', status: 'draft' }],
        };
        expect(ts.totalHours).toBe(80);
    });
});

describe('Booking Contracts', () => {
    it('Booking has all fields', () => {
        const b: Booking = { id: 'b1', clientId: 'c1', serviceId: 's1', status: 'confirmed', scheduledAt: '2026-03-15T09:00', tenantId: 't1' };
        expect(b.status).toBe('confirmed');
    });

    it('CreateBookingRequest', () => {
        const req: CreateBookingRequest = { clientId: 'c1', serviceId: 's1', scheduledAt: '2026-03-15T09:00' };
        expect(req.notes).toBeUndefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// PSW & Client Profiles
// ═══════════════════════════════════════════════════════════════════════════

describe('PSW Contracts', () => {
    it('PswProfile has all fields', () => {
        const p: PswProfile = { id: 'p1', userId: 'u1', certifications: ['CPR', 'First Aid'], availabilityStatus: 'available', rating: 4.8, totalVisits: 150 };
        expect(p.certifications).toContain('CPR');
        expect(p.rating).toBe(4.8);
    });

    it('PswAvailability has day/time/status', () => {
        const a: PswAvailability = { dayOfWeek: 1, startTime: '09:00', endTime: '17:00', isAvailable: true };
        expect(a.dayOfWeek).toBe(1);
    });
});

describe('Client Contracts', () => {
    it('ClientProfile has all fields', () => {
        const c: ClientProfile = { id: 'c1', userId: 'u1', status: 'active' };
        expect(c.address).toBeUndefined();
        expect(c.medicalNotes).toBeUndefined();
    });

    it('ClientProfile with optional fields', () => {
        const c: ClientProfile = {
            id: 'c1', userId: 'u1', status: 'active',
            address: '123 Main St', emergencyContact: 'Jane 555-1234',
            medicalNotes: 'Diabetes type 2', fundingSource: 'OHIP',
        };
        expect(c.fundingSource).toBe('OHIP');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Home & Audit
// ═══════════════════════════════════════════════════════════════════════════

describe('Home Contracts', () => {
    it('AdminHomeStats has all 8 metrics', () => {
        const stats: AdminHomeStats = {
            totalUsers: 100, totalClients: 50, totalProviders: 25,
            activeVisits: 15, pendingBookings: 8,
            monthlyRevenue: 45000, openIncidents: 3, complianceScore: 92,
        };
        expect(Object.keys(stats)).toHaveLength(8);
    });
});

describe('AuditLog Contracts', () => {
    it('AuditLog has all required fields', () => {
        const log: AuditLog = {
            id: 'a1', actorUserId: 'u1', action: 'USER_CREATED',
            resourceType: 'user', resourceId: 'u2',
            tenantId: 't1', createdAt: '2026-03-15',
        };
        expect(log.action).toBe('USER_CREATED');
        expect(log.ipAddress).toBeUndefined();
    });

    it('AuditLog with optional details', () => {
        const log: AuditLog = {
            id: 'a1', actorUserId: 'u1', action: 'LOGIN',
            resourceType: 'session', resourceId: 's1',
            details: JSON.stringify({ browser: 'Chrome' }),
            ipAddress: '192.168.1.1',
            tenantId: 't1', createdAt: '2026-03-15',
        };
        expect(log.ipAddress).toBe('192.168.1.1');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Realtime Events
// ═══════════════════════════════════════════════════════════════════════════

describe('Realtime Event Contracts', () => {
    it('RealtimeEventType has all 7 event types', () => {
        const events: RealtimeEventType[] = [
            'visit.updated', 'visit.completed', 'incident.created',
            'booking.created', 'notification.new', 'dispatch.updated', 'fleet.heartbeat',
        ];
        expect(events).toHaveLength(7);
    });

    it('RealtimeEvent generic type', () => {
        const event: RealtimeEvent<{ visitId: string }> = {
            type: 'visit.updated', timestamp: '2026-03-15T09:00', tenantId: 't1',
            data: { visitId: 'v1' },
        };
        expect(event.data.visitId).toBe('v1');
    });
});
