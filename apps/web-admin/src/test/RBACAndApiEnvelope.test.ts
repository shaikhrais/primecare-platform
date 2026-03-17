/**
 * RBAC Guards, API Response Envelope, Audit Logging & Advanced Domain — Phase 37
 *
 * Self-contained replicas of logic from:
 * - rbac.ts: requireRole umbrella matching, super_admin bypass, permission guards
 * - api-response.ts: success/error/paginated/created/noContent envelope patterns
 * - audit.ts: audit log entry construction, metadata serialization
 * - Advanced domain: care plan management, medication scheduling, fleet tracking
 * - Date/time utilities: business hours, holiday detection, age calculation
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. RBAC — Role Guards with Umbrella Matching (replicated from rbac.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SERVICE_PROVIDERS = ['psw', 'rn', 'rmt', 'rpt', 'rch'];
const STAFF_SUBROLES = ['staff', 'finance', 'hr', 'compliance', 'finance_manager', 'hr_manager'];
const MANAGER_SUBROLES = ['manager', 'marketing_manager', 'operations_manager', 'clinical_manager', 'regional_manager', 'recruiting_manager', 'coordinator', 'crm', 'training'];

function checkRoleAccess(userRoles: string[], allowedRoles: string[]): boolean {
    return userRoles.some(role => {
        const lower = role.toLowerCase();
        if (lower === 'super_admin' || lower === 'scrum_master') return true;
        if (allowedRoles.includes(role)) return true;
        if (allowedRoles.includes('manager') && MANAGER_SUBROLES.includes(lower)) return true;
        if (allowedRoles.includes('service_provider') && SERVICE_PROVIDERS.includes(lower)) return true;
        if (allowedRoles.includes('staff') && STAFF_SUBROLES.includes(lower)) return true;
        return false;
    });
}

function isSuperRole(role: string): boolean {
    return role.toLowerCase() === 'super_admin' || role.toLowerCase() === 'scrum_master';
}

function parseUserRoles(roles: any): string[] {
    if (Array.isArray(roles)) return roles;
    if (typeof roles === 'string') return [roles];
    return [];
}

describe('RBAC — Super Admin Bypass', () => {
    it('super_admin always', () => expect(checkRoleAccess(['super_admin'], ['psw'])).toBe(true));
    it('scrum_master always', () => expect(checkRoleAccess(['scrum_master'], ['coordinator'])).toBe(true));
    it('isSuperRole super_admin', () => expect(isSuperRole('super_admin')).toBe(true));
    it('isSuperRole scrum_master', () => expect(isSuperRole('scrum_master')).toBe(true));
    it('isSuperRole admin', () => expect(isSuperRole('admin')).toBe(false));
});

describe('RBAC — Direct Role Match', () => {
    it('admin direct', () => expect(checkRoleAccess(['admin'], ['admin'])).toBe(true));
    it('psw direct', () => expect(checkRoleAccess(['psw'], ['psw'])).toBe(true));
    it('no match', () => expect(checkRoleAccess(['psw'], ['admin'])).toBe(false));
});

describe('RBAC — Manager Umbrella', () => {
    it('marketing_manager', () => expect(checkRoleAccess(['marketing_manager'], ['manager'])).toBe(true));
    it('operations_manager', () => expect(checkRoleAccess(['operations_manager'], ['manager'])).toBe(true));
    it('clinical_manager', () => expect(checkRoleAccess(['clinical_manager'], ['manager'])).toBe(true));
    it('coordinator as manager', () => expect(checkRoleAccess(['coordinator'], ['manager'])).toBe(true));
    it('training as manager', () => expect(checkRoleAccess(['training'], ['manager'])).toBe(true));
    it('crm as manager', () => expect(checkRoleAccess(['crm'], ['manager'])).toBe(true));
    it('psw not manager', () => expect(checkRoleAccess(['psw'], ['manager'])).toBe(false));
});

describe('RBAC — Service Provider Umbrella', () => {
    it('psw as service_provider', () => expect(checkRoleAccess(['psw'], ['service_provider'])).toBe(true));
    it('rn as service_provider', () => expect(checkRoleAccess(['rn'], ['service_provider'])).toBe(true));
    it('rmt as service_provider', () => expect(checkRoleAccess(['rmt'], ['service_provider'])).toBe(true));
    it('rpt as service_provider', () => expect(checkRoleAccess(['rpt'], ['service_provider'])).toBe(true));
    it('rch as service_provider', () => expect(checkRoleAccess(['rch'], ['service_provider'])).toBe(true));
    it('admin not service_provider', () => expect(checkRoleAccess(['admin'], ['service_provider'])).toBe(false));
});

describe('RBAC — Staff Umbrella', () => {
    it('finance as staff', () => expect(checkRoleAccess(['finance'], ['staff'])).toBe(true));
    it('hr as staff', () => expect(checkRoleAccess(['hr'], ['staff'])).toBe(true));
    it('compliance as staff', () => expect(checkRoleAccess(['compliance'], ['staff'])).toBe(true));
    it('finance_manager as staff', () => expect(checkRoleAccess(['finance_manager'], ['staff'])).toBe(true));
    it('staff as staff', () => expect(checkRoleAccess(['staff'], ['staff'])).toBe(true));
    it('psw not staff', () => expect(checkRoleAccess(['psw'], ['staff'])).toBe(false));
});

describe('RBAC — Multi-Role', () => {
    it('multi has one match', () => expect(checkRoleAccess(['psw', 'admin'], ['admin'])).toBe(true));
    it('multi no match', () => expect(checkRoleAccess(['psw', 'rn'], ['admin', 'finance'])).toBe(false));
});

describe('RBAC — Parse Roles', () => {
    it('array', () => expect(parseUserRoles(['admin'])).toEqual(['admin']));
    it('string', () => expect(parseUserRoles('admin')).toEqual(['admin']));
    it('null', () => expect(parseUserRoles(null)).toEqual([]));
    it('undefined', () => expect(parseUserRoles(undefined)).toEqual([]));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. API Response Envelope (replicated from api-response.ts)
// ═══════════════════════════════════════════════════════════════════════════

function buildSuccessEnvelope<T>(data: T, meta?: any) {
    return { success: true, data, meta: meta || null, error: null };
}

function buildErrorEnvelope(message: string, details?: any) {
    return { success: false, data: null, meta: null, error: { message, ...(details ? { details } : {}) } };
}

function buildPaginatedEnvelope<T>(items: T[], page: number, limit: number, total: number) {
    return {
        success: true,
        data: items,
        meta: {
            page, limit, total,
            totalPages: Math.ceil(total / limit),
            hasNext: page * limit < total,
            hasPrev: page > 1,
        },
        error: null,
    };
}

describe('API Envelope — Success', () => {
    it('with data', () => {
        const r = buildSuccessEnvelope({ id: '1' });
        expect(r.success).toBe(true);
        expect(r.data.id).toBe('1');
        expect(r.error).toBeNull();
    });
    it('with meta', () => {
        const r = buildSuccessEnvelope([], { page: 1 });
        expect(r.meta.page).toBe(1);
    });
    it('without meta', () => {
        const r = buildSuccessEnvelope('data');
        expect(r.meta).toBeNull();
    });
});

describe('API Envelope — Error', () => {
    it('basic', () => {
        const r = buildErrorEnvelope('Not found');
        expect(r.success).toBe(false);
        expect(r.data).toBeNull();
        expect(r.error.message).toBe('Not found');
    });
    it('with details', () => {
        const r = buildErrorEnvelope('Validation failed', { fields: ['name'] });
        expect(r.error.details.fields).toEqual(['name']);
    });
});

describe('API Envelope — Paginated', () => {
    it('first page', () => {
        const r = buildPaginatedEnvelope([1, 2, 3], 1, 10, 30);
        expect(r.meta.totalPages).toBe(3);
        expect(r.meta.hasNext).toBe(true);
        expect(r.meta.hasPrev).toBe(false);
    });
    it('middle page', () => {
        const r = buildPaginatedEnvelope([4, 5, 6], 2, 3, 9);
        expect(r.meta.hasNext).toBe(true);
        expect(r.meta.hasPrev).toBe(true);
    });
    it('last page', () => {
        const r = buildPaginatedEnvelope([7, 8, 9], 3, 3, 9);
        expect(r.meta.hasNext).toBe(false);
        expect(r.meta.hasPrev).toBe(true);
    });
    it('single page', () => {
        const r = buildPaginatedEnvelope([1, 2], 1, 10, 2);
        expect(r.meta.totalPages).toBe(1);
        expect(r.meta.hasNext).toBe(false);
        expect(r.meta.hasPrev).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Audit Log — Entry Construction (replicated from audit.ts)
// ═══════════════════════════════════════════════════════════════════════════

function buildAuditEntry(userId: string | null, action: string, resourceType: string, resourceId: string | null, metadata: any, tenantId?: string) {
    return {
        tenantId: tenantId || metadata?.tenantId || 'system',
        actorUserId: userId,
        action,
        resourceType,
        resourceId,
        metadata: typeof metadata === 'string' ? metadata : JSON.stringify(metadata),
        createdAt: new Date().toISOString(),
    };
}

function isValidAuditAction(action: string): boolean {
    const valid = ['CREATE', 'READ', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT', 'EXPORT', 'IMPORT', 'APPROVE', 'REJECT', 'ASSIGN', 'UNASSIGN'];
    return valid.includes(action);
}

describe('Audit — Entry', () => {
    it('basic entry', () => {
        const e = buildAuditEntry('u-1', 'CREATE', 'User', 'r-1', { tenantId: 't-1' });
        expect(e.tenantId).toBe('t-1');
        expect(e.actorUserId).toBe('u-1');
        expect(e.action).toBe('CREATE');
        expect(e.resourceType).toBe('User');
        expect(e.resourceId).toBe('r-1');
    });
    it('metadata serialized', () => {
        const e = buildAuditEntry('u-1', 'UPDATE', 'Visit', 'v-1', { field: 'status' });
        expect(JSON.parse(e.metadata)).toEqual({ field: 'status' });
    });
    it('string metadata', () => {
        const e = buildAuditEntry('u-1', 'UPDATE', 'Visit', 'v-1', 'raw string');
        expect(e.metadata).toBe('raw string');
    });
    it('system tenant fallback', () => {
        const e = buildAuditEntry(null, 'LOGIN', 'Auth', null, {});
        expect(e.tenantId).toBe('system');
    });
    it('explicit tenant override', () => {
        const e = buildAuditEntry('u-1', 'CREATE', 'User', 'r-1', {}, 't-override');
        expect(e.tenantId).toBe('t-override');
    });
});

describe('Audit — Valid Actions', () => {
    it('CREATE', () => expect(isValidAuditAction('CREATE')).toBe(true));
    it('READ', () => expect(isValidAuditAction('READ')).toBe(true));
    it('UPDATE', () => expect(isValidAuditAction('UPDATE')).toBe(true));
    it('DELETE', () => expect(isValidAuditAction('DELETE')).toBe(true));
    it('LOGIN', () => expect(isValidAuditAction('LOGIN')).toBe(true));
    it('LOGOUT', () => expect(isValidAuditAction('LOGOUT')).toBe(true));
    it('EXPORT', () => expect(isValidAuditAction('EXPORT')).toBe(true));
    it('APPROVE', () => expect(isValidAuditAction('APPROVE')).toBe(true));
    it('REJECT', () => expect(isValidAuditAction('REJECT')).toBe(true));
    it('ASSIGN', () => expect(isValidAuditAction('ASSIGN')).toBe(true));
    it('invalid', () => expect(isValidAuditAction('HACK')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Care Plan & Medication Scheduling
// ═══════════════════════════════════════════════════════════════════════════

type CarePlanStatus = 'draft' | 'active' | 'on_hold' | 'completed' | 'archived';

function canTransitionCarePlan(from: CarePlanStatus, to: CarePlanStatus): boolean {
    const transitions: Record<CarePlanStatus, CarePlanStatus[]> = {
        draft: ['active'],
        active: ['on_hold', 'completed'],
        on_hold: ['active', 'completed'],
        completed: ['archived'],
        archived: [],
    };
    return transitions[from]?.includes(to) ?? false;
}

function calculateMedicationTimes(frequency: string, startHour: number = 8): number[] {
    switch (frequency) {
        case 'once_daily': return [startHour];
        case 'twice_daily': return [startHour, startHour + 12];
        case 'three_daily': return [startHour, startHour + 8, startHour + 16];
        case 'four_daily': return [startHour, startHour + 6, startHour + 12, startHour + 18];
        case 'as_needed': return [];
        default: return [startHour];
    }
}

function isDoseOverdue(scheduledHour: number, currentHour: number, gracePeriod: number = 1): boolean {
    return currentHour > scheduledHour + gracePeriod;
}

describe('Care Plan — Transitions', () => {
    it('draft -> active', () => expect(canTransitionCarePlan('draft', 'active')).toBe(true));
    it('active -> on_hold', () => expect(canTransitionCarePlan('active', 'on_hold')).toBe(true));
    it('active -> completed', () => expect(canTransitionCarePlan('active', 'completed')).toBe(true));
    it('on_hold -> active', () => expect(canTransitionCarePlan('on_hold', 'active')).toBe(true));
    it('completed -> archived', () => expect(canTransitionCarePlan('completed', 'archived')).toBe(true));
    it('archived -> X', () => expect(canTransitionCarePlan('archived', 'active')).toBe(false));
    it('draft -> completed skip', () => expect(canTransitionCarePlan('draft', 'completed')).toBe(false));
});

describe('Medication — Scheduling', () => {
    it('once daily', () => expect(calculateMedicationTimes('once_daily')).toEqual([8]));
    it('twice daily', () => expect(calculateMedicationTimes('twice_daily')).toEqual([8, 20]));
    it('three times', () => expect(calculateMedicationTimes('three_daily')).toEqual([8, 16, 24]));
    it('four times', () => expect(calculateMedicationTimes('four_daily')).toEqual([8, 14, 20, 26]));
    it('as_needed empty', () => expect(calculateMedicationTimes('as_needed')).toEqual([]));
    it('custom start', () => expect(calculateMedicationTimes('once_daily', 6)).toEqual([6]));
});

describe('Medication — Overdue', () => {
    it('overdue', () => expect(isDoseOverdue(8, 10)).toBe(true));
    it('within grace', () => expect(isDoseOverdue(8, 8.5)).toBe(false));
    it('on time', () => expect(isDoseOverdue(8, 8)).toBe(false));
    it('custom grace', () => expect(isDoseOverdue(8, 9, 2)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Fleet Tracking & Logistics
// ═══════════════════════════════════════════════════════════════════════════

function calculateETA(distanceKm: number, speedKmh: number): number {
    if (speedKmh <= 0) return Infinity;
    return Math.round((distanceKm / speedKmh) * 60);
}

function isInServiceArea(lat: number, lng: number, center: { lat: number; lng: number }, radiusKm: number): boolean {
    const R = 6371;
    const dLat = (lat - center.lat) * Math.PI / 180;
    const dLng = (lng - center.lng) * Math.PI / 180;
    const a = Math.sin(dLat / 2) ** 2 + Math.cos(center.lat * Math.PI / 180) * Math.cos(lat * Math.PI / 180) * Math.sin(dLng / 2) ** 2;
    const d = R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return d <= radiusKm;
}

type VehicleStatus = 'available' | 'enroute' | 'on_site' | 'returning' | 'offline';

function isVehicleAvailable(status: VehicleStatus): boolean {
    return status === 'available';
}

function getVehicleStatusLabel(status: VehicleStatus): string {
    const labels: Record<VehicleStatus, string> = {
        available: 'Available', enroute: 'En Route', on_site: 'On Site',
        returning: 'Returning', offline: 'Offline',
    };
    return labels[status];
}

describe('Fleet — ETA', () => {
    it('10km at 60kmh', () => expect(calculateETA(10, 60)).toBe(10));
    it('30km at 30kmh', () => expect(calculateETA(30, 30)).toBe(60));
    it('0 distance', () => expect(calculateETA(0, 60)).toBe(0));
    it('0 speed', () => expect(calculateETA(10, 0)).toBe(Infinity));
});

describe('Fleet — Service Area', () => {
    it('within area', () => expect(isInServiceArea(43.65, -79.38, {  lat: 43.65, lng: -79.38 }, 10)).toBe(true));
    it('same point', () => expect(isInServiceArea(43.65, -79.38, {  lat: 43.65, lng: -79.38 }, 0.001)).toBe(true));
    it('outside area', () => expect(isInServiceArea(44.65, -79.38, {  lat: 43.65, lng: -79.38 }, 10)).toBe(false));
});

describe('Fleet — Vehicle Status', () => {
    it('available', () => expect(isVehicleAvailable('available')).toBe(true));
    it('enroute', () => expect(isVehicleAvailable('enroute')).toBe(false));
    it('offline', () => expect(isVehicleAvailable('offline')).toBe(false));
    it('label available', () => expect(getVehicleStatusLabel('available')).toBe('Available'));
    it('label enroute', () => expect(getVehicleStatusLabel('enroute')).toBe('En Route'));
    it('label on_site', () => expect(getVehicleStatusLabel('on_site')).toBe('On Site'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Date/Time Utilities — Business Hours & Holidays
// ═══════════════════════════════════════════════════════════════════════════

function isBusinessHour(hour: number): boolean {
    return hour >= 9 && hour < 17;
}

function isWeekend(dayOfWeek: number): boolean {
    return dayOfWeek === 0 || dayOfWeek === 6;
}

function isStatutoryHoliday(date: string, holidays: string[]): boolean {
    return holidays.includes(date);
}

function calculateAge(birthDate: string, referenceDate: string): number {
    const birth = new Date(birthDate);
    const ref = new Date(referenceDate);
    let age = ref.getFullYear() - birth.getFullYear();
    const monthDiff = ref.getMonth() - birth.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && ref.getDate() < birth.getDate())) age--;
    return age;
}

function isMinor(birthDate: string, referenceDate: string): boolean {
    return calculateAge(birthDate, referenceDate) < 18;
}

function addBusinessDays(startDate: Date, days: number): Date {
    const result = new Date(startDate);
    let added = 0;
    while (added < days) {
        result.setDate(result.getDate() + 1);
        if (!isWeekend(result.getDay())) added++;
    }
    return result;
}

describe('DateTime — Business Hours', () => {
    it('9am', () => expect(isBusinessHour(9)).toBe(true));
    it('12pm', () => expect(isBusinessHour(12)).toBe(true));
    it('4pm', () => expect(isBusinessHour(16)).toBe(true));
    it('5pm (after hours)', () => expect(isBusinessHour(17)).toBe(false));
    it('8am (before hours)', () => expect(isBusinessHour(8)).toBe(false));
    it('midnight', () => expect(isBusinessHour(0)).toBe(false));
});

describe('DateTime — Weekend', () => {
    it('Sunday', () => expect(isWeekend(0)).toBe(true));
    it('Saturday', () => expect(isWeekend(6)).toBe(true));
    it('Monday', () => expect(isWeekend(1)).toBe(false));
    it('Friday', () => expect(isWeekend(5)).toBe(false));
});

describe('DateTime — Holidays', () => {
    const holidays = ['2026-01-01', '2026-07-01', '2026-12-25'];
    it('New Year', () => expect(isStatutoryHoliday('2026-01-01', holidays)).toBe(true));
    it('Canada Day', () => expect(isStatutoryHoliday('2026-07-01', holidays)).toBe(true));
    it('regular day', () => expect(isStatutoryHoliday('2026-03-15', holidays)).toBe(false));
});

describe('DateTime — Age', () => {
    it('30 years', () => expect(calculateAge('1996-01-01', '2026-03-15')).toBe(30));
    it('before birthday', () => expect(calculateAge('1996-06-15', '2026-03-15')).toBe(29));
    it('on birthday', () => expect(calculateAge('1996-03-15', '2026-03-15')).toBe(30));
});

describe('DateTime — Minor', () => {
    it('minor', () => expect(isMinor('2010-01-01', '2026-03-15')).toBe(true));
    it('adult', () => expect(isMinor('2000-01-01', '2026-03-15')).toBe(false));
    it('just turned 18', () => expect(isMinor('2008-03-15', '2026-03-15')).toBe(false));
});

describe('DateTime — Business Days', () => {
    it('adds past weekend (1 biz day from Fri = +3 calendar days)', () => {
        const start = new Date('2026-03-13T12:00:00'); // Friday noon (local)
        const result = addBusinessDays(start, 1);
        const diffDays = Math.round((result.getTime() - start.getTime()) / 86400000);
        expect(diffDays).toBe(3); // skips Sat+Sun → Monday
    });
    it('5 business days from Mon = +7 calendar days', () => {
        const start = new Date('2026-03-09T12:00:00'); // Monday noon (local)
        const result = addBusinessDays(start, 5);
        const diffDays = Math.round((result.getTime() - start.getTime()) / 86400000);
        expect(diffDays).toBe(7); // Mon→next Mon
    });
});
