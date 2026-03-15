/**
 * Formatters Deep Edge Case Tests
 *
 * Comprehensive tests for all 17 functions in formatters.ts:
 * Date formatting, number formatting, duration formatting, string utilities
 */
import { describe, it, expect, vi } from 'vitest';
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
    it('formats Date object', () => {
        const result = formatDate(new Date('2025-06-15'));
        expect(result).toBeDefined();
        expect(typeof result).toBe('string');
    });

    it('formats date string', () => {
        expect(formatDate('2025-01-15')).toBeDefined();
    });

    it('returns Invalid date for bad input', () => {
        expect(formatDate('not-a-date')).toBe('Invalid date');
    });

    it('supports short style', () => {
        const result = formatDate('2025-06-15', 'short');
        expect(result).toBeDefined();
    });

    it('supports long style', () => {
        const result = formatDate('2025-06-15', 'long');
        expect(result).toBeDefined();
    });

    it('defaults to medium style', () => {
        const result = formatDate('2025-06-15');
        expect(result).toBeDefined();
    });
});

describe('formatTime', () => {
    it('formats time from date string', () => {
        expect(formatTime('2025-01-15T14:30:00')).toBeDefined();
    });

    it('returns Invalid time for bad input', () => {
        expect(formatTime('not-a-date')).toBe('Invalid time');
    });

    it('supports 24h format', () => {
        const result = formatTime('2025-01-15T14:30:00', true);
        expect(result).toBeDefined();
    });

    it('accepts Date object', () => {
        expect(formatTime(new Date())).toBeDefined();
    });
});

describe('formatDateTime', () => {
    it('combines date and time', () => {
        const result = formatDateTime('2025-01-15T14:30:00');
        expect(result).toBeDefined();
        expect(result).toContain(' ');
    });
});

describe('formatRelativeTime', () => {
    it('returns just now for recent time', () => {
        expect(formatRelativeTime(new Date())).toBe('just now');
    });

    it('shows minutes ago', () => {
        const tenMinAgo = new Date(Date.now() - 10 * 60_000);
        expect(formatRelativeTime(tenMinAgo)).toContain('minute');
    });

    it('shows hours ago', () => {
        const twoHrsAgo = new Date(Date.now() - 2 * 3_600_000);
        expect(formatRelativeTime(twoHrsAgo)).toContain('hour');
    });

    it('shows days ago', () => {
        const threeDaysAgo = new Date(Date.now() - 3 * 86_400_000);
        expect(formatRelativeTime(threeDaysAgo)).toContain('day');
    });

    it('returns formatted date for >30 days', () => {
        const old = new Date(Date.now() - 60 * 86_400_000);
        expect(formatRelativeTime(old)).not.toContain('ago');
    });

    it('handles future dates', () => {
        const future = new Date(Date.now() + 2 * 3_600_000);
        expect(formatRelativeTime(future)).toContain('in ');
    });

    it('returns Invalid date for bad input', () => {
        expect(formatRelativeTime('garbage')).toBe('Invalid date');
    });

    it('singular minute', () => {
        const oneMinAgo = new Date(Date.now() - 61_000);
        expect(formatRelativeTime(oneMinAgo)).toContain('1 minute');
    });
});

describe('isToday', () => {
    it('returns true for now', () => {
        expect(isToday(new Date())).toBe(true);
    });

    it('returns false for yesterday', () => {
        const yesterday = new Date();
        yesterday.setDate(yesterday.getDate() - 1);
        expect(isToday(yesterday)).toBe(false);
    });

    it('accepts string', () => {
        expect(typeof isToday(new Date().toISOString())).toBe('boolean');
    });
});

describe('isPast', () => {
    it('returns true for past date', () => {
        expect(isPast(new Date('2020-01-01'))).toBe(true);
    });

    it('returns false for future date', () => {
        expect(isPast(new Date('2099-01-01'))).toBe(false);
    });
});

describe('startOfDay', () => {
    it('sets hours to 0', () => {
        const result = startOfDay(new Date('2025-06-15T14:30:00'));
        expect(result.getHours()).toBe(0);
        expect(result.getMinutes()).toBe(0);
        expect(result.getSeconds()).toBe(0);
    });

    it('accepts string', () => {
        const result = startOfDay('2025-06-15T14:30:00');
        expect(result.getHours()).toBe(0);
    });
});

describe('calculateAge', () => {
    it('calculates correct age', () => {
        const age = calculateAge('1990-01-01');
        expect(age).toBeGreaterThanOrEqual(35);
        expect(age).toBeLessThanOrEqual(37);
    });

    it('handles birthday today', () => {
        const today = new Date();
        const dob = new Date(today.getFullYear() - 25, today.getMonth(), today.getDate());
        expect(calculateAge(dob)).toBe(25);
    });

    it('handles future birthday this year', () => {
        const today = new Date();
        const dob = new Date(today.getFullYear() - 30, today.getMonth() + 1, today.getDate());
        expect(calculateAge(dob)).toBe(29);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Number Formatting
// ═══════════════════════════════════════════════════════════════════════════

describe('formatCurrency', () => {
    it('formats CAD by default', () => {
        const result = formatCurrency(100);
        expect(result).toContain('100');
    });

    it('formats USD', () => {
        const result = formatCurrency(50, 'USD');
        expect(result).toBeDefined();
    });

    it('handles zero', () => {
        expect(formatCurrency(0)).toBeDefined();
    });

    it('handles negative amounts', () => {
        const result = formatCurrency(-25.50);
        expect(result).toContain('25');
    });

    it('handles decimals', () => {
        const result = formatCurrency(99.99);
        expect(result).toContain('99');
    });
});

describe('formatPercent', () => {
    it('formats 0.5 as 50%', () => {
        expect(formatPercent(0.5)).toContain('50');
        expect(formatPercent(0.5)).toContain('%');
    });

    it('formats 1 as 100%', () => {
        expect(formatPercent(1)).toContain('100');
    });

    it('respects decimals', () => {
        expect(formatPercent(0.333, 2)).toBe('33.30%');
    });

    it('handles 0', () => {
        expect(formatPercent(0)).toBe('0.0%');
    });
});

describe('formatCompact', () => {
    it('formats thousands', () => {
        expect(formatCompact(1500)).toContain('K');
    });

    it('formats millions', () => {
        expect(formatCompact(2_500_000)).toContain('M');
    });

    it('keeps small numbers', () => {
        expect(formatCompact(42)).toBe('42');
    });
});

describe('formatNumber', () => {
    it('adds thousands separators', () => {
        const result = formatNumber(1234567);
        expect(result).toContain(',');
    });

    it('respects decimal places', () => {
        const result = formatNumber(3.14159, 2);
        expect(result).toContain('3.14');
    });

    it('handles zero', () => {
        expect(formatNumber(0)).toBe('0');
    });
});

describe('clamp', () => {
    it('clamps below min', () => {
        expect(clamp(-5, 0, 100)).toBe(0);
    });

    it('clamps above max', () => {
        expect(clamp(150, 0, 100)).toBe(100);
    });

    it('returns value in range', () => {
        expect(clamp(50, 0, 100)).toBe(50);
    });

    it('handles min == max', () => {
        expect(clamp(50, 10, 10)).toBe(10);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Duration Formatting
// ═══════════════════════════════════════════════════════════════════════════

describe('formatDuration', () => {
    it('formats milliseconds', () => {
        expect(formatDuration(500)).toBe('500ms');
    });

    it('formats seconds', () => {
        expect(formatDuration(5000)).toBe('5s');
    });

    it('formats minutes and seconds', () => {
        expect(formatDuration(125_000)).toBe('2m 5s');
    });

    it('formats hours and minutes', () => {
        expect(formatDuration(3_661_000)).toBe('1h 1m');
    });

    it('handles zero', () => {
        expect(formatDuration(0)).toBe('0ms');
    });

    it('handles negative', () => {
        expect(formatDuration(-100)).toBe('0s');
    });
});

describe('formatHours', () => {
    it('formats whole hours', () => {
        expect(formatHours(3)).toBe('3h');
    });

    it('formats minutes only', () => {
        expect(formatHours(0.5)).toBe('30m');
    });

    it('formats hours and minutes', () => {
        expect(formatHours(2.5)).toBe('2h 30m');
    });

    it('handles zero', () => {
        expect(formatHours(0)).toBe('0m');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// String Utilities
// ═══════════════════════════════════════════════════════════════════════════

describe('truncate', () => {
    it('truncates long strings', () => {
        expect(truncate('Hello, World! This is a long string', 15)).toBe('Hello, World...');
    });

    it('does not truncate short strings', () => {
        expect(truncate('Hi', 10)).toBe('Hi');
    });

    it('exact length not truncated', () => {
        expect(truncate('12345', 5)).toBe('12345');
    });
});

describe('capitalize', () => {
    it('capitalizes first letter', () => {
        expect(capitalize('hello')).toBe('Hello');
    });

    it('handles empty string', () => {
        expect(capitalize('')).toBe('');
    });

    it('keeps already capitalized', () => {
        expect(capitalize('Hello')).toBe('Hello');
    });

    it('handles single char', () => {
        expect(capitalize('a')).toBe('A');
    });
});

describe('titleCase', () => {
    it('capitalizes each word', () => {
        expect(titleCase('hello world')).toBe('Hello World');
    });

    it('handles single word', () => {
        expect(titleCase('hello')).toBe('Hello');
    });
});

describe('getInitials', () => {
    it('gets two-letter initials', () => {
        expect(getInitials('John Doe')).toBe('JD');
    });

    it('handles single name', () => {
        expect(getInitials('John')).toBe('J');
    });

    it('handles three names', () => {
        expect(getInitials('John Michael Doe')).toBe('JM');
    });

    it('custom max chars', () => {
        expect(getInitials('John Michael Doe', 3)).toBe('JMD');
    });
});

describe('slugify', () => {
    it('converts to slug', () => {
        expect(slugify('Hello World')).toBe('hello-world');
    });

    it('removes special chars', () => {
        expect(slugify('Hello & World!')).toBe('hello-world');
    });

    it('trims leading/trailing hyphens', () => {
        expect(slugify('  Hello  ')).toBe('hello');
    });

    it('handles multiple spaces', () => {
        expect(slugify('a   b   c')).toBe('a-b-c');
    });
});

describe('generateId', () => {
    it('generates string', () => {
        expect(typeof generateId()).toBe('string');
    });

    it('generates non-empty id', () => {
        expect(generateId().length).toBeGreaterThan(0);
    });

    it('adds prefix', () => {
        expect(generateId('user')).toMatch(/^user_/);
    });

    it('generates unique ids', () => {
        const ids = new Set(Array.from({ length: 100 }, () => generateId()));
        expect(ids.size).toBe(100);
    });
});
