/**
 * Observability — Behavioral Tests
 *
 * Tests the actual source functions from the observability layer:
 * - classifyError (errors.ts) — pure, synchronous error classification
 */
import { describe, it, expect } from 'vitest';
import { classifyError } from '../_shared/middleware/errors';

// ═══════════════════════════════════════════════════════════════════════════
// classifyError — Pure Synchronous
// ═══════════════════════════════════════════════════════════════════════════

describe('classifyError (source)', () => {
    describe('Zod validation errors', () => {
        it('classifies ZodError by name', () => {
            const err = { name: 'ZodError', issues: [{ path: ['email'], message: 'Required' }] };
            const result = classifyError(err);
            expect(result.category).toBe('validation');
            expect(result.statusCode).toBe(400);
            expect(result.publicMessage).toBe('Validation Error');
        });

        it('classifies error with issues array (no name)', () => {
            const err = { issues: [{ path: ['name'], message: 'Too short' }] };
            const result = classifyError(err);
            expect(result.category).toBe('validation');
            expect(result.statusCode).toBe(400);
        });
    });

    describe('Prisma database errors', () => {
        it('classifies P2025 as 404 (record not found)', () => {
            const err = { code: 'P2025', message: 'Record to update not found' };
            const result = classifyError(err);
            expect(result.category).toBe('database');
            expect(result.statusCode).toBe(404);
            expect(result.publicMessage).toBe('Record Not Found');
        });

        it('classifies P2002 as 500 (unique constraint)', () => {
            const err = { code: 'P2002', message: 'Unique constraint failed' };
            const result = classifyError(err);
            expect(result.category).toBe('database');
            expect(result.statusCode).toBe(500);
            expect(result.publicMessage).toBe('Internal Server Error');
        });

        it('classifies Prisma errors by name', () => {
            const err = { name: 'PrismaClientKnownRequestError', message: 'Something went wrong' };
            const result = classifyError(err);
            expect(result.category).toBe('database');
        });
    });

    describe('Auth errors', () => {
        it('classifies 401 status as auth/unauthorized', () => {
            const err = { status: 401, message: 'Invalid token' };
            const result = classifyError(err);
            expect(result.category).toBe('auth');
            expect(result.statusCode).toBe(401);
            expect(result.publicMessage).toBe('Unauthorized');
        });

        it('classifies 403 status as auth/forbidden', () => {
            const err = { status: 403, message: 'Insufficient permissions' };
            const result = classifyError(err);
            expect(result.category).toBe('auth');
            expect(result.statusCode).toBe(403);
            expect(result.publicMessage).toBe('Forbidden');
        });
    });

    describe('Unknown errors', () => {
        it('classifies generic Error as unknown/500', () => {
            const err = new Error('Something unexpected');
            const result = classifyError(err);
            expect(result.category).toBe('unknown');
            expect(result.statusCode).toBe(500);
            expect(result.publicMessage).toBe('Internal Server Error');
        });

        it('classifies null/undefined as unknown/500', () => {
            expect(classifyError(null).category).toBe('unknown');
            expect(classifyError(undefined).category).toBe('unknown');
        });

        it('classifies string errors as unknown/500', () => {
            expect(classifyError('something broke').category).toBe('unknown');
        });
    });

    describe('Priority/precedence', () => {
        it('Zod takes precedence over everything (has issues + status 401)', () => {
            const err = { name: 'ZodError', issues: [], status: 401 };
            expect(classifyError(err).category).toBe('validation');
        });

        it('Prisma takes precedence over auth (has code P2025 + status 403)', () => {
            const err = { code: 'P2025', status: 403 };
            expect(classifyError(err).category).toBe('database');
        });
    });
});
