/**
 * Data Helpers — Comprehensive Tests
 *
 * Tests every function in dataHelpers.ts: array utilities, object helpers,
 * type guards, async utilities with edge cases.
 */
import { describe, it, expect, vi } from 'vitest';
import {
    groupBy, uniqueBy, sortBy, chunk, flatten, range,
    pick, omit, deepEqual, isEmpty,
    isString, isNumber, isNonNull, isArray,
    sleep, retry,
} from '@/shared/utils/dataHelpers';

// ═══════════════════════════════════════════════════════════════════════════
// Array Utilities
// ═══════════════════════════════════════════════════════════════════════════

describe('groupBy', () => {
    it('groups by key function', () => {
        const data = [{ type: 'a', v: 1 }, { type: 'b', v: 2 }, { type: 'a', v: 3 }];
        const result = groupBy(data, d => d.type);
        expect(result['a']).toHaveLength(2);
        expect(result['b']).toHaveLength(1);
    });

    it('handles empty array', () => {
        expect(groupBy([], () => 'x')).toEqual({});
    });

    it('single group', () => {
        const result = groupBy([1, 2, 3], () => 'all');
        expect(result['all']).toEqual([1, 2, 3]);
    });

    it('each item in unique group', () => {
        const result = groupBy(['a', 'b', 'c'], x => x);
        expect(Object.keys(result)).toHaveLength(3);
    });
});

describe('uniqueBy', () => {
    it('removes duplicates by key', () => {
        const data = [{ id: 1, name: 'a' }, { id: 2, name: 'b' }, { id: 1, name: 'c' }];
        expect(uniqueBy(data, d => d.id)).toHaveLength(2);
    });

    it('keeps first occurrence', () => {
        const data = [{ id: 1, name: 'first' }, { id: 1, name: 'second' }];
        const result = uniqueBy(data, d => d.id);
        expect(result[0].name).toBe('first');
    });

    it('handles empty array', () => {
        expect(uniqueBy([], () => '')).toEqual([]);
    });

    it('all unique returns same length', () => {
        const data = [{ id: 1 }, { id: 2 }, { id: 3 }];
        expect(uniqueBy(data, d => d.id)).toHaveLength(3);
    });
});

describe('sortBy', () => {
    it('sorts ascending by default', () => {
        const data = [{ n: 3 }, { n: 1 }, { n: 2 }];
        expect(sortBy(data, d => d.n).map(d => d.n)).toEqual([1, 2, 3]);
    });

    it('sorts descending', () => {
        const data = [{ n: 3 }, { n: 1 }, { n: 2 }];
        expect(sortBy(data, d => d.n, true).map(d => d.n)).toEqual([3, 2, 1]);
    });

    it('sorts strings', () => {
        const data = [{ s: 'c' }, { s: 'a' }, { s: 'b' }];
        expect(sortBy(data, d => d.s).map(d => d.s)).toEqual(['a', 'b', 'c']);
    });

    it('does not mutate original', () => {
        const data = [{ n: 2 }, { n: 1 }];
        sortBy(data, d => d.n);
        expect(data[0].n).toBe(2);
    });

    it('handles empty array', () => {
        expect(sortBy([], () => 0)).toEqual([]);
    });
});

describe('chunk', () => {
    it('chunks evenly', () => {
        expect(chunk([1, 2, 3, 4], 2)).toEqual([[1, 2], [3, 4]]);
    });

    it('last chunk may be smaller', () => {
        expect(chunk([1, 2, 3], 2)).toEqual([[1, 2], [3]]);
    });

    it('single element chunks', () => {
        expect(chunk([1, 2, 3], 1)).toEqual([[1], [2], [3]]);
    });

    it('chunk size larger than array', () => {
        expect(chunk([1, 2], 5)).toEqual([[1, 2]]);
    });

    it('empty array', () => {
        expect(chunk([], 3)).toEqual([]);
    });
});

describe('flatten', () => {
    it('flattens one level', () => {
        expect(flatten([[1, 2], [3, 4]])).toEqual([1, 2, 3, 4]);
    });

    it('handles empty inner arrays', () => {
        expect(flatten([[], [1], []])).toEqual([1]);
    });

    it('handles empty outer', () => {
        expect(flatten([])).toEqual([]);
    });
});

describe('range', () => {
    it('creates basic range', () => {
        expect(range(0, 5)).toEqual([0, 1, 2, 3, 4]);
    });

    it('custom step', () => {
        expect(range(0, 10, 3)).toEqual([0, 3, 6, 9]);
    });

    it('start = end returns empty', () => {
        expect(range(5, 5)).toEqual([]);
    });

    it('negative range with step', () => {
        expect(range(-3, 0)).toEqual([-3, -2, -1]);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Object Utilities
// ═══════════════════════════════════════════════════════════════════════════

describe('pick', () => {
    it('picks specified keys', () => {
        expect(pick({ a: 1, b: 2, c: 3 }, ['a', 'c'])).toEqual({ a: 1, c: 3 });
    });

    it('ignores missing keys', () => {
        expect(pick({ a: 1 }, ['a', 'b' as any])).toEqual({ a: 1 });
    });

    it('returns empty for empty keys', () => {
        expect(pick({ a: 1 }, [])).toEqual({});
    });
});

describe('omit', () => {
    it('omits specified keys', () => {
        expect(omit({ a: 1, b: 2, c: 3 }, ['b'])).toEqual({ a: 1, c: 3 });
    });

    it('returns same for empty keys', () => {
        expect(omit({ a: 1 }, [])).toEqual({ a: 1 });
    });

    it('does not mutate original', () => {
        const obj = { a: 1, b: 2 };
        omit(obj, ['b']);
        expect(obj.b).toBe(2);
    });
});

describe('deepEqual', () => {
    it('equal objects', () => {
        expect(deepEqual({ a: 1 }, { a: 1 })).toBe(true);
    });

    it('unequal objects', () => {
        expect(deepEqual({ a: 1 }, { a: 2 })).toBe(false);
    });

    it('nested objects', () => {
        expect(deepEqual({ a: { b: 1 } }, { a: { b: 1 } })).toBe(true);
    });

    it('arrays', () => {
        expect(deepEqual([1, 2], [1, 2])).toBe(true);
    });

    it('different types', () => {
        expect(deepEqual(1, '1')).toBe(false);
    });

    it('null vs undefined', () => {
        expect(deepEqual(null, undefined)).toBe(false);
    });
});

describe('isEmpty', () => {
    it('empty object', () => {
        expect(isEmpty({})).toBe(true);
    });

    it('non-empty object', () => {
        expect(isEmpty({ a: 1 })).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Type Guards
// ═══════════════════════════════════════════════════════════════════════════

describe('isString', () => {
    it('true for string', () => { expect(isString('hello')).toBe(true); });
    it('false for number', () => { expect(isString(42)).toBe(false); });
    it('false for null', () => { expect(isString(null)).toBe(false); });
    it('true for empty string', () => { expect(isString('')).toBe(true); });
});

describe('isNumber', () => {
    it('true for number', () => { expect(isNumber(42)).toBe(true); });
    it('false for NaN', () => { expect(isNumber(NaN)).toBe(false); });
    it('false for string', () => { expect(isNumber('42')).toBe(false); });
    it('true for 0', () => { expect(isNumber(0)).toBe(true); });
    it('true for negative', () => { expect(isNumber(-1)).toBe(true); });
    it('true for Infinity', () => { expect(isNumber(Infinity)).toBe(true); });
});

describe('isNonNull', () => {
    it('false for null', () => { expect(isNonNull(null)).toBe(false); });
    it('false for undefined', () => { expect(isNonNull(undefined)).toBe(false); });
    it('true for 0', () => { expect(isNonNull(0)).toBe(true); });
    it('true for empty string', () => { expect(isNonNull('')).toBe(true); });
    it('true for false', () => { expect(isNonNull(false)).toBe(true); });
});

describe('isArray', () => {
    it('true for array', () => { expect(isArray([1, 2])).toBe(true); });
    it('true for empty array', () => { expect(isArray([])).toBe(true); });
    it('false for object', () => { expect(isArray({})).toBe(false); });
    it('false for string', () => { expect(isArray('hello')).toBe(false); });
});

// ═══════════════════════════════════════════════════════════════════════════
// Async Utilities
// ═══════════════════════════════════════════════════════════════════════════

describe('sleep', () => {
    it('returns a promise', () => {
        expect(sleep(0)).toBeInstanceOf(Promise);
    });

    it('resolves', async () => {
        await expect(sleep(1)).resolves.toBeUndefined();
    });
});

describe('retry', () => {
    it('returns on first success', async () => {
        const fn = vi.fn().mockResolvedValue('ok');
        const result = await retry(fn, 3, 1);
        expect(result).toBe('ok');
        expect(fn).toHaveBeenCalledTimes(1);
    });

    it('retries on failure then succeeds', async () => {
        const fn = vi.fn()
            .mockRejectedValueOnce(new Error('fail'))
            .mockResolvedValue('ok');
        const result = await retry(fn, 3, 1);
        expect(result).toBe('ok');
        expect(fn).toHaveBeenCalledTimes(2);
    });

    it('throws after max retries', async () => {
        const fn = vi.fn().mockRejectedValue(new Error('always fail'));
        await expect(retry(fn, 2, 1)).rejects.toThrow('always fail');
        expect(fn).toHaveBeenCalledTimes(3); // initial + 2 retries
    });

    it('zero retries means one attempt', async () => {
        const fn = vi.fn().mockRejectedValue(new Error('fail'));
        await expect(retry(fn, 0, 1)).rejects.toThrow('fail');
        expect(fn).toHaveBeenCalledTimes(1);
    });
});
