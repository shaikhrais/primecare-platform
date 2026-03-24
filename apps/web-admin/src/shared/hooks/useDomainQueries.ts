/**
 * Domain Query Hooks — Pre-typed TanStack Query hooks for common data domains
 *
 * These hooks standardize data fetching across the app, replacing
 * direct apiClient calls with cached, deduplicated, auto-refreshing queries.
 *
 * Usage:
 *   const { data: visits, isLoading } = useVisits({ status: 'scheduled' });
 *   const { data: users } = useUsers({ page: 1, pageSize: 20 });
 *   const createVisit = useCreateVisit();
 *   createVisit.mutate({ clientId: '...', serviceId: '...' });
 */
import { useQuery, useMutation, useQueryClient, type UseQueryOptions } from '@tanstack/react-query';
import { apiClient, ApiError } from '@/shared/utils/apiClient';
import type {
    Visit, CreateVisitRequest, UpdateVisitRequest,
    User, CreateUserRequest, UpdateUserRequest,
    Incident, CreateIncidentRequest,
    Service, Invoice, Lead, CreateLeadRequest,
    AdminDashboardStats, AuditLog, PaginationParams,
} from '@/shared/api/contracts';

// ── Helper: typed fetch ───────────────────────────────────────────────────

async function typedGet<T>(path: string, params?: Record<string, string>): Promise<T> {
    const qs = params ? '?' + new URLSearchParams(params).toString() : '';
    const res = await apiClient.get(`${path}${qs}`);
    if (!res.ok) {
        const err = await res.json().catch(() => ({ error: 'Request failed' }));
        throw new ApiError(res.status, err.error || `HTTP ${res.status}`, err);
    }
    const json = await res.json();
    return json.data !== undefined ? json.data : json;
}

async function typedMutate<TInput, TResponse>(
    path: string, method: 'POST' | 'PUT' | 'PATCH' | 'DELETE', body?: TInput
): Promise<TResponse> {
    const fn = method === 'POST' ? apiClient.post
        : method === 'PUT' ? apiClient.put
        : method === 'PATCH' ? apiClient.patch
        : apiClient.delete;
    const res = method === 'DELETE'
        ? await apiClient.delete(path)
        : await fn.call(apiClient, path, body);
    if (!res.ok) {
        const err = await res.json().catch(() => ({ error: 'Request failed' }));
        throw new ApiError(res.status, err.error || `HTTP ${res.status}`, err);
    }
    const json = await res.json().catch(() => ({}));
    return json.data !== undefined ? json.data : json;
}

// ── Query Keys (centralized for invalidation) ────────────────────────────

export const QueryKeys = {
    visits: (filters?: Record<string, string>) => ['visits', filters] as const,
    visit: (id: string) => ['visits', id] as const,
    users: (filters?: Record<string, string>) => ['users', filters] as const,
    user: (id: string) => ['users', id] as const,
    incidents: (filters?: Record<string, string>) => ['incidents', filters] as const,
    services: () => ['services'] as const,
    invoices: (filters?: Record<string, string>) => ['invoices', filters] as const,
    leads: (filters?: Record<string, string>) => ['leads', filters] as const,
    dashboardStats: () => ['home', 'stats'] as const,
    auditLogs: (filters?: Record<string, string>) => ['audit-logs', filters] as const,
} as const;

// ── Visit Hooks ───────────────────────────────────────────────────────────

export function useVisits(filters?: Record<string, string>, options?: Partial<UseQueryOptions<Visit[]>>) {
    return useQuery<Visit[], ApiError>({
        queryKey: QueryKeys.visits(filters),
        queryFn: () => typedGet<Visit[]>('/v1/manager/visits', filters),
        staleTime: 30_000,
        ...(options as any),
    });
}

export function useVisit(id: string) {
    return useQuery<Visit, ApiError>({
        queryKey: QueryKeys.visit(id),
        queryFn: () => typedGet<Visit>(`/v1/manager/visits/${id}`),
        enabled: !!id,
    });
}

export function useCreateVisit() {
    const qc = useQueryClient();
    return useMutation<Visit, ApiError, CreateVisitRequest>({
        mutationFn: (body) => typedMutate('/v1/manager/visits', 'POST', body),
        onSuccess: () => qc.invalidateQueries({ queryKey: ['visits'] }),
    });
}

export function useUpdateVisit(id: string) {
    const qc = useQueryClient();
    return useMutation<Visit, ApiError, UpdateVisitRequest>({
        mutationFn: (body) => typedMutate(`/v1/manager/visits/${id}`, 'PATCH', body),
        onSuccess: () => qc.invalidateQueries({ queryKey: ['visits'] }),
    });
}

// ── User Hooks ────────────────────────────────────────────────────────────

export function useUsers(filters?: Record<string, string>, options?: Partial<UseQueryOptions<User[]>>) {
    return useQuery<User[], ApiError>({
        queryKey: QueryKeys.users(filters),
        queryFn: () => typedGet<User[]>('/v1/admin/users', filters),
        staleTime: 60_000,
        ...(options as any),
    });
}

export function useUser(id: string) {
    return useQuery<User, ApiError>({
        queryKey: QueryKeys.user(id),
        queryFn: () => typedGet<User>(`/v1/admin/users/${id}`),
        enabled: !!id,
    });
}

export function useCreateUser() {
    const qc = useQueryClient();
    return useMutation<User, ApiError, CreateUserRequest>({
        mutationFn: (body) => typedMutate('/v1/admin/users', 'POST', body),
        onSuccess: () => qc.invalidateQueries({ queryKey: ['users'] }),
    });
}

export function useUpdateUser(id: string) {
    const qc = useQueryClient();
    return useMutation<User, ApiError, UpdateUserRequest>({
        mutationFn: (body) => typedMutate(`/v1/admin/users/${id}`, 'PATCH', body),
        onSuccess: () => qc.invalidateQueries({ queryKey: ['users'] }),
    });
}

// ── Incident Hooks ────────────────────────────────────────────────────────

export function useIncidents(filters?: Record<string, string>) {
    return useQuery<Incident[], ApiError>({
        queryKey: QueryKeys.incidents(filters),
        queryFn: () => typedGet<Incident[]>('/v1/manager/incidents', filters),
        staleTime: 15_000, // Incidents refresh more frequently
    });
}

export function useCreateIncident() {
    const qc = useQueryClient();
    return useMutation<Incident, ApiError, CreateIncidentRequest>({
        mutationFn: (body) => typedMutate('/v1/manager/incidents', 'POST', body),
        onSuccess: () => qc.invalidateQueries({ queryKey: ['incidents'] }),
    });
}

// ── Service Hooks ─────────────────────────────────────────────────────────

export function useServices() {
    return useQuery<Service[], ApiError>({
        queryKey: QueryKeys.services(),
        queryFn: () => typedGet<Service[]>('/v1/admin/services'),
        staleTime: 5 * 60_000, // Services rarely change
    });
}

// ── Invoice Hooks ─────────────────────────────────────────────────────────

export function useInvoices(filters?: Record<string, string>) {
    return useQuery<Invoice[], ApiError>({
        queryKey: QueryKeys.invoices(filters),
        queryFn: () => typedGet<Invoice[]>('/v1/admin/invoices', filters),
        staleTime: 60_000,
    });
}

// ── Lead Hooks ────────────────────────────────────────────────────────────

export function useLeads(filters?: Record<string, string>) {
    return useQuery<Lead[], ApiError>({
        queryKey: QueryKeys.leads(filters),
        queryFn: () => typedGet<Lead[]>('/v1/admin/leads', filters),
        staleTime: 30_000,
    });
}

export function useCreateLead() {
    const qc = useQueryClient();
    return useMutation<Lead, ApiError, CreateLeadRequest>({
        mutationFn: (body) => typedMutate('/v1/admin/leads', 'POST', body),
        onSuccess: () => qc.invalidateQueries({ queryKey: ['leads'] }),
    });
}

// ── Home Stats ───────────────────────────────────────────────────────

export function useDashboardStats() {
    return useQuery<AdminDashboardStats, ApiError>({
        queryKey: QueryKeys.dashboardStats(),
        queryFn: () => typedGet<AdminDashboardStats>('/v1/admin/home/stats'),
        staleTime: 30_000,
        refetchOnWindowFocus: true, // Home always shows fresh data
    });
}

// ── Audit Logs ────────────────────────────────────────────────────────────

export function useAuditLogs(filters?: Record<string, string>) {
    return useQuery<AuditLog[], ApiError>({
        queryKey: QueryKeys.auditLogs(filters),
        queryFn: () => typedGet<AuditLog[]>('/v1/admin/audit-logs', filters),
        staleTime: 60_000,
    });
}
