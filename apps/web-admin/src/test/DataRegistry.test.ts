/**
 * DataRegistry Tests
 *
 * Validates enum definitions, province data, and structural integrity.
 */
import { describe, it, expect } from 'vitest';
import { Role, VisitStatus, TicketStatus, DataRegistry } from 'prime-care-shared';

describe('DataRegistry · Role Enum', () => {
    it('defines all expected roles', () => {
        expect(Role.CLIENT).toBe('client');
        expect(Role.PSW).toBe('psw');
        expect(Role.ADMIN).toBe('admin');
        expect(Role.STAFF).toBe('staff');
        expect(Role.COORDINATOR).toBe('coordinator');
        expect(Role.FINANCE).toBe('finance');
        expect(Role.FINANCE_DIRECTOR).toBe('finance_director');
        expect(Role.SCRUM_MASTER).toBe('scrum_master');
    });

    it('has at least 8 roles', () => {
        const roleValues = Object.values(Role);
        expect(roleValues.length).toBeGreaterThanOrEqual(8);
    });

    it('all role values are lowercase strings', () => {
        for (const val of Object.values(Role)) {
            expect(val).toBe(val.toLowerCase());
        }
    });
});

describe('DataRegistry · VisitStatus Enum', () => {
    it('defines all expected statuses', () => {
        expect(VisitStatus.REQUESTED).toBe('requested');
        expect(VisitStatus.SCHEDULED).toBe('scheduled');
        expect(VisitStatus.COMPLETED).toBe('completed');
        expect(VisitStatus.CANCELLED).toBe('cancelled');
    });

    it('has exactly 4 statuses', () => {
        const statuses = Object.values(VisitStatus);
        expect(statuses.length).toBe(4);
    });
});

describe('DataRegistry · TicketStatus Enum', () => {
    it('defines expected statuses', () => {
        expect(TicketStatus.OPEN).toBe('open');
        expect(TicketStatus.IN_PROGRESS).toBe('in_progress');
        expect(TicketStatus.CLOSED).toBe('closed');
    });

    it('has RESOLVED status', () => {
        expect(TicketStatus.RESOLVED).toBe('resolved');
    });
});

describe('DataRegistry · Composite Object', () => {
    it('exports DataRegistry as an object', () => {
        expect(DataRegistry).toBeDefined();
        expect(typeof DataRegistry).toBe('object');
    });

    it('has Roles, VisitStatus, TicketStatus, Provinces', () => {
        expect(DataRegistry).toHaveProperty('Roles');
        expect(DataRegistry).toHaveProperty('VisitStatus');
        expect(DataRegistry).toHaveProperty('TicketStatus');
        expect(DataRegistry).toHaveProperty('Provinces');
    });

    it('Provinces is an array of province objects', () => {
        expect(Array.isArray(DataRegistry.Provinces)).toBe(true);
        expect(DataRegistry.Provinces.length).toBeGreaterThanOrEqual(3);
    });

    it('every Province has code and name', () => {
        for (const province of DataRegistry.Provinces) {
            expect(province).toHaveProperty('code');
            expect(province).toHaveProperty('name');
            expect(typeof province.code).toBe('string');
            expect(typeof province.name).toBe('string');
        }
    });

    it('includes Ontario (ON)', () => {
        const on = DataRegistry.Provinces.find(p => p.code === 'ON');
        expect(on).toBeDefined();
        expect(on!.name).toBe('Ontario');
    });

    it('province codes are 2-character uppercase strings', () => {
        for (const province of DataRegistry.Provinces) {
            expect(province.code).toMatch(/^[A-Z]{2}$/);
        }
    });
});
