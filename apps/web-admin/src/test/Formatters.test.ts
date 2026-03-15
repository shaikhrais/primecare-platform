/**
 * Formatters Utility Tests
 *
 * Tests all 20 formatting functions: date, time, currency, duration,
 * string manipulation, and number formatting utilities.
 */
import { describe, it, expect } from 'vitest';
import {
    formatDate, formatTime, formatDateTime, formatRelativeTime,
    isToday, isPast, startOfDay, calculateAge,
    formatCurrency, formatPercent, formatCompact, formatNumber, clamp,
    formatDuration, formatHours,
    truncate, capitalize, titleCase, getInitials, slugify, generateId,
} from '@/shared/utils/formatters';

// ═══════════════════════════════════════════════════════════════════════════
// Date Formatting
// ═══════════════════════════════════════════════════════════════════════════

describe('formatDate', () => {
    it('formats medium by default', () => {
        const result = formatDate('2026-03-15');
        expect(result).toBeTruthy();
        expect(result).not.toBe('Invalid date');
    });

    it('returns Invalid date for bad input', () => {
        expect(formatDate('not-a-date')).toBe('Invalid date');
    });

    it('accepts Date object', () => {
        const result = formatDate(new Date(2026, 2, 15));
        expect(result).toBeTruthy();
    });

    it('short format returns compact date', () => {
        const result = formatDate('2026-03-15', 'short');
        expect(result).toBeTruthy();
    });

    it('long format includes month name', () => {
        const result = formatDate('2026-03-15', 'long');
        expect(result.toLowerCase()).toContain('march');
    });
});

describe('formatTime', () => {
    it('formats 12h by default', () => {
        const result = formatTime('2026-03-15T14:30:00');
        expect(result).toBeTruthy();
        expect(result).not.toBe('Invalid time');
    });

    it('returns Invalid time for bad input', () => {
        expect(formatTime('bad')).toBe('Invalid time');
    });
});

describe('formatDateTime', () => {
    it('combines date and time', () => {
        const result = formatDateTime('2026-03-15T14:30:00');
        expect(result).toBeTruthy();
        expect(result.length).toBeGreaterThan(10);
    });
});

describe('formatRelativeTime', () => {
    it('returns just now for recent', () => {
        expect(formatRelativeTime(new Date())).toBe('just now');
    });

    it('returns minutes ago', () => {
        const fiveMinAgo = new Date(Date.now() - 5 * 60_000);
        expect(formatRelativeTime(fiveMinAgo)).toBe('5 minutes ago');
    });

    it('returns hours ago', () => {
        const twoHoursAgo = new Date(Date.now() - 2 * 3_600_000);
        expect(formatRelativeTime(twoHoursAgo)).toBe('2 hours ago');
    });

    it('returns days ago', () => {
        const threeDaysAgo = new Date(Date.now() - 3 * 86_400_000);
        expect(formatRelativeTime(threeDaysAgo)).toBe('3 days ago');
    });

    it('returns Invalid date for bad input', () => {
        expect(formatRelativeTime('bad')).toBe('Invalid date');
    });

    it('handles singular (1 minute, 1 hour, 1 day)', () => {
        const oneMinAgo = new Date(Date.now() - 60_000);
        expect(formatRelativeTime(oneMinAgo)).toBe('1 minute ago');
    });
});

describe('isToday', () => {
    it('returns true for now', () => {
        expect(isToday(new Date())).toBe(true);
    });

    it('returns false for yesterday', () => {
        const yesterday = new Date(Date.now() - 86_400_000);
        expect(isToday(yesterday)).toBe(false);
    });
});

describe('isPast', () => {
    it('returns true for past date', () => {
        expect(isPast('2020-01-01')).toBe(true);
    });

    it('returns false for future date', () => {
        expect(isPast('2099-12-31')).toBe(false);
    });
});

describe('startOfDay', () => {
    it('sets time to midnight', () => {
        const result = startOfDay(new Date(2026, 2, 15, 14, 30));
        expect(result.getHours()).toBe(0);
        expect(result.getMinutes()).toBe(0);
        expect(result.getSeconds()).toBe(0);
    });
});

describe('calculateAge', () => {
    it('calculates correct age', () => {
        const dob = new Date();
        dob.setFullYear(dob.getFullYear() - 30);
        expect(calculateAge(dob)).toBe(30);
    });

    it('handles string input', () => {
        const age = calculateAge('1990-01-01');
        expect(age).toBeGreaterThan(30);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Number Formatting
// ═══════════════════════════════════════════════════════════════════════════

describe('formatCurrency', () => {
    it('formats CAD by default', () => {
        const result = formatCurrency(1234.56);
        expect(result).toContain('1,234.56');
    });

    it('handles zero', () => {
        expect(formatCurrency(0)).toContain('0.00');
    });

    it('handles negative', () => {
        const result = formatCurrency(-50);
        expect(result).toContain('50.00');
    });

    it('supports USD', () => {
        const result = formatCurrency(100, 'USD', 'en-US');
        expect(result).toContain('$');
    });
});

describe('formatPercent', () => {
    it('formats as percentage', () => {
        expect(formatPercent(0.856)).toBe('85.6%');
    });

    it('handles 0', () => {
        expect(formatPercent(0)).toBe('0.0%');
    });

    it('handles 1 (100%)', () => {
        expect(formatPercent(1)).toBe('100.0%');
    });

    it('custom decimals', () => {
        expect(formatPercent(0.1234, 2)).toBe('12.34%');
    });
});

describe('formatCompact', () => {
    it('formats thousands as K', () => {
        expect(formatCompact(1500)).toBe('1.5K');
    });

    it('formats millions as M', () => {
        expect(formatCompact(2_500_000)).toBe('2.5M');
    });

    it('small numbers unchanged', () => {
        expect(formatCompact(42)).toBe('42');
    });
});

describe('formatNumber', () => {
    it('adds thousand separators', () => {
        const result = formatNumber(1234567);
        expect(result).toContain('1,234,567');
    });

    it('respects decimal places', () => {
        const result = formatNumber(3.14159, 2);
        expect(result).toContain('3.14');
    });
});

describe('clamp', () => {
    it('clamps below min', () => expect(clamp(-5, 0, 100)).toBe(0));
    it('clamps above max', () => expect(clamp(150, 0, 100)).toBe(100));
    it('leaves in-range unchanged', () => expect(clamp(50, 0, 100)).toBe(50));
    it('handles edge: value equals min', () => expect(clamp(0, 0, 100)).toBe(0));
    it('handles edge: value equals max', () => expect(clamp(100, 0, 100)).toBe(100));
});

// ═══════════════════════════════════════════════════════════════════════════
// Duration Formatting
// ═══════════════════════════════════════════════════════════════════════════

describe('formatDuration', () => {
    it('formats milliseconds', () => expect(formatDuration(500)).toBe('500ms'));
    it('formats seconds', () => expect(formatDuration(5000)).toBe('5s'));
    it('formats minutes', () => expect(formatDuration(90_000)).toBe('1m 30s'));
    it('formats hours', () => expect(formatDuration(3_660_000)).toBe('1h 1m'));
    it('handles negative', () => expect(formatDuration(-1)).toBe('0s'));
    it('handles zero', () => expect(formatDuration(0)).toBe('0ms'));
});

describe('formatHours', () => {
    it('formats whole hours', () => expect(formatHours(8)).toBe('8h'));
    it('formats fraction hours', () => expect(formatHours(1.5)).toBe('1h 30m'));
    it('formats minutes only', () => expect(formatHours(0.5)).toBe('30m'));
    it('formats zero', () => expect(formatHours(0)).toBe('0m'));
});

// ═══════════════════════════════════════════════════════════════════════════
// String Utilities
// ═══════════════════════════════════════════════════════════════════════════

describe('truncate', () => {
    it('truncates long strings', () => {
        expect(truncate('Hello World', 8)).toBe('Hello...');
    });
    it('leaves short strings unchanged', () => {
        expect(truncate('Hi', 10)).toBe('Hi');
    });
    it('handles exact length', () => {
        expect(truncate('Hello', 5)).toBe('Hello');
    });
});

describe('capitalize', () => {
    it('capitalizes first letter', () => expect(capitalize('hello')).toBe('Hello'));
    it('handles empty string', () => expect(capitalize('')).toBe(''));
    it('handles single char', () => expect(capitalize('a')).toBe('A'));
});

describe('titleCase', () => {
    it('title cases each word', () => expect(titleCase('hello world')).toBe('Hello World'));
    it('handles single word', () => expect(titleCase('hello')).toBe('Hello'));
});

describe('getInitials', () => {
    it('extracts initials', () => expect(getInitials('John Doe')).toBe('JD'));
    it('handles single name', () => expect(getInitials('John')).toBe('J'));
    it('limits to maxChars', () => expect(getInitials('John Michael Doe', 2)).toBe('JM'));
    it('handles three names', () => expect(getInitials('John Michael Doe', 3)).toBe('JMD'));
});

describe('slugify', () => {
    it('converts to slug', () => expect(slugify('Hello World!')).toBe('hello-world'));
    it('handles special chars', () => expect(slugify('ACE Home Care™')).toBe('ace-home-care'));
    it('handles multiple spaces', () => expect(slugify('a   b   c')).toBe('a-b-c'));
    it('trims dashes', () => expect(slugify('--hello--')).toBe('hello'));
});

describe('generateId', () => {
    it('returns string', () => {
        const id = generateId();
        expect(typeof id).toBe('string');
        expect(id.length).toBeGreaterThan(0);
    });

    it('with prefix', () => {
        const id = generateId('usr');
        expect(id.startsWith('usr_')).toBe(true);
    });

    it('generates unique values', () => {
        const a = generateId();
        const b = generateId();
        expect(a).not.toBe(b);
    });
});
