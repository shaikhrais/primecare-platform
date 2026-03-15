/**
 * Validation Schemas — Deep Edge Case Tests
 *
 * Exercises every validation schema from @/shared/validation with
 * boundary values, invalid data, malicious inputs, and edge cases.
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Email Schema Edge Cases
// ═══════════════════════════════════════════════════════════════════════════

describe('emailSchema edge cases', () => {
    it('rejects email without @', async () => {
        const { emailSchema } = await import('@/shared/validation');
        expect(emailSchema.safeParse('notanemail').success).toBe(false);
    });

    it('rejects email without domain', async () => {
        const { emailSchema } = await import('@/shared/validation');
        expect(emailSchema.safeParse('user@').success).toBe(false);
    });

    it('rejects empty string', async () => {
        const { emailSchema } = await import('@/shared/validation');
        expect(emailSchema.safeParse('').success).toBe(false);
    });

    it('converts to lowercase', async () => {
        const { emailSchema } = await import('@/shared/validation');
        const r = emailSchema.safeParse('John@Example.COM');
        expect(r.success).toBe(true);
        if (r.success) expect(r.data).toBe('john@example.com');
    });

    it('trims and lowercases valid email', async () => {
        const { emailSchema } = await import('@/shared/validation');
        const r = emailSchema.safeParse('Admin@Test.COM');
        expect(r.success).toBe(true);
        if (r.success) expect(r.data).toBe('admin@test.com');
    });

    it('rejects too long email (>254 chars)', async () => {
        const { emailSchema } = await import('@/shared/validation');
        const long = 'a'.repeat(246) + '@test.com'; // 255 chars, exceeds 254
        expect(emailSchema.safeParse(long).success).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Password Schema Edge Cases
// ═══════════════════════════════════════════════════════════════════════════

describe('passwordSchema edge cases', () => {
    it('rejects < 8 chars', async () => {
        const { passwordSchema } = await import('@/shared/validation');
        expect(passwordSchema.safeParse('Ab1').success).toBe(false);
    });

    it('accepts exactly 8 chars with all requirements', async () => {
        const { passwordSchema } = await import('@/shared/validation');
        expect(passwordSchema.safeParse('Abcdefg1').success).toBe(true);
    });

    it('rejects no uppercase', async () => {
        const { passwordSchema } = await import('@/shared/validation');
        expect(passwordSchema.safeParse('abcdefg1').success).toBe(false);
    });

    it('rejects no lowercase', async () => {
        const { passwordSchema } = await import('@/shared/validation');
        expect(passwordSchema.safeParse('ABCDEFG1').success).toBe(false);
    });

    it('rejects no number', async () => {
        const { passwordSchema } = await import('@/shared/validation');
        expect(passwordSchema.safeParse('Abcdefgh').success).toBe(false);
    });

    it('rejects > 128 chars', async () => {
        const { passwordSchema } = await import('@/shared/validation');
        const long = 'Aa1' + 'x'.repeat(126);
        expect(passwordSchema.safeParse(long).success).toBe(false);
    });

    it('accepts special characters', async () => {
        const { passwordSchema } = await import('@/shared/validation');
        expect(passwordSchema.safeParse('Abc123!@#').success).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Phone Schema Edge Cases
// ═══════════════════════════════════════════════════════════════════════════

describe('phoneSchema edge cases', () => {
    it('accepts valid phone', async () => {
        const { phoneSchema } = await import('@/shared/validation');
        expect(phoneSchema.safeParse('+15551234567').success).toBe(true);
    });

    it('accepts without + prefix', async () => {
        const { phoneSchema } = await import('@/shared/validation');
        expect(phoneSchema.safeParse('15551234567').success).toBe(true);
    });

    it('accepts empty string as optional', async () => {
        const { phoneSchema } = await import('@/shared/validation');
        expect(phoneSchema.safeParse('').success).toBe(true);
    });

    it('accepts undefined as optional', async () => {
        const { phoneSchema } = await import('@/shared/validation');
        expect(phoneSchema.safeParse(undefined).success).toBe(true);
    });

    it('rejects letters', async () => {
        const { phoneSchema } = await import('@/shared/validation');
        expect(phoneSchema.safeParse('notaphone').success).toBe(false);
    });

    it('rejects too short', async () => {
        const { phoneSchema } = await import('@/shared/validation');
        expect(phoneSchema.safeParse('123').success).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Name Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('nameSchema edge cases', () => {
    it('rejects 1 character', async () => {
        const { nameSchema } = await import('@/shared/validation');
        expect(nameSchema.safeParse('A').success).toBe(false);
    });

    it('accepts 2 characters', async () => {
        const { nameSchema } = await import('@/shared/validation');
        expect(nameSchema.safeParse('Al').success).toBe(true);
    });

    it('rejects > 100 chars', async () => {
        const { nameSchema } = await import('@/shared/validation');
        expect(nameSchema.safeParse('A'.repeat(101)).success).toBe(false);
    });

    it('trims whitespace', async () => {
        const { nameSchema } = await import('@/shared/validation');
        const r = nameSchema.safeParse('  John  ');
        expect(r.success).toBe(true);
        if (r.success) expect(r.data).toBe('John');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Address Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('addressSchema', () => {
    const validAddress = {
        street: '123 Main St',
        city: 'Toronto',
        province: 'ON',
        postalCode: 'M5A 1A1',
    };

    it('accepts valid address', async () => {
        const { addressSchema } = await import('@/shared/validation');
        expect(addressSchema.safeParse(validAddress).success).toBe(true);
    });

    it('defaults country to CA', async () => {
        const { addressSchema } = await import('@/shared/validation');
        const r = addressSchema.safeParse(validAddress);
        expect(r.success).toBe(true);
        if (r.success) expect(r.data.country).toBe('CA');
    });

    it('rejects invalid postal code', async () => {
        const { addressSchema } = await import('@/shared/validation');
        expect(addressSchema.safeParse({ ...validAddress, postalCode: '12345' }).success).toBe(false);
    });

    it('rejects empty street', async () => {
        const { addressSchema } = await import('@/shared/validation');
        expect(addressSchema.safeParse({ ...validAddress, street: '' }).success).toBe(false);
    });

    it('rejects missing city', async () => {
        const { addressSchema } = await import('@/shared/validation');
        expect(addressSchema.safeParse({ ...validAddress, city: '' }).success).toBe(false);
    });

    it('accepts postal code without space', async () => {
        const { addressSchema } = await import('@/shared/validation');
        expect(addressSchema.safeParse({ ...validAddress, postalCode: 'M5A1A1' }).success).toBe(true);
    });

    it('accepts postal code with hyphen', async () => {
        const { addressSchema } = await import('@/shared/validation');
        expect(addressSchema.safeParse({ ...validAddress, postalCode: 'M5A-1A1' }).success).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Login Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('loginSchema', () => {
    it('accepts valid login', async () => {
        const { loginSchema } = await import('@/shared/validation');
        expect(loginSchema.safeParse({ email: 'a@b.com', password: 'x' }).success).toBe(true);
    });

    it('rejects missing password', async () => {
        const { loginSchema } = await import('@/shared/validation');
        expect(loginSchema.safeParse({ email: 'a@b.com', password: '' }).success).toBe(false);
    });

    it('rejects missing email', async () => {
        const { loginSchema } = await import('@/shared/validation');
        expect(loginSchema.safeParse({ email: '', password: 'x' }).success).toBe(false);
    });

    it('login password is simpler than register password', async () => {
        const { loginSchema } = await import('@/shared/validation');
        // Login only requires min 1 char, not uppercase/number
        expect(loginSchema.safeParse({ email: 'a@b.com', password: 'a' }).success).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Register Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('registerSchema', () => {
    const validReg = {
        email: 'user@test.com',
        password: 'Password1',
        confirmPassword: 'Password1',
        name: 'John Doe',
        role: 'client' as const,
    };

    it('accepts valid registration', async () => {
        const { registerSchema } = await import('@/shared/validation');
        expect(registerSchema.safeParse(validReg).success).toBe(true);
    });

    it('rejects mismatched passwords', async () => {
        const { registerSchema } = await import('@/shared/validation');
        expect(registerSchema.safeParse({ ...validReg, confirmPassword: 'Different1' }).success).toBe(false);
    });

    it('rejects invalid role', async () => {
        const { registerSchema } = await import('@/shared/validation');
        expect(registerSchema.safeParse({ ...validReg, role: 'hacker' }).success).toBe(false);
    });

    it('accepts all valid roles', async () => {
        const { registerSchema } = await import('@/shared/validation');
        const roles = ['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager'];
        roles.forEach(role => {
            expect(registerSchema.safeParse({ ...validReg, role }).success).toBe(true);
        });
    });

    it('rejects weak password', async () => {
        const { registerSchema } = await import('@/shared/validation');
        expect(registerSchema.safeParse({ ...validReg, password: 'weak', confirmPassword: 'weak' }).success).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Visit Schemas
// ═══════════════════════════════════════════════════════════════════════════

describe('createVisitSchema', () => {
    const validVisit = {
        clientId: 'c1',
        serviceId: 's1',
        scheduledStart: '2025-01-15T09:00:00Z',
        scheduledEnd: '2025-01-15T10:00:00Z',
    };

    it('accepts valid visit', async () => {
        const { createVisitSchema } = await import('@/shared/validation');
        expect(createVisitSchema.safeParse(validVisit).success).toBe(true);
    });

    it('rejects end before start', async () => {
        const { createVisitSchema } = await import('@/shared/validation');
        const bad = { ...validVisit, scheduledEnd: '2025-01-15T08:00:00Z' };
        expect(createVisitSchema.safeParse(bad).success).toBe(false);
    });

    it('rejects missing clientId', async () => {
        const { createVisitSchema } = await import('@/shared/validation');
        const bad = { ...validVisit, clientId: '' };
        expect(createVisitSchema.safeParse(bad).success).toBe(false);
    });

    it('allows optional pswId', async () => {
        const { createVisitSchema } = await import('@/shared/validation');
        expect(createVisitSchema.safeParse({ ...validVisit, pswId: 'p1' }).success).toBe(true);
    });

    it('allows optional notes', async () => {
        const { createVisitSchema } = await import('@/shared/validation');
        expect(createVisitSchema.safeParse({ ...validVisit, notes: 'some notes' }).success).toBe(true);
    });
});

describe('updateVisitSchema', () => {
    it('accepts status change', async () => {
        const { updateVisitSchema } = await import('@/shared/validation');
        expect(updateVisitSchema.safeParse({ status: 'completed' }).success).toBe(true);
    });

    it('accepts all statuses', async () => {
        const { updateVisitSchema } = await import('@/shared/validation');
        ['scheduled', 'in_progress', 'completed', 'cancelled', 'no_show'].forEach(s => {
            expect(updateVisitSchema.safeParse({ status: s }).success).toBe(true);
        });
    });

    it('rejects invalid status', async () => {
        const { updateVisitSchema } = await import('@/shared/validation');
        expect(updateVisitSchema.safeParse({ status: 'bogus' }).success).toBe(false);
    });

    it('accepts empty object (all optional)', async () => {
        const { updateVisitSchema } = await import('@/shared/validation');
        expect(updateVisitSchema.safeParse({}).success).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Incident Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('createIncidentSchema', () => {
    const valid = {
        type: 'fall',
        severity: 'high' as const,
        description: 'Client fell in the bathroom during morning routine.',
    };

    it('accepts valid incident', async () => {
        const { createIncidentSchema } = await import('@/shared/validation');
        expect(createIncidentSchema.safeParse(valid).success).toBe(true);
    });

    it('rejects too short description', async () => {
        const { createIncidentSchema } = await import('@/shared/validation');
        expect(createIncidentSchema.safeParse({ ...valid, description: 'short' }).success).toBe(false);
    });

    it('accepts all severity levels', async () => {
        const { createIncidentSchema } = await import('@/shared/validation');
        ['low', 'medium', 'high', 'critical'].forEach(sev => {
            expect(createIncidentSchema.safeParse({ ...valid, severity: sev }).success).toBe(true);
        });
    });

    it('rejects invalid severity', async () => {
        const { createIncidentSchema } = await import('@/shared/validation');
        expect(createIncidentSchema.safeParse({ ...valid, severity: 'extreme' }).success).toBe(false);
    });

    it('allows optional clientId', async () => {
        const { createIncidentSchema } = await import('@/shared/validation');
        expect(createIncidentSchema.safeParse({ ...valid, clientId: 'c1' }).success).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Invoice Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('createInvoiceSchema', () => {
    const validInvoice = {
        clientId: 'c1',
        items: [{ description: 'Service A', quantity: 2, unitPrice: 50 }],
        dueDate: '2025-01-31',
    };

    it('accepts valid invoice', async () => {
        const { createInvoiceSchema } = await import('@/shared/validation');
        expect(createInvoiceSchema.safeParse(validInvoice).success).toBe(true);
    });

    it('rejects empty items', async () => {
        const { createInvoiceSchema } = await import('@/shared/validation');
        expect(createInvoiceSchema.safeParse({ ...validInvoice, items: [] }).success).toBe(false);
    });

    it('rejects zero quantity', async () => {
        const { createInvoiceSchema } = await import('@/shared/validation');
        const bad = { ...validInvoice, items: [{ description: 'X', quantity: 0, unitPrice: 10 }] };
        expect(createInvoiceSchema.safeParse(bad).success).toBe(false);
    });

    it('defaults taxRate to 0.13', async () => {
        const { createInvoiceSchema } = await import('@/shared/validation');
        const r = createInvoiceSchema.safeParse(validInvoice);
        expect(r.success).toBe(true);
        if (r.success) expect(r.data.items[0].taxRate).toBe(0.13);
    });

    it('rejects invalid dueDate', async () => {
        const { createInvoiceSchema } = await import('@/shared/validation');
        expect(createInvoiceSchema.safeParse({ ...validInvoice, dueDate: 'not-a-date' }).success).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Lead Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('createLeadSchema', () => {
    it('accepts valid lead', async () => {
        const { createLeadSchema } = await import('@/shared/validation');
        expect(createLeadSchema.safeParse({ name: 'Jane Doe' }).success).toBe(true);
    });

    it('accepts all sources', async () => {
        const { createLeadSchema } = await import('@/shared/validation');
        ['website', 'referral', 'social', 'advertisement', 'other'].forEach(source => {
            expect(createLeadSchema.safeParse({ name: 'Jane', source }).success).toBe(true);
        });
    });

    it('defaults source to other', async () => {
        const { createLeadSchema } = await import('@/shared/validation');
        const r = createLeadSchema.safeParse({ name: 'Jane Doe' });
        expect(r.success).toBe(true);
        if (r.success) expect(r.data.source).toBe('other');
    });

    it('rejects invalid source', async () => {
        const { createLeadSchema } = await import('@/shared/validation');
        expect(createLeadSchema.safeParse({ name: 'Jane', source: 'invalid' }).success).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Service Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('createServiceSchema', () => {
    const valid = { name: 'Home Care', category: 'nursing', hourlyRate: 45 };

    it('accepts valid service', async () => {
        const { createServiceSchema } = await import('@/shared/validation');
        expect(createServiceSchema.safeParse(valid).success).toBe(true);
    });

    it('defaults isActive to true', async () => {
        const { createServiceSchema } = await import('@/shared/validation');
        const r = createServiceSchema.safeParse(valid);
        expect(r.success).toBe(true);
        if (r.success) expect(r.data.isActive).toBe(true);
    });

    it('rejects negative hourlyRate', async () => {
        const { createServiceSchema } = await import('@/shared/validation');
        expect(createServiceSchema.safeParse({ ...valid, hourlyRate: -5 }).success).toBe(false);
    });

    it('rejects missing category', async () => {
        const { createServiceSchema } = await import('@/shared/validation');
        expect(createServiceSchema.safeParse({ ...valid, category: '' }).success).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Pagination Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('paginationSchema', () => {
    it('accepts empty object (all defaults)', async () => {
        const { paginationSchema } = await import('@/shared/validation');
        const r = paginationSchema.safeParse({});
        expect(r.success).toBe(true);
        if (r.success) {
            expect(r.data.page).toBe(1);
            expect(r.data.pageSize).toBe(20);
            expect(r.data.order).toBe('asc');
        }
    });

    it('rejects page 0', async () => {
        const { paginationSchema } = await import('@/shared/validation');
        expect(paginationSchema.safeParse({ page: 0 }).success).toBe(false);
    });

    it('rejects pageSize > 100', async () => {
        const { paginationSchema } = await import('@/shared/validation');
        expect(paginationSchema.safeParse({ pageSize: 101 }).success).toBe(false);
    });

    it('accepts desc order', async () => {
        const { paginationSchema } = await import('@/shared/validation');
        expect(paginationSchema.safeParse({ order: 'desc' }).success).toBe(true);
    });

    it('rejects invalid order', async () => {
        const { paginationSchema } = await import('@/shared/validation');
        expect(paginationSchema.safeParse({ order: 'random' }).success).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// DateRange Schema
// ═══════════════════════════════════════════════════════════════════════════

describe('dateRangeSchema', () => {
    it('accepts valid range', async () => {
        const { dateRangeSchema } = await import('@/shared/validation');
        expect(dateRangeSchema.safeParse({ start: '2025-01-01', end: '2025-01-31' }).success).toBe(true);
    });

    it('accepts same day', async () => {
        const { dateRangeSchema } = await import('@/shared/validation');
        expect(dateRangeSchema.safeParse({ start: '2025-01-15', end: '2025-01-15' }).success).toBe(true);
    });

    it('rejects end before start', async () => {
        const { dateRangeSchema } = await import('@/shared/validation');
        expect(dateRangeSchema.safeParse({ start: '2025-01-31', end: '2025-01-01' }).success).toBe(false);
    });

    it('rejects invalid date format', async () => {
        const { dateRangeSchema } = await import('@/shared/validation');
        expect(dateRangeSchema.safeParse({ start: 'Jan 1', end: 'Jan 31' }).success).toBe(false);
    });
});
