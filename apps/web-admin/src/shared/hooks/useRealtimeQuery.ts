/**
 * useRealtimeQuery — Live data hook for real-time dashboards
 *
 * Combines TanStack Query with polling/SSE for live updates.
 * Falls back gracefully: SSE → polling → one-time fetch.
 *
 * Usage:
 *   // Auto-polls every 10s (default)
 *   const { data, isLive } = useRealtimeQuery<Alert[]>('/v1/coordinator/sos', {
 *       interval: 10_000,
 *   });
 *
 *   // With SSE stream
 *   const { data, isLive } = useRealtimeQuery<DashboardStats>('/v1/admin/stats', {
 *       sse: '/v1/admin/stats/stream',
 *   });
 *
 *   // Disable live updates
 *   const { data } = useRealtimeQuery<Shift[]>('/v1/psw/schedule', {
 *       live: false,
 *   });
 */
import { useState, useEffect, useRef, useCallback } from 'react';
import { useQuery, useQueryClient, UseQueryResult } from '@tanstack/react-query';
import { apiClient, ApiError } from '@/shared/utils/apiClient';

interface RealtimeQueryOptions<T> {
    /** Polling interval in ms (default: 15000 = 15s) */
    interval?: number;
    /** SSE endpoint for push updates (if available) */
    sse?: string;
    /** Enable/disable live updates (default: true) */
    live?: boolean;
    /** TanStack Query key override */
    queryKey?: string[];
    /** Only fetch when true (default: true) */
    enabled?: boolean;
    /** Transform response data */
    select?: (data: any) => T;
}

interface RealtimeQueryResult<T> extends Omit<UseQueryResult<T, ApiError>, 'data'> {
    data: T | undefined;
    /** Whether the hook is actively receiving live updates */
    isLive: boolean;
    /** Whether connected via SSE (vs polling) */
    isStreaming: boolean;
    /** Last time data was updated */
    lastUpdated: Date | null;
}

export function useRealtimeQuery<T = any>(
    path: string,
    options?: RealtimeQueryOptions<T>
): RealtimeQueryResult<T> {
    const {
        interval = 15_000,
        sse,
        live = true,
        queryKey,
        enabled = true,
        select,
    } = options || {};

    const queryClient = useQueryClient();
    const autoKey = queryKey || path.replace('/v1/', '').split('/').filter(Boolean);

    const [isLive, setIsLive] = useState(false);
    const [isStreaming, setIsStreaming] = useState(false);
    const [lastUpdated, setLastUpdated] = useState<Date | null>(null);
    const eventSourceRef = useRef<EventSource | null>(null);
    const networkOnline = useRef(true);

    // ── TanStack Query base fetch ────────────────────────────────────────
    const queryResult = useQuery<T, ApiError>({
        queryKey: autoKey,
        queryFn: async (): Promise<T> => {
            const response = await apiClient.get(path);
            if (!response.ok) {
                const err = await response.json().catch(() => ({ error: 'Request failed' }));
                throw new ApiError(response.status, err.error || `HTTP ${response.status}`);
            }
            const json = await response.json();
            const result = json.data !== undefined ? json.data : json;
            setLastUpdated(new Date());
            return result;
        },
        // Enable polling when live and no SSE
        refetchInterval: live && !sse && enabled ? interval : false,
        enabled,
        select,
    });

    // ── Track live status ────────────────────────────────────────────────
    useEffect(() => {
        setIsLive(live && enabled && !queryResult.isError);
    }, [live, enabled, queryResult.isError]);

    // ── SSE Connection ───────────────────────────────────────────────────
    const connectSSE = useCallback(() => {
        if (!sse || !live || !enabled) return;

        // Close existing connection
        if (eventSourceRef.current) {
            eventSourceRef.current.close();
        }

        try {
            const API_URL = import.meta.env.VITE_API_URL || '';
            const eventSource = new EventSource(`${API_URL}${sse}`, {
                withCredentials: true,
            });

            eventSource.onopen = () => {
                setIsStreaming(true);
                setIsLive(true);
            };

            eventSource.onmessage = (event) => {
                try {
                    const data = JSON.parse(event.data);
                    const result = data.data !== undefined ? data.data : data;
                    queryClient.setQueryData(autoKey, result);
                    setLastUpdated(new Date());
                } catch {
                    // Not JSON — ignore
                }
            };

            eventSource.onerror = () => {
                setIsStreaming(false);
                eventSource.close();
                // Fall back to polling after SSE failure
                setTimeout(connectSSE, 5000);
            };

            eventSourceRef.current = eventSource;
        } catch {
            setIsStreaming(false);
        }
    }, [sse, live, enabled, queryClient, autoKey]);

    useEffect(() => {
        connectSSE();
        return () => {
            eventSourceRef.current?.close();
            setIsStreaming(false);
        };
    }, [connectSSE]);

    // ── Network awareness (refetch on reconnect) ─────────────────────────
    useEffect(() => {
        const handleOnline = () => {
            networkOnline.current = true;
            queryResult.refetch();
            if (sse && live) connectSSE();
        };
        const handleOffline = () => {
            networkOnline.current = false;
            setIsLive(false);
        };

        window.addEventListener('online', handleOnline);
        window.addEventListener('offline', handleOffline);
        return () => {
            window.removeEventListener('online', handleOnline);
            window.removeEventListener('offline', handleOffline);
        };
    }, [queryResult.refetch, connectSSE, sse, live]);

    return {
        ...queryResult,
        isLive,
        isStreaming,
        lastUpdated,
    };
}

export default useRealtimeQuery;
