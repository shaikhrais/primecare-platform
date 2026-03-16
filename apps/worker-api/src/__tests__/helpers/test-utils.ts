/**
 * Test Utilities — Shared helpers for worker-api tests
 *
 * Provides:
 * - Mock Prisma client builder
 * - Validation assertion helpers
 * - Mock Hono context builder
 */
import { vi } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Mock Prisma Client
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Creates a mock Prisma client with configurable model responses.
 * Each model method (findMany, findFirst, create, etc.) is a vi.fn().
 *
 * Usage:
 *   const prisma = createMockPrisma({
 *       chartOfAccount: { findMany: vi.fn().mockResolvedValue([...]) }
 *   });
 */
export function createMockPrisma(modelOverrides: Record<string, Record<string, any>> = {}): any {
    const handler: ProxyHandler<any> = {
        get(_target, prop) {
            if (typeof prop !== 'string') return undefined;
            const overrides = modelOverrides[prop] || {};
            return new Proxy({}, {
                get(_t, method) {
                    if (typeof method !== 'string') return undefined;
                    return overrides[method] || vi.fn().mockResolvedValue(null);
                }
            });
        }
    };
    return new Proxy({}, handler);
}

// ═══════════════════════════════════════════════════════════════════════════
// Validation Helpers
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Assert a Zod schema successfully parses data.
 */
export function expectValid(schema: any, data: any): void {
    const result = schema.safeParse(data);
    if (!result.success) {
        throw new Error(`Expected valid, got errors: ${JSON.stringify(result.error.issues)}`);
    }
}

/**
 * Assert a Zod schema rejects data.
 */
export function expectInvalid(schema: any, data: any): void {
    const result = schema.safeParse(data);
    if (result.success) {
        throw new Error(`Expected invalid, but schema accepted: ${JSON.stringify(result.data)}`);
    }
}

/**
 * Assert a Zod schema rejects data with a specific issue path.
 */
export function expectInvalidAt(schema: any, data: any, path: string): void {
    const result = schema.safeParse(data);
    if (result.success) {
        throw new Error(`Expected invalid at "${path}", but schema accepted data`);
    }
    const paths = result.error.issues.map((i: any) => i.path.join('.'));
    if (!paths.includes(path)) {
        throw new Error(`Expected error at "${path}", got errors at: ${paths.join(', ')}`);
    }
}

// ═══════════════════════════════════════════════════════════════════════════
// Mock Hono Context
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Creates a minimal mock Hono context for testing middleware/handlers.
 *
 * Usage:
 *   const ctx = createMockContext({
 *       tenantId: 'tenant-1',
 *       jwtPayload: { tenantId: 'tenant-1', role: 'admin' },
 *   });
 */
export function createMockContext(store: Record<string, any> = {}): any {
    const responseData: { body?: any; status?: number } = {};
    return {
        get: (key: string) => store[key],
        set: (key: string, value: any) => { store[key] = value; },
        json: vi.fn((body: any, status: number = 200) => {
            responseData.body = body;
            responseData.status = status;
            return { body, status } as any;
        }),
        body: vi.fn((body: any, status: number = 200) => {
            responseData.body = body;
            responseData.status = status;
            return { body, status } as any;
        }),
        req: {
            json: vi.fn().mockResolvedValue({}),
            query: vi.fn().mockReturnValue({}),
            param: vi.fn().mockReturnValue({}),
        },
        _response: responseData,
    };
}
