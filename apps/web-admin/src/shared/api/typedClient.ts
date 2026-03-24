/**
 * Typed API Client — Type-safe wrapper over apiClient
 *
 * Provides compile-time checking for API paths, request bodies,
 * and response types. Uses the contracts defined in contracts.ts.
 *
 * Usage:
 *   const { data } = useTypedQuery<Visit[]>('/v1/manager/visits');
 *   const mutation = useTypedMutation<CreateVisitRequest, Visit>('/v1/manager/visits');
 *   mutation.mutate({ clientId: '...', serviceId: '...', scheduledStart: '...' });
 */
import { useApiQuery, invalidateQuery } from '@/shared/hooks/useApiQuery';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import type { ApiEnvelope, PaginationParams } from './contracts';

// Re-export all types for convenience
export type * from './contracts';

// ── Typed Query Hook ──────────────────────────────────────────────────────

interface TypedQueryOptions<T> {
    /** Auto-fetch on mount (default: true) */
    autoFetch?: boolean;
    /** Dependencies that trigger refetch */
    deps?: any[];
    /** Transform response before returning */
    transform?: (data: any) => T;
    /** Cache key override */
    cacheKey?: string;
    /** Pagination params */
    pagination?: PaginationParams;
}

/**
 * Type-safe version of useApiQuery.
 *
 * @example
 *   const { data, loading } = useTypedQuery<Visit[]>('/v1/manager/visits');
 *   const { data: stats } = useTypedQuery<AdminDashboardStats>('/v1/admin/home/stats');
 */
export function useTypedQuery<TResponse>(
    path: string,
    options?: TypedQueryOptions<TResponse>
) {
    const { pagination, ...queryOpts } = options || {};

    // Append pagination params to path if provided
    let finalPath = path;
    if (pagination) {
        const params = new URLSearchParams();
        if (pagination.page) params.set('page', String(pagination.page));
        if (pagination.pageSize) params.set('pageSize', String(pagination.pageSize));
        if (pagination.sort) params.set('sort', pagination.sort);
        if (pagination.order) params.set('order', pagination.order);
        if (pagination.search) params.set('search', pagination.search);
        const qs = params.toString();
        if (qs) finalPath = `${path}${path.includes('?') ? '&' : '?'}${qs}`;
    }

    return useApiQuery<TResponse>({
        path: finalPath,
        ...queryOpts,
    });
}

// ── Typed Mutation Hook ───────────────────────────────────────────────────

interface TypedMutationOptions<TInput, TResponse> {
    /** HTTP method (default: POST) */
    method?: 'POST' | 'PUT' | 'PATCH' | 'DELETE';
    /** Query keys to invalidate on success */
    invalidateKeys?: string[][];
    /** Callback on success */
    onSuccess?: (data: TResponse) => void;
    /** Callback on error */
    onError?: (error: any) => void;
}

/**
 * Type-safe version of useApiMutation.
 *
 * @example
 *   const createVisit = useTypedMutation<CreateVisitRequest, Visit>('/v1/manager/visits');
 *   createVisit.mutate({ clientId: '...', serviceId: '...', scheduledStart: '...' });
 */
export function useTypedMutation<TInput = void, TResponse = any>(
    path: string,
    options?: TypedMutationOptions<TInput, TResponse>
) {
    return useApiMutation<TInput, TResponse>(path, options);
}

// ── Pre-Built Typed API Methods ───────────────────────────────────────────

import { apiClient } from '@/shared/utils/apiClient';

/**
 * Typed API client with pre-defined methods for common endpoints.
 * Returns typed responses automatically.
 *
 * @example
 *   const users = await typedApi.admin.getUsers();
 *   const visit = await typedApi.manager.createVisit({ ... });
 */
export const typedApi = {
    // ── Auth ────────────────────────────
    auth: {
        async login(body: import('./contracts').LoginRequest): Promise<import('./contracts').LoginResponse> {
            const res = await apiClient.post('/v1/auth/login', body);
            const json = await res.json();
            return json.data ?? json;
        },
        async register(body: import('./contracts').RegisterRequest): Promise<import('./contracts').RegisterResponse> {
            const res = await apiClient.post('/v1/auth/register', body);
            const json = await res.json();
            return json.data ?? json;
        },
        async forgotPassword(body: import('./contracts').ForgotPasswordRequest): Promise<{ message: string }> {
            const res = await apiClient.post('/v1/auth/forgot-password', body);
            const json = await res.json();
            return json.data ?? json;
        },
        async businessOnboard(body: import('./contracts').BusinessOnboardRequest): Promise<import('./contracts').RegisterResponse> {
            const res = await apiClient.post('/v1/auth/business-onboard', body);
            const json = await res.json();
            return json.data ?? json;
        },
    },

    // ── Admin ───────────────────────────
    admin: {
        async getUsers(params?: import('./contracts').PaginationParams): Promise<import('./contracts').User[]> {
            const qs = params ? '?' + new URLSearchParams(params as any).toString() : '';
            const res = await apiClient.get(`/v1/admin/users${qs}`);
            const json = await res.json();
            return json.data ?? json;
        },
        async getUser(id: string): Promise<import('./contracts').User> {
            const res = await apiClient.get(`/v1/admin/users/${id}`);
            const json = await res.json();
            return json.data ?? json;
        },
        async createUser(body: import('./contracts').CreateUserRequest): Promise<import('./contracts').User> {
            const res = await apiClient.post('/v1/admin/users', body);
            const json = await res.json();
            return json.data ?? json;
        },
        async updateUser(id: string, body: import('./contracts').UpdateUserRequest): Promise<import('./contracts').User> {
            const res = await apiClient.patch(`/v1/admin/users/${id}`, body);
            const json = await res.json();
            return json.data ?? json;
        },
        async getDashboardStats(): Promise<import('./contracts').AdminDashboardStats> {
            const res = await apiClient.get('/v1/admin/home/stats');
            const json = await res.json();
            return json.data ?? json;
        },
    },

    // ── Manager ─────────────────────────
    manager: {
        async getVisits(params?: import('./contracts').PaginationParams): Promise<import('./contracts').Visit[]> {
            const qs = params ? '?' + new URLSearchParams(params as any).toString() : '';
            const res = await apiClient.get(`/v1/manager/visits${qs}`);
            const json = await res.json();
            return json.data ?? json;
        },
        async createVisit(body: import('./contracts').CreateVisitRequest): Promise<import('./contracts').Visit> {
            const res = await apiClient.post('/v1/manager/visits', body);
            const json = await res.json();
            return json.data ?? json;
        },
        async updateVisit(id: string, body: import('./contracts').UpdateVisitRequest): Promise<import('./contracts').Visit> {
            const res = await apiClient.patch(`/v1/manager/visits/${id}`, body);
            const json = await res.json();
            return json.data ?? json;
        },
        async getIncidents(): Promise<import('./contracts').Incident[]> {
            const res = await apiClient.get('/v1/manager/incidents');
            const json = await res.json();
            return json.data ?? json;
        },
        async createIncident(body: import('./contracts').CreateIncidentRequest): Promise<import('./contracts').Incident> {
            const res = await apiClient.post('/v1/manager/incidents', body);
            const json = await res.json();
            return json.data ?? json;
        },
    },

    // ── Helpers ──────────────────────────
    /** Invalidate a query cache entry by path */
    invalidate: invalidateQuery,
};

export default typedApi;
