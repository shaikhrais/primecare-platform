/**
 * useRealtimeSync — WebSocket hook for RealtimeSync Durable Object
 *
 * Connects to the backend RealtimeSync Durable Object for live
 * home updates (visit status, dispatch changes, fleet heartbeats).
 *
 * Features:
 * - Auto-reconnect with exponential backoff
 * - Connection state management
 * - Event filtering by type
 * - Heartbeat keep-alive
 *
 * Usage:
 *   const { isConnected, lastEvent, subscribe } = useRealtimeSync();
 *
 *   // Listen for specific events
 *   subscribe('visit.updated', (data) => {
 *       console.log('Visit updated:', data);
 *       queryClient.invalidateQueries({ queryKey: ['visits'] });
 *   });
 */
import { useState, useEffect, useRef, useCallback } from 'react';
import type { RealtimeEvent, RealtimeEventType } from '@/shared/api/contracts';

interface RealtimeSyncOptions {
    /** Auto-connect on mount (default: true) */
    autoConnect?: boolean;
    /** Max reconnect attempts (default: 10) */
    maxRetries?: number;
    /** Heartbeat interval in ms (default: 30000) */
    heartbeatMs?: number;
}

interface RealtimeSyncState {
    /** Current WebSocket connection status */
    isConnected: boolean;
    /** Connection state detail */
    connectionState: 'disconnected' | 'connecting' | 'connected' | 'reconnecting';
    /** Last received event */
    lastEvent: RealtimeEvent | null;
    /** Number of reconnect attempts */
    retryCount: number;
    /** Active connection count from server */
    activeConnections: number;
}

type EventHandler<T = unknown> = (event: RealtimeEvent<T>) => void;

export function useRealtimeSync(options?: RealtimeSyncOptions) {
    const { autoConnect = true, maxRetries = 10, heartbeatMs = 30_000 } = options || {};

    const [state, setState] = useState<RealtimeSyncState>({
        isConnected: false,
        connectionState: 'disconnected',
        lastEvent: null,
        retryCount: 0,
        activeConnections: 0,
    });

    const wsRef = useRef<WebSocket | null>(null);
    const retryCountRef = useRef(0);
    const retryTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
    const heartbeatTimerRef = useRef<ReturnType<typeof setInterval> | null>(null);
    const handlersRef = useRef<Map<string, Set<EventHandler>>>(new Map());

    // Build WebSocket URL from current API URL
    const getWsUrl = useCallback(() => {
        const apiUrl = import.meta.env.VITE_API_URL || '';
        const wsBase = apiUrl.replace(/^http/, 'ws');

        // Get auth info from localStorage
        const userStr = localStorage.getItem('user');
        const user = userStr ? JSON.parse(userStr) : null;

        if (!user) return null;

        const params = new URLSearchParams({
            token: user.token || 'session', // When using HttpOnly cookies, token is a placeholder
            userId: user.id || '',
            role: user.activeRole || '',
        });

        return `${wsBase}/v1/realtime/websocket?${params.toString()}`;
    }, []);

    const connect = useCallback(() => {
        const url = getWsUrl();
        if (!url) return;

        setState(s => ({ ...s, connectionState: 'connecting' }));

        try {
            const ws = new WebSocket(url);
            wsRef.current = ws;

            ws.onopen = () => {
                retryCountRef.current = 0;
                setState(s => ({
                    ...s,
                    isConnected: true,
                    connectionState: 'connected',
                    retryCount: 0,
                }));

                // Start heartbeat
                heartbeatTimerRef.current = setInterval(() => {
                    if (ws.readyState === WebSocket.OPEN) {
                        ws.send(JSON.stringify({ type: 'ping' }));
                    }
                }, heartbeatMs);
            };

            ws.onmessage = (event) => {
                try {
                    const parsed: RealtimeEvent = JSON.parse(event.data);
                    setState(s => ({ ...s, lastEvent: parsed }));

                    // Dispatch to registered handlers
                    const typeHandlers = handlersRef.current.get(parsed.type);
                    if (typeHandlers) {
                        typeHandlers.forEach(handler => {
                            try { handler(parsed); } catch { /* handler error */ }
                        });
                    }

                    // Also dispatch to wildcard handlers
                    const wildcardHandlers = handlersRef.current.get('*');
                    if (wildcardHandlers) {
                        wildcardHandlers.forEach(handler => {
                            try { handler(parsed); } catch { /* handler error */ }
                        });
                    }
                } catch {
                    // Non-JSON message (e.g., pong)
                }
            };

            ws.onclose = () => {
                setState(s => ({ ...s, isConnected: false, connectionState: 'disconnected' }));
                if (heartbeatTimerRef.current) clearInterval(heartbeatTimerRef.current);

                // Auto-reconnect with exponential backoff
                if (retryCountRef.current < maxRetries) {
                    const delay = Math.min(1000 * Math.pow(2, retryCountRef.current), 30000);
                    retryCountRef.current++;
                    setState(s => ({ ...s, connectionState: 'reconnecting', retryCount: retryCountRef.current }));
                    retryTimerRef.current = setTimeout(connect, delay);
                }
            };

            ws.onerror = () => {
                ws.close();
            };
        } catch {
            setState(s => ({ ...s, connectionState: 'disconnected' }));
        }
    }, [getWsUrl, maxRetries, heartbeatMs]);

    const disconnect = useCallback(() => {
        if (retryTimerRef.current) clearTimeout(retryTimerRef.current);
        if (heartbeatTimerRef.current) clearInterval(heartbeatTimerRef.current);
        if (wsRef.current) {
            retryCountRef.current = maxRetries; // Prevent auto-reconnect
            wsRef.current.close(1000, 'User disconnected');
            wsRef.current = null;
        }
        setState(s => ({ ...s, isConnected: false, connectionState: 'disconnected' }));
    }, [maxRetries]);

    /**
     * Subscribe to a specific event type.
     * Returns an unsubscribe function.
     *
     * @example
     *   const unsub = subscribe('visit.updated', (event) => {
     *       queryClient.invalidateQueries({ queryKey: ['visits'] });
     *   });
     *   // Later: unsub();
     */
    const subscribe = useCallback(<T = unknown>(
        eventType: RealtimeEventType | '*',
        handler: EventHandler<T>
    ): (() => void) => {
        if (!handlersRef.current.has(eventType)) {
            handlersRef.current.set(eventType, new Set());
        }
        handlersRef.current.get(eventType)!.add(handler as EventHandler);

        return () => {
            handlersRef.current.get(eventType)?.delete(handler as EventHandler);
        };
    }, []);

    // Auto-connect on mount
    useEffect(() => {
        if (autoConnect) connect();
        return () => disconnect();
    }, [autoConnect, connect, disconnect]);

    return {
        ...state,
        connect,
        disconnect,
        subscribe,
    };
}

export default useRealtimeSync;
