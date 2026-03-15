import { describe, it, expect } from 'vitest';
import { parseRoles } from '../auth/auth.service';

describe('Auth Service — parseRoles', () => {
    it('passes through array roles unchanged', () => {
        expect(parseRoles(['admin', 'coordinator'])).toEqual(['admin', 'coordinator']);
    });

    it('splits comma-separated string into array', () => {
        expect(parseRoles('admin,coordinator,finance')).toEqual(['admin', 'coordinator', 'finance']);
    });

    it('trims whitespace from split roles', () => {
        expect(parseRoles('admin , coordinator , finance')).toEqual(['admin', 'coordinator', 'finance']);
    });

    it('filters out empty strings from split', () => {
        expect(parseRoles('admin,,finance')).toEqual(['admin', 'finance']);
    });

    it('returns ["client"] for undefined', () => {
        expect(parseRoles(undefined)).toEqual(['client']);
    });

    it('returns ["client"] for null', () => {
        expect(parseRoles(null)).toEqual(['client']);
    });

    it('returns ["client"] for number', () => {
        expect(parseRoles(42)).toEqual(['client']);
    });

    it('handles single role string', () => {
        expect(parseRoles('admin')).toEqual(['admin']);
    });

    it('handles empty string', () => {
        expect(parseRoles('')).toEqual([]);
    });

    it('handles empty array', () => {
        expect(parseRoles([])).toEqual([]);
    });
});
