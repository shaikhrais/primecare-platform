/**
 * API Contracts — Typed request/response interfaces
 *
 * These types mirror the backend Zod schemas in worker-api, providing
 * compile-time type safety for all API calls. When the backend schema
 * changes, update these types to catch mismatches at build time.
 *
 * Organized by module (auth, admin, psw, rn, client, coordinator, manager).
 */

// ─── Common Types ─────────────────────────────────────────────────────────

export interface ApiEnvelope<T> {
    status: 'success' | 'error';
    data: T;
    message?: string;
    meta?: {
        page?: number;
        pageSize?: number;
        total?: number;
        totalPages?: number;
    };
}

export interface PaginationParams {
    page?: number;
    pageSize?: number;
    sort?: string;
    order?: 'asc' | 'desc';
    search?: string;
}

// ─── Auth Module ──────────────────────────────────────────────────────────

export interface LoginRequest {
    email: string;
    password: string;
}

export interface LoginResponse {
    user: {
        id: string;
        email: string;
        name: string;
        roles: string[];
        activeRole: string;
        tenantId: string;
        tenantName?: string;
    };
    message: string;
}

export interface RegisterRequest {
    email: string;
    password: string;
    role: 'client' | 'psw' | 'staff' | 'admin' | 'coordinator' | 'finance' | 'rn' | 'manager';
    tenantName?: string;
    tenantSlug?: string;
}

export interface RegisterResponse {
    user: { id: string; email: string; name: string };
    message: string;
}

export interface ForgotPasswordRequest {
    email: string;
}

export interface ResetPasswordRequest {
    token: string;
    newPassword: string;
}

export interface BusinessOnboardRequest {
    email: string;
    password: string;
    tenantName: string;
    tenantSlug: string;
}

// ─── User / Admin Module ──────────────────────────────────────────────────

export interface User {
    id: string;
    email: string;
    name: string;
    roles: string[];
    activeRole: string;
    tenantId: string;
    status: string;
    phone?: string;
    avatarUrl?: string;
    createdAt: string;
    updatedAt: string;
}

export interface CreateUserRequest {
    email: string;
    name: string;
    role: string;
    phone?: string;
}

export interface UpdateUserRequest {
    name?: string;
    phone?: string;
    status?: string;
    roles?: string[];
}

// ─── Visit Module ─────────────────────────────────────────────────────────

export interface Visit {
    id: string;
    clientId: string;
    pswId?: string;
    serviceId: string;
    status: 'scheduled' | 'in_progress' | 'completed' | 'cancelled' | 'no_show';
    scheduledStart: string;
    scheduledEnd: string;
    actualStart?: string;
    actualEnd?: string;
    notes?: string;
    tenantId: string;
    createdAt: string;
    updatedAt: string;
    client?: { id: string; name: string };
    psw?: { id: string; name: string };
    service?: { id: string; name: string };
}

export interface CreateVisitRequest {
    clientId: string;
    pswId?: string;
    serviceId: string;
    scheduledStart: string;
    scheduledEnd: string;
    notes?: string;
}

export interface UpdateVisitRequest {
    status?: Visit['status'];
    pswId?: string;
    scheduledStart?: string;
    scheduledEnd?: string;
    notes?: string;
}

// ─── Service Module ───────────────────────────────────────────────────────

export interface Service {
    id: string;
    name: string;
    description: string;
    category: string;
    rate: number;
    duration: number;
    status: string;
    tenantId: string;
}

// ─── Invoice Module ───────────────────────────────────────────────────────

export interface Invoice {
    id: string;
    clientId: string;
    amount: number;
    status: 'draft' | 'sent' | 'paid' | 'overdue' | 'cancelled';
    dueDate: string;
    paidAt?: string;
    items: InvoiceItem[];
    tenantId: string;
    createdAt: string;
}

export interface InvoiceItem {
    description: string;
    quantity: number;
    rate: number;
    amount: number;
}

export interface CreateInvoiceRequest {
    clientId: string;
    dueDate: string;
    items: InvoiceItem[];
}

// ─── Incident Module ──────────────────────────────────────────────────────

export interface Incident {
    id: string;
    type: string;
    severity: 'low' | 'medium' | 'high' | 'critical';
    status: 'open' | 'investigating' | 'resolved' | 'closed';
    description: string;
    reportedById: string;
    tenantId: string;
    createdAt: string;
}

export interface CreateIncidentRequest {
    type: string;
    severity: Incident['severity'];
    description: string;
    visitId?: string;
    clientId?: string;
}

// ─── Lead Module ──────────────────────────────────────────────────────────

export interface Lead {
    id: string;
    name: string;
    email?: string;
    phone?: string;
    source: string;
    status: 'new' | 'contacted' | 'qualified' | 'converted' | 'lost';
    notes?: string;
    tenantId: string;
    createdAt: string;
}

export interface CreateLeadRequest {
    name: string;
    email?: string;
    phone?: string;
    source: string;
    notes?: string;
}

// ─── Timesheet Module ─────────────────────────────────────────────────────

export interface Timesheet {
    id: string;
    pswId: string;
    status: 'draft' | 'submitted' | 'approved' | 'rejected';
    periodStart: string;
    periodEnd: string;
    totalHours: number;
    items: TimesheetItem[];
    tenantId: string;
}

export interface TimesheetItem {
    id: string;
    visitId: string;
    hours: number;
    date: string;
    status: string;
}

// ─── Booking Module ───────────────────────────────────────────────────────

export interface Booking {
    id: string;
    clientId: string;
    serviceId: string;
    status: string;
    scheduledAt: string;
    tenantId: string;
}

export interface CreateBookingRequest {
    clientId: string;
    serviceId: string;
    scheduledAt: string;
    notes?: string;
}

// ─── PSW Module ───────────────────────────────────────────────────────────

export interface PswProfile {
    id: string;
    userId: string;
    certifications: string[];
    availabilityStatus: string;
    rating: number;
    totalVisits: number;
}

export interface PswAvailability {
    dayOfWeek: number;
    startTime: string;
    endTime: string;
    isAvailable: boolean;
}

// ─── Client Module ────────────────────────────────────────────────────────

export interface ClientProfile {
    id: string;
    userId: string;
    address?: string;
    emergencyContact?: string;
    medicalNotes?: string;
    fundingSource?: string;
    status: string;
}

// ─── Home Stats ──────────────────────────────────────────────────────

export interface AdminDashboardStats {
    totalUsers: number;
    totalClients: number;
    totalProviders: number;
    activeVisits: number;
    pendingBookings: number;
    monthlyRevenue: number;
    openIncidents: number;
    complianceScore: number;
}

// ─── Audit Log ────────────────────────────────────────────────────────────

export interface AuditLog {
    id: string;
    actorUserId: string;
    action: string;
    resourceType: string;
    resourceId: string;
    details?: string;
    ipAddress?: string;
    tenantId: string;
    createdAt: string;
}

// ─── WebSocket Events ─────────────────────────────────────────────────────

export type RealtimeEventType =
    | 'visit.updated'
    | 'visit.completed'
    | 'incident.created'
    | 'booking.created'
    | 'notification.new'
    | 'dispatch.updated'
    | 'fleet.heartbeat';

export interface RealtimeEvent<T = unknown> {
    type: RealtimeEventType;
    timestamp: string;
    tenantId: string;
    data: T;
}
