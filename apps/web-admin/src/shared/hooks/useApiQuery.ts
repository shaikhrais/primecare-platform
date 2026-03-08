import { useState, useCallback, useEffect, useRef } from 'react';
import { apiClient, ApiError } from '@/shared/utils/apiClient';

interface UseApiQueryOptions<T> {
    /** API endpoint path */
    path: string;
    /** Auto-fetch on mount */
    autoFetch?: boolean;
    /** Dependencies that trigger refetch */
    deps?: any[];
    /** Transform response data */
    transform?: (data: any) => T;
    /** Show error toast automatically */
    showErrorToast?: boolean;
    /** Cache key for deduplication */
    cacheKey?: string;
}

interface UseApiQueryResult<T> {
    data: T | null;
    loading: boolean;
    error: string | null;
    refetch: () => Promise<void>;
    fetched: boolean;
}

// Simple in-memory cache for deduplication
const queryCache = new Map<string, { data: any; ts: number }>();
const CACHE_TTL = 30_000; // 30 seconds

/**
 * Custom hook for API data fetching with:
 * - Automatic loading/error state management
 * - Simple response caching (30s TTL)
 * - Request deduplication
 * - Error handling with optional toast
 *
 * Usage:
 *   const { data, loading, error, refetch } = useApiQuery<User[]>({
 *     path: '/v1/admin/users',
 *     autoFetch: true,
 *   });
 *
 *   <AsyncView data={data} loading={loading} error={error}>
 *     {(users) => <UserList users={users} />}
 *   </AsyncView>
 */
export function useApiQuery<T = any>(options: UseApiQueryOptions<T>): UseApiQueryResult<T> {
    const { path, autoFetch = true, deps = [], transform, cacheKey } = options;
    const [data, setData] = useState<T | null>(null);
    const [loading, setLoading] = useState(autoFetch);
    const [error, setError] = useState<string | null>(null);
    const [fetched, setFetched] = useState(false);
    const abortRef = useRef<AbortController | null>(null);

    const refetch = useCallback(async () => {
        // Check cache first
        const key = cacheKey || path;
        const cached = queryCache.get(key);
        if (cached && Date.now() - cached.ts < CACHE_TTL) {
            setData(transform ? transform(cached.data) : cached.data);
            setLoading(false);
            setFetched(true);
            return;
        }

        // Abort previous request
        if (abortRef.current) abortRef.current.abort();
        abortRef.current = new AbortController();

        setLoading(true);
        setError(null);

        try {
            const response = await apiClient.get(path, { signal: abortRef.current.signal });

            if (!response.ok) {
                const errBody = await response.json().catch(() => ({ error: 'Request failed' }));
                throw new ApiError(response.status, errBody.error || `HTTP ${response.status}`);
            }

            const json = await response.json();
            const result = json.data !== undefined ? json.data : json; // Support envelope + raw
            const finalData = transform ? transform(result) : result;

            setData(finalData);
            queryCache.set(key, { data: result, ts: Date.now() });
        } catch (err: any) {
            if (err.name === 'AbortError') return;
            const message = err instanceof ApiError ? err.message : 'An unexpected error occurred';
            setError(message);
        } finally {
            setLoading(false);
            setFetched(true);
        }
    }, [path, cacheKey, transform, ...deps]);

    useEffect(() => {
        if (autoFetch) refetch();
        return () => { abortRef.current?.abort(); };
    }, [refetch, autoFetch]);

    return { data, loading, error, refetch, fetched };
}

/**
 * Invalidate cache for a specific key or path.
 * Call after mutations to force refetch.
 */
export function invalidateQuery(keyOrPath: string) {
    queryCache.delete(keyOrPath);
}

/**
 * Clear entire query cache.
 */
export function clearQueryCache() {
    queryCache.clear();
}
