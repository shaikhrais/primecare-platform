/**
 * Data Registry, Page Builder, Scheduling & Domain Rules Tests — Phase 34
 *
 * Self-contained replicas of logic from:
 * - DataRegistry.ts: Role enum, VisitStatus enum, TicketStatus enum, provinces
 * - page-builder.ts: category prefixes, serial numbering, page ID construction
 * - Scheduling logic: shift overlap, time-slot allocation, availability matching
 * - Domain rules: visit lifecycle, timesheet processing, lead pipeline, incident triage
 * - String & ID utilities: slug generation, ID prefixes, display name formatting
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. DataRegistry — Roles & Status Enums (replicated from DataRegistry.ts)
// ═══════════════════════════════════════════════════════════════════════════

const Role = {
    CLIENT: 'client',
    PSW: 'psw',
    ADMIN: 'admin',
    STAFF: 'staff',
    COORDINATOR: 'coordinator',
    FINANCE: 'finance',
    FINANCE_DIRECTOR: 'finance_director',
    SCRUM_MASTER: 'scrum_master',
} as const;

const VisitStatus = {
    REQUESTED: 'requested',
    SCHEDULED: 'scheduled',
    COMPLETED: 'completed',
    CANCELLED: 'cancelled',
} as const;

const TicketStatus = {
    OPEN: 'open',
    IN_PROGRESS: 'in_progress',
    RESOLVED: 'resolved',
    CLOSED: 'closed',
} as const;

const Provinces = [
    { code: 'ON', name: 'Ontario' },
    { code: 'BC', name: 'British Columbia' },
    { code: 'AB', name: 'Alberta' },
] as const;

function isValidRole(role: string): boolean {
    return Object.values(Role).includes(role as any);
}

function isValidVisitStatus(status: string): boolean {
    return Object.values(VisitStatus).includes(status as any);
}

function isValidTicketStatus(status: string): boolean {
    return Object.values(TicketStatus).includes(status as any);
}

function getProvinceName(code: string): string | undefined {
    return Provinces.find(p => p.code === code)?.name;
}

describe('DataRegistry — Roles', () => {
    it('CLIENT', () => expect(Role.CLIENT).toBe('client'));
    it('PSW', () => expect(Role.PSW).toBe('psw'));
    it('ADMIN', () => expect(Role.ADMIN).toBe('admin'));
    it('STAFF', () => expect(Role.STAFF).toBe('staff'));
    it('COORDINATOR', () => expect(Role.COORDINATOR).toBe('coordinator'));
    it('FINANCE', () => expect(Role.FINANCE).toBe('finance'));
    it('FINANCE_DIRECTOR', () => expect(Role.FINANCE_DIRECTOR).toBe('finance_director'));
    it('SCRUM_MASTER', () => expect(Role.SCRUM_MASTER).toBe('scrum_master'));
    it('8 roles total', () => expect(Object.keys(Role).length).toBe(8));
});

describe('DataRegistry — Role Validation', () => {
    it('client valid', () => expect(isValidRole('client')).toBe(true));
    it('admin valid', () => expect(isValidRole('admin')).toBe(true));
    it('psw valid', () => expect(isValidRole('psw')).toBe(true));
    it('unknown invalid', () => expect(isValidRole('superhero')).toBe(false));
});

describe('DataRegistry — Visit Status', () => {
    it('REQUESTED', () => expect(VisitStatus.REQUESTED).toBe('requested'));
    it('SCHEDULED', () => expect(VisitStatus.SCHEDULED).toBe('scheduled'));
    it('COMPLETED', () => expect(VisitStatus.COMPLETED).toBe('completed'));
    it('CANCELLED', () => expect(VisitStatus.CANCELLED).toBe('cancelled'));
    it('valid check', () => expect(isValidVisitStatus('scheduled')).toBe(true));
    it('invalid check', () => expect(isValidVisitStatus('pending')).toBe(false));
});

describe('DataRegistry — Ticket Status', () => {
    it('OPEN', () => expect(TicketStatus.OPEN).toBe('open'));
    it('IN_PROGRESS', () => expect(TicketStatus.IN_PROGRESS).toBe('in_progress'));
    it('RESOLVED', () => expect(TicketStatus.RESOLVED).toBe('resolved'));
    it('CLOSED', () => expect(TicketStatus.CLOSED).toBe('closed'));
    it('valid check', () => expect(isValidTicketStatus('open')).toBe(true));
    it('invalid check', () => expect(isValidTicketStatus('pending')).toBe(false));
});

describe('DataRegistry — Provinces', () => {
    it('Ontario', () => expect(getProvinceName('ON')).toBe('Ontario'));
    it('BC', () => expect(getProvinceName('BC')).toBe('British Columbia'));
    it('Alberta', () => expect(getProvinceName('AB')).toBe('Alberta'));
    it('unknown', () => expect(getProvinceName('QC')).toBeUndefined());
    it('3 provinces', () => expect(Provinces.length).toBe(3));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Page Builder — Category Codes & Serial Numbering (replicated)
// ═══════════════════════════════════════════════════════════════════════════

const CATEGORY_PREFIXES: Record<string, string> = {
    home: 'D',
    list: 'L',
    hub: 'H',
    form: 'F',
    wizard: 'W',
    report: 'R',
    tool: 'T',
    error: 'E',
    portal: 'P',
    settings: 'S',
    registry: 'RG',
};

function getCategoryPrefix(type: string): string {
    return CATEGORY_PREFIXES[type] || 'X';
}

function buildCategoryCode(prefix: string, counter: number): string {
    return `${prefix}${counter}`;
}

function buildPageLabel(srNo: number, categoryCode: string, label: string): string {
    return `[#${srNo} ${categoryCode}] ${label}`;
}

function buildPageId(prefix: string, id: string): string {
    return `page.${id}`;
}

function extractTypeFromRoute(route: string): string {
    if (route.startsWith('/login') || route.startsWith('/register') || route.startsWith('/forgot') || route.startsWith('/reset') || route.startsWith('/onboard')) return 'form';
    if (route.includes('/home')) return 'home';
    if (route.includes('/hub')) return 'hub';
    if (route.includes('/report')) return 'report';
    return 'list';
}

describe('PageBuilder — Category Prefixes', () => {
    it('home = D', () => expect(getCategoryPrefix('home')).toBe('D'));
    it('list = L', () => expect(getCategoryPrefix('list')).toBe('L'));
    it('hub = H', () => expect(getCategoryPrefix('hub')).toBe('H'));
    it('form = F', () => expect(getCategoryPrefix('form')).toBe('F'));
    it('wizard = W', () => expect(getCategoryPrefix('wizard')).toBe('W'));
    it('report = R', () => expect(getCategoryPrefix('report')).toBe('R'));
    it('tool = T', () => expect(getCategoryPrefix('tool')).toBe('T'));
    it('error = E', () => expect(getCategoryPrefix('error')).toBe('E'));
    it('portal = P', () => expect(getCategoryPrefix('portal')).toBe('P'));
    it('registry = RG', () => expect(getCategoryPrefix('registry')).toBe('RG'));
    it('unknown = X', () => expect(getCategoryPrefix('unknown')).toBe('X'));
});

describe('PageBuilder — Category Code', () => {
    it('D1', () => expect(buildCategoryCode('D', 1)).toBe('D1'));
    it('L5', () => expect(buildCategoryCode('L', 5)).toBe('L5'));
    it('RG2', () => expect(buildCategoryCode('RG', 2)).toBe('RG2'));
});

describe('PageBuilder — Label', () => {
    it('builds label', () => expect(buildPageLabel(1, 'D1', 'Admin Home')).toBe('[#1 D1] Admin Home'));
    it('large number', () => expect(buildPageLabel(99, 'L15', 'Users')).toBe('[#99 L15] Users'));
});

describe('PageBuilder — Page ID', () => {
    it('builds ID', () => expect(buildPageId('page', 'admin.home')).toBe('page.admin.home'));
});

describe('PageBuilder — Route Type', () => {
    it('login = form', () => expect(extractTypeFromRoute('/login')).toBe('form'));
    it('register = form', () => expect(extractTypeFromRoute('/register')).toBe('form'));
    it('home = home', () => expect(extractTypeFromRoute('/admin/home')).toBe('home'));
    it('hub = hub', () => expect(extractTypeFromRoute('/finance/hub')).toBe('hub'));
    it('report = report', () => expect(extractTypeFromRoute('/reports/monthly')).toBe('report'));
    it('default = list', () => expect(extractTypeFromRoute('/admin/users')).toBe('list'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Scheduling — Shift Overlap & Time-Slot Logic
// ═══════════════════════════════════════════════════════════════════════════

function hasTimeOverlap(start1: number, end1: number, start2: number, end2: number): boolean {
    return start1 < end2 && start2 < end1;
}

function getShiftDurationHours(start: string, end: string): number {
    const s = new Date(start).getTime();
    const e = new Date(end).getTime();
    return (e - s) / (1000 * 60 * 60);
}

function isWithinShift(checkTime: number, shiftStart: number, shiftEnd: number): boolean {
    return checkTime >= shiftStart && checkTime <= shiftEnd;
}

function splitIntoSlots(startHour: number, endHour: number, slotDuration: number): Array<{ start: number; end: number }> {
    const slots: Array<{ start: number; end: number }> = [];
    for (let h = startHour; h < endHour; h += slotDuration) {
        slots.push({ start: h, end: Math.min(h + slotDuration, endHour) });
    }
    return slots;
}

function countAvailableSlots(slots: Array<{ start: number; end: number }>, bookedSlots: Array<{ start: number; end: number }>): number {
    return slots.filter(slot => !bookedSlots.some(b => hasTimeOverlap(slot.start, slot.end, b.start, b.end))).length;
}

describe('Scheduling — Time Overlap', () => {
    it('overlapping', () => expect(hasTimeOverlap(9, 12, 11, 14)).toBe(true));
    it('no overlap', () => expect(hasTimeOverlap(9, 12, 13, 15)).toBe(false));
    it('adjacent', () => expect(hasTimeOverlap(9, 12, 12, 15)).toBe(false));
    it('contained', () => expect(hasTimeOverlap(9, 15, 10, 14)).toBe(true));
    it('same', () => expect(hasTimeOverlap(9, 12, 9, 12)).toBe(true));
});

describe('Scheduling — Shift Duration', () => {
    it('8 hours', () => expect(getShiftDurationHours('2026-01-01T09:00:00', '2026-01-01T17:00:00')).toBe(8));
    it('4 hours', () => expect(getShiftDurationHours('2026-01-01T13:00:00', '2026-01-01T17:00:00')).toBe(4));
    it('0.5 hours', () => expect(getShiftDurationHours('2026-01-01T09:00:00', '2026-01-01T09:30:00')).toBe(0.5));
});

describe('Scheduling — Within Shift', () => {
    it('within', () => expect(isWithinShift(10, 9, 17)).toBe(true));
    it('at start', () => expect(isWithinShift(9, 9, 17)).toBe(true));
    it('at end', () => expect(isWithinShift(17, 9, 17)).toBe(true));
    it('before', () => expect(isWithinShift(8, 9, 17)).toBe(false));
    it('after', () => expect(isWithinShift(18, 9, 17)).toBe(false));
});

describe('Scheduling — Split Slots', () => {
    it('1-hour slots', () => expect(splitIntoSlots(9, 17, 1).length).toBe(8));
    it('2-hour slots', () => expect(splitIntoSlots(9, 17, 2).length).toBe(4));
    it('4-hour slots', () => expect(splitIntoSlots(9, 17, 4).length).toBe(2));
    it('slot boundaries', () => {
        const slots = splitIntoSlots(9, 12, 1);
        expect(slots[0]).toEqual({ start: 9, end: 10 });
        expect(slots[2]).toEqual({ start: 11, end: 12 });
    });
});

describe('Scheduling — Available Slots', () => {
    it('all available', () => {
        const slots = splitIntoSlots(9, 12, 1);
        expect(countAvailableSlots(slots, [])).toBe(3);
    });
    it('one booked', () => {
        const slots = splitIntoSlots(9, 12, 1);
        expect(countAvailableSlots(slots, [{ start: 10, end: 11 }])).toBe(2);
    });
    it('all booked', () => {
        const slots = splitIntoSlots(9, 12, 1);
        expect(countAvailableSlots(slots, [{ start: 9, end: 12 }])).toBe(0);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Domain Rules — Visit Lifecycle
// ═══════════════════════════════════════════════════════════════════════════

function canTransitionVisit(from: string, to: string): boolean {
    const transitions: Record<string, string[]> = {
        requested: ['scheduled', 'cancelled'],
        scheduled: ['in_progress', 'cancelled', 'no_show'],
        in_progress: ['completed'],
        completed: [],
        cancelled: [],
        no_show: [],
    };
    return transitions[from]?.includes(to) ?? false;
}

function isTerminalVisitStatus(status: string): boolean {
    return ['completed', 'cancelled', 'no_show'].includes(status);
}

function requiresApproval(status: string): boolean {
    return ['completed'].includes(status);
}

describe('Visit Lifecycle — Transitions', () => {
    it('requested -> scheduled', () => expect(canTransitionVisit('requested', 'scheduled')).toBe(true));
    it('requested -> cancelled', () => expect(canTransitionVisit('requested', 'cancelled')).toBe(true));
    it('scheduled -> in_progress', () => expect(canTransitionVisit('scheduled', 'in_progress')).toBe(true));
    it('scheduled -> no_show', () => expect(canTransitionVisit('scheduled', 'no_show')).toBe(true));
    it('in_progress -> completed', () => expect(canTransitionVisit('in_progress', 'completed')).toBe(true));
    it('completed -> X', () => expect(canTransitionVisit('completed', 'cancelled')).toBe(false));
    it('cancelled -> X', () => expect(canTransitionVisit('cancelled', 'scheduled')).toBe(false));
    it('no_show -> X', () => expect(canTransitionVisit('no_show', 'in_progress')).toBe(false));
});

describe('Visit Lifecycle — Terminal', () => {
    it('completed', () => expect(isTerminalVisitStatus('completed')).toBe(true));
    it('cancelled', () => expect(isTerminalVisitStatus('cancelled')).toBe(true));
    it('no_show', () => expect(isTerminalVisitStatus('no_show')).toBe(true));
    it('scheduled not terminal', () => expect(isTerminalVisitStatus('scheduled')).toBe(false));
    it('in_progress not terminal', () => expect(isTerminalVisitStatus('in_progress')).toBe(false));
});

describe('Visit Lifecycle — Approval', () => {
    it('completed requires', () => expect(requiresApproval('completed')).toBe(true));
    it('scheduled does not', () => expect(requiresApproval('scheduled')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Domain Rules — Timesheet Processing
// ═══════════════════════════════════════════════════════════════════════════

function canTransitionTimesheet(from: string, to: string): boolean {
    const transitions: Record<string, string[]> = {
        draft: ['submitted'],
        submitted: ['approved', 'rejected'],
        approved: [],
        rejected: ['draft'],
    };
    return transitions[from]?.includes(to) ?? false;
}

function calculateTotalHours(items: Array<{ hours: number }>): number {
    return items.reduce((sum, item) => sum + item.hours, 0);
}

function isOvertimeWeek(totalHours: number, threshold: number = 44): boolean {
    return totalHours > threshold;
}

function calculateOvertimeHours(totalHours: number, threshold: number = 44): number {
    return Math.max(0, totalHours - threshold);
}

describe('Timesheet — Transitions', () => {
    it('draft -> submitted', () => expect(canTransitionTimesheet('draft', 'submitted')).toBe(true));
    it('submitted -> approved', () => expect(canTransitionTimesheet('submitted', 'approved')).toBe(true));
    it('submitted -> rejected', () => expect(canTransitionTimesheet('submitted', 'rejected')).toBe(true));
    it('rejected -> draft', () => expect(canTransitionTimesheet('rejected', 'draft')).toBe(true));
    it('approved -> X', () => expect(canTransitionTimesheet('approved', 'draft')).toBe(false));
    it('draft -> approved skip', () => expect(canTransitionTimesheet('draft', 'approved')).toBe(false));
});

describe('Timesheet — Hours', () => {
    it('total', () => expect(calculateTotalHours([{ hours: 8 }, { hours: 8 }, { hours: 4 }])).toBe(20));
    it('empty', () => expect(calculateTotalHours([])).toBe(0));
    it('overtime check', () => expect(isOvertimeWeek(50)).toBe(true));
    it('no overtime', () => expect(isOvertimeWeek(40)).toBe(false));
    it('exact threshold', () => expect(isOvertimeWeek(44)).toBe(false));
    it('overtime hours', () => expect(calculateOvertimeHours(50)).toBe(6));
    it('no overtime hours', () => expect(calculateOvertimeHours(40)).toBe(0));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Domain Rules — Lead Pipeline
// ═══════════════════════════════════════════════════════════════════════════

function canTransitionLead(from: string, to: string): boolean {
    const transitions: Record<string, string[]> = {
        new: ['contacted', 'lost'],
        contacted: ['qualified', 'lost'],
        qualified: ['converted', 'lost'],
        converted: [],
        lost: ['new'],
    };
    return transitions[from]?.includes(to) ?? false;
}

function getLeadScore(status: string): number {
    const scores: Record<string, number> = { new: 10, contacted: 30, qualified: 60, converted: 100, lost: 0 };
    return scores[status] ?? 0;
}

function isActiveLead(status: string): boolean {
    return ['new', 'contacted', 'qualified'].includes(status);
}

describe('Lead Pipeline — Transitions', () => {
    it('new -> contacted', () => expect(canTransitionLead('new', 'contacted')).toBe(true));
    it('new -> lost', () => expect(canTransitionLead('new', 'lost')).toBe(true));
    it('contacted -> qualified', () => expect(canTransitionLead('contacted', 'qualified')).toBe(true));
    it('qualified -> converted', () => expect(canTransitionLead('qualified', 'converted')).toBe(true));
    it('converted -> X', () => expect(canTransitionLead('converted', 'lost')).toBe(false));
    it('lost -> new reopen', () => expect(canTransitionLead('lost', 'new')).toBe(true));
    it('new -> converted skip', () => expect(canTransitionLead('new', 'converted')).toBe(false));
});

describe('Lead Pipeline — Scoring', () => {
    it('new = 10', () => expect(getLeadScore('new')).toBe(10));
    it('contacted = 30', () => expect(getLeadScore('contacted')).toBe(30));
    it('qualified = 60', () => expect(getLeadScore('qualified')).toBe(60));
    it('converted = 100', () => expect(getLeadScore('converted')).toBe(100));
    it('lost = 0', () => expect(getLeadScore('lost')).toBe(0));
});

describe('Lead Pipeline — Active', () => {
    it('new active', () => expect(isActiveLead('new')).toBe(true));
    it('contacted active', () => expect(isActiveLead('contacted')).toBe(true));
    it('qualified active', () => expect(isActiveLead('qualified')).toBe(true));
    it('converted not active', () => expect(isActiveLead('converted')).toBe(false));
    it('lost not active', () => expect(isActiveLead('lost')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 7. Domain Rules — Incident Triage
// ═══════════════════════════════════════════════════════════════════════════

function canTransitionIncident(from: string, to: string): boolean {
    const transitions: Record<string, string[]> = {
        open: ['investigating', 'resolved', 'closed'],
        investigating: ['resolved', 'closed'],
        resolved: ['closed', 'open'],
        closed: [],
    };
    return transitions[from]?.includes(to) ?? false;
}

function getSeverityWeight(severity: string): number {
    const weights: Record<string, number> = { low: 1, medium: 2, high: 3, critical: 4 };
    return weights[severity] ?? 0;
}

function getResponseSLA(severity: string): number {
    const slas: Record<string, number> = { low: 72, medium: 24, high: 4, critical: 1 };
    return slas[severity] ?? 72;
}

function isEscalationRequired(severity: string): boolean {
    return ['high', 'critical'].includes(severity);
}

describe('Incident Triage — Transitions', () => {
    it('open -> investigating', () => expect(canTransitionIncident('open', 'investigating')).toBe(true));
    it('open -> resolved', () => expect(canTransitionIncident('open', 'resolved')).toBe(true));
    it('investigating -> resolved', () => expect(canTransitionIncident('investigating', 'resolved')).toBe(true));
    it('resolved -> closed', () => expect(canTransitionIncident('resolved', 'closed')).toBe(true));
    it('resolved -> reopen', () => expect(canTransitionIncident('resolved', 'open')).toBe(true));
    it('closed -> X', () => expect(canTransitionIncident('closed', 'open')).toBe(false));
});

describe('Incident Triage — Severity', () => {
    it('low = 1', () => expect(getSeverityWeight('low')).toBe(1));
    it('medium = 2', () => expect(getSeverityWeight('medium')).toBe(2));
    it('high = 3', () => expect(getSeverityWeight('high')).toBe(3));
    it('critical = 4', () => expect(getSeverityWeight('critical')).toBe(4));
    it('unknown = 0', () => expect(getSeverityWeight('extreme')).toBe(0));
});

describe('Incident Triage — SLA', () => {
    it('low = 72h', () => expect(getResponseSLA('low')).toBe(72));
    it('medium = 24h', () => expect(getResponseSLA('medium')).toBe(24));
    it('high = 4h', () => expect(getResponseSLA('high')).toBe(4));
    it('critical = 1h', () => expect(getResponseSLA('critical')).toBe(1));
});

describe('Incident Triage — Escalation', () => {
    it('critical requires', () => expect(isEscalationRequired('critical')).toBe(true));
    it('high requires', () => expect(isEscalationRequired('high')).toBe(true));
    it('medium does not', () => expect(isEscalationRequired('medium')).toBe(false));
    it('low does not', () => expect(isEscalationRequired('low')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 8. String & ID Utilities
// ═══════════════════════════════════════════════════════════════════════════

function generateSlug(text: string): string {
    return text.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

function buildEntityId(prefix: string, uuid: string): string {
    return `${prefix}_${uuid}`;
}

function formatDisplayName(first: string, last: string): string {
    return `${first} ${last}`.trim();
}

function getInitials(name: string): string {
    return name.split(' ').map(w => w[0]?.toUpperCase() || '').join('');
}

function truncateText(text: string, maxLength: number): string {
    return text.length > maxLength ? text.slice(0, maxLength) + '...' : text;
}

function maskSensitiveId(id: string): string {
    if (id.length <= 8) return '****';
    return id.slice(0, 4) + '****' + id.slice(-4);
}

describe('Utilities — Slug', () => {
    it('basic', () => expect(generateSlug('Hello World')).toBe('hello-world'));
    it('special chars', () => expect(generateSlug('Hello & World!')).toBe('hello-world'));
    it('spaces', () => expect(generateSlug('  multiple   spaces  ')).toBe('multiple-spaces'));
    it('numbers', () => expect(generateSlug('Test 123')).toBe('test-123'));
});

describe('Utilities — Entity ID', () => {
    it('user', () => expect(buildEntityId('usr', 'abc123')).toBe('usr_abc123'));
    it('tenant', () => expect(buildEntityId('tnt', 'xyz789')).toBe('tnt_xyz789'));
});

describe('Utilities — Display Name', () => {
    it('full name', () => expect(formatDisplayName('John', 'Doe')).toBe('John Doe'));
    it('first only', () => expect(formatDisplayName('John', '')).toBe('John'));
});

describe('Utilities — Initials', () => {
    it('two words', () => expect(getInitials('John Doe')).toBe('JD'));
    it('three words', () => expect(getInitials('John A Doe')).toBe('JAD'));
    it('single', () => expect(getInitials('John')).toBe('J'));
});

describe('Utilities — Truncate', () => {
    it('short text', () => expect(truncateText('Hello', 10)).toBe('Hello'));
    it('long text', () => expect(truncateText('Hello World Test', 5)).toBe('Hello...'));
});

describe('Utilities — Mask ID', () => {
    it('masks long ID', () => expect(maskSensitiveId('abcdefghijkl')).toBe('abcd****ijkl'));
    it('short ID', () => expect(maskSensitiveId('abc')).toBe('****'));
});
