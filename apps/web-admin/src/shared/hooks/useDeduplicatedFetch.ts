import { useRef, useCallback } from 'react';

/**
 * useDeduplicatedFetch — Prevents duplicate in-flight API requests
 *
 * Problem: TanStack Query covers server state, but manual fetch() calls
 * (e.g., form submissions, mutations, imperative fetches) can fire
 * duplicate requests when users double-click or components re-render.
 *
 * Solution: This hook deduplicates based on a composite key of
 * (url + method + body hash). If an identical request is already
 * in-flight, the second caller receives the same Promise.
 *
 * Usage:
 *   const { dedupFetch } = useDeduplicatedFetch();
 *   const data = await dedupFetch('/api/v1/visits', { method: 'POST', body: JSON.stringify(payload) });
 */

interface InFlightEntry {
    promise: Promise<Response>;
    timestamp: number;
}

export function useDeduplicatedFetch() {
    const inFlight = useRef<Map<string, InFlightEntry>>(new Map());

    const generateKey = useCallback((url: string, init?: RequestInit): string => {
        const method = init?.method?.toUpperCase() || 'GET';
        const body = typeof init?.body === 'string' ? init.body : '';
        // Simple hash for dedup key
        let hash = 0;
        const str = `${method}:${url}:${body}`;
        for (let i = 0; i < str.length; i++) {
            const char = str.charCodeAt(i);
            hash = ((hash << 5) - hash) + char;
            hash |= 0; // Convert to 32bit int
        }
        return `${method}:${url}:${hash}`;
    }, []);

    const dedupFetch = useCallback(async (url: string, init?: RequestInit): Promise<Response> => {
        const key = generateKey(url, init);
        const existing = inFlight.current.get(key);

        // If an identical request is in-flight and less than 10s old, reuse it
        if (existing && (Date.now() - existing.timestamp) < 10000) {
            console.debug(`[Dedup] Reusing in-flight request: ${key.substring(0, 60)}`);
            return existing.promise;
        }

        // Create the actual fetch
        const promise = fetch(url, init).finally(() => {
            // Clean up after completion
            inFlight.current.delete(key);
        });

        inFlight.current.set(key, { promise, timestamp: Date.now() });
        return promise;
    }, [generateKey]);

    // Manually clear all pending dedup entries (e.g., on logout)
    const clearAll = useCallback(() => {
        inFlight.current.clear();
    }, []);

    return { dedupFetch, clearAll };
}

/**
 * useThrottledAction — Prevents rapid-fire action invocations
 *
 * Useful for: form submissions, button clicks, API mutations
 * where you want at most one invocation per interval.
 */
export function useThrottledAction<T extends (...args: any[]) => any>(
    action: T,
    intervalMs: number = 1000,
): T {
    const lastCall = useRef(0);
    const pendingResult = useRef<ReturnType<T> | null>(null);

    return useCallback((...args: Parameters<T>) => {
        const now = Date.now();
        if (now - lastCall.current < intervalMs) {
            console.debug(`[Throttle] Blocked duplicate call within ${intervalMs}ms`);
            return pendingResult.current;
        }
        lastCall.current = now;
        pendingResult.current = action(...args);
        return pendingResult.current;
    }, [action, intervalMs]) as T;
}
