/**
 * Data Helpers — Pure utility functions for common data operations
 *
 * Includes: array utilities, object helpers, type guards, and
 * async retry logic. All functions are pure and test-friendly.
 */

// ── Array Utilities ──────────────────────────────────────────────────────

/** Group an array by a key function */
export function groupBy<T>(arr: T[], keyFn: (item: T) => string): Record<string, T[]> {
    return arr.reduce((acc, item) => {
        const key = keyFn(item);
        (acc[key] ??= []).push(item);
        return acc;
    }, {} as Record<string, T[]>);
}

/** Remove duplicates by a key function */
export function uniqueBy<T>(arr: T[], keyFn: (item: T) => string | number): T[] {
    const seen = new Set<string | number>();
    return arr.filter(item => {
        const key = keyFn(item);
        if (seen.has(key)) return false;
        seen.add(key);
        return true;
    });
}

/** Sort by a key with optional direction */
export function sortBy<T>(arr: T[], keyFn: (item: T) => string | number, desc = false): T[] {
    return [...arr].sort((a, b) => {
        const aVal = keyFn(a);
        const bVal = keyFn(b);
        const cmp = aVal < bVal ? -1 : aVal > bVal ? 1 : 0;
        return desc ? -cmp : cmp;
    });
}

/** Chunk an array into groups of N */
export function chunk<T>(arr: T[], size: number): T[][] {
    const result: T[][] = [];
    for (let i = 0; i < arr.length; i += size) {
        result.push(arr.slice(i, i + size));
    }
    return result;
}

/** Flatten a nested array one level */
export function flatten<T>(arr: T[][]): T[] {
    return arr.reduce((acc, inner) => acc.concat(inner), []);
}

/** Create a range of numbers [start, end) */
export function range(start: number, end: number, step = 1): number[] {
    const result: number[] = [];
    for (let i = start; i < end; i += step) result.push(i);
    return result;
}

// ── Object Utilities ─────────────────────────────────────────────────────

/** Pick specified keys from an object */
export function pick<T extends Record<string, any>, K extends keyof T>(obj: T, keys: K[]): Pick<T, K> {
    const result = {} as Pick<T, K>;
    keys.forEach(k => { if (k in obj) result[k] = obj[k]; });
    return result;
}

/** Omit specified keys from an object */
export function omit<T extends Record<string, any>, K extends keyof T>(obj: T, keys: K[]): Omit<T, K> {
    const result = { ...obj };
    keys.forEach(k => delete result[k]);
    return result as Omit<T, K>;
}

/** Deep equality check (simple JSON comparison) */
export function deepEqual(a: unknown, b: unknown): boolean {
    return JSON.stringify(a) === JSON.stringify(b);
}

/** Check if object is empty */
export function isEmpty(obj: Record<string, any>): boolean {
    return Object.keys(obj).length === 0;
}

// ── Type Guards ──────────────────────────────────────────────────────────

export function isString(val: unknown): val is string {
    return typeof val === 'string';
}

export function isNumber(val: unknown): val is number {
    return typeof val === 'number' && !isNaN(val);
}

export function isNonNull<T>(val: T | null | undefined): val is T {
    return val != null;
}

export function isArray<T>(val: unknown): val is T[] {
    return Array.isArray(val);
}

// ── Async Utilities ──────────────────────────────────────────────────────

/** Sleep for N milliseconds */
export function sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
}

/** Retry a function with exponential backoff */
export async function retry<T>(
    fn: () => Promise<T>,
    maxRetries = 3,
    baseDelay = 100
): Promise<T> {
    let lastError: Error | undefined;
    for (let i = 0; i <= maxRetries; i++) {
        try {
            return await fn();
        } catch (err) {
            lastError = err as Error;
            if (i < maxRetries) {
                await sleep(baseDelay * Math.pow(2, i));
            }
        }
    }
    throw lastError;
}
