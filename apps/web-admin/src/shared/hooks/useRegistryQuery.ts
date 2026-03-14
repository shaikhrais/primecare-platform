/**
 * useRegistryQuery — TanStack Query hook for registry-driven data fetching
 *
 * Replaces manual useEffect + fetch patterns with centralized caching,
 * deduplication, and automatic background refetching.
 *
 * Works alongside the existing apiClient (which handles auth, retry, token refresh).
 *
 * Usage:
 *   // Simple query
 *   const { data, isLoading, error } = useRegistryQuery<User[]>('/v1/admin/users');
 *
 *   // With custom key and options
 *   const { data } = useRegistryQuery<Shift[]>('/v1/psw/schedule', {
 *       queryKey: ['psw', 'schedule'],
 *       staleTime: 60_000,
 *       enabled: !!userId,
 *   });
 *
 *   // With transform
 *   const { data } = useRegistryQuery<DashboardStats>('/v1/admin/stats', {
 *       select: (raw) => ({ total: raw.count, active: raw.active }),
 *   });
 */
import { useQuery, UseQueryOptions, UseQueryResult } from '@tanstack/react-query';
import { apiClient, ApiError } from '@/shared/utils/apiClient';

interface RegistryQueryOptions<TData, TSelected = TData>
    extends Omit<UseQueryOptions<TData, ApiError, TSelected>, 'queryKey' | 'queryFn'> {
    /** Override the auto-generated query key */
    queryKey?: string[];
    /** Extract nested data (defaults to response.data || response) */
    unwrap?: boolean;
}

/**
 * Fetch data from an API path with TanStack Query.
 * Auto-generates queryKey from the path, uses apiClient for auth/retry.
 */
export function useRegistryQuery<TData = any, TSelected = TData>(
    path: string,
    options?: RegistryQueryOptions<TData, TSelected>
): UseQueryResult<TSelected, ApiError> {
    const { queryKey, unwrap = true, ...queryOptions } = options || {};

    // Auto-generate query key from path segments: '/v1/admin/users' → ['admin', 'users']
    const autoKey = path.replace('/v1/', '').split('/').filter(Boolean);
    const finalKey = queryKey || autoKey;

    return useQuery<TData, ApiError, TSelected>({
        queryKey: finalKey,
        queryFn: async (): Promise<TData> => {
            const response = await apiClient.get(path);

            if (!response.ok) {
                const errBody = await response.json().catch(() => ({ error: 'Request failed' }));
                throw new ApiError(response.status, errBody.error || `HTTP ${response.status}`, errBody);
            }

            const json = await response.json();
            // Support both envelope { data: [...] } and raw responses
            return unwrap && json.data !== undefined ? json.data : json;
        },
        ...queryOptions,
    });
}

export default useRegistryQuery;
