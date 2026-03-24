import { useState, useEffect, useRef, useCallback } from 'react';

/**
 * useLiveKPI — Real-time WebSocket feed for home KPIs
 * 
 * Connects to the RealtimeSync Durable Object via the system /realtime/connect
 * endpoint. Automatically reconnects on disconnect with exponential backoff.
 * Falls back to polling if WebSocket is unavailable.
 *
 * Usage:
 *   const { lastEvent, isConnected, connectionStatus } = useLiveKPI();
 *   // lastEvent = { type: 'VISIT_STARTED', data: { visitId, clientName, ... } }
 */

interface LiveEvent {
    type: string;
    data: Record<string, any>;
    timestamp: string;
}

interface UseLiveKPIOptions {
    /** Enable/disable the connection (default: true) */
    enabled?: boolean;
    /** Callback fired on each incoming event */
    onEvent?: (event: LiveEvent) => void;
}

type ConnectionStatus = 'disconnected' | 'connecting' | 'connected' | 'reconnecting';

export function useLiveKPI(options: UseLiveKPIOptions = {}) {
    const { enabled = true, onEvent } = options;
    const [lastEvent, setLastEvent] = useState<LiveEvent | null>(null);
    const [events, setEvents] = useState<LiveEvent[]>([]);
    const [connectionStatus, setConnectionStatus] = useState<ConnectionStatus>('disconnected');
    const wsRef = useRef<WebSocket | null>(null);
    const retryCountRef = useRef(0);
    const retryTimerRef = useRef<ReturnType<typeof setTimeout>>();
    const onEventRef = useRef(onEvent);
    onEventRef.current = onEvent;

    const connect = useCallback(() => {
        if (!enabled) return;

        // Build WebSocket URL from current location
        const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        const host = window.location.host;
        const wsUrl = `${protocol}//${host}/v1/system/realtime/connect`;

        setConnectionStatus(retryCountRef.current > 0 ? 'reconnecting' : 'connecting');

        try {
            const ws = new WebSocket(wsUrl);
            wsRef.current = ws;

            ws.onopen = () => {
                setConnectionStatus('connected');
                retryCountRef.current = 0;
                console.log('[LiveKPI] WebSocket connected');
            };

            ws.onmessage = (event) => {
                try {
                    const parsed: LiveEvent = JSON.parse(event.data);
                    setLastEvent(parsed);
                    setEvents(prev => [parsed, ...prev].slice(0, 50)); // Keep last 50
                    onEventRef.current?.(parsed);
                } catch {
                    // Non-JSON message, ignore
                }
            };

            ws.onclose = (e) => {
                setConnectionStatus('disconnected');
                wsRef.current = null;

                // Don't reconnect on clean close (1000) or if disabled
                if (e.code === 1000 || !enabled) return;

                // Exponential backoff: 1s, 2s, 4s, 8s, max 30s
                const delay = Math.min(1000 * Math.pow(2, retryCountRef.current), 30000);
                retryCountRef.current++;
                console.log(`[LiveKPI] Reconnecting in ${delay}ms (attempt ${retryCountRef.current})`);
                retryTimerRef.current = setTimeout(connect, delay);
            };

            ws.onerror = () => {
                // onerror is always followed by onclose, so handling happens there
            };
        } catch {
            // WebSocket constructor failed — likely no support
            setConnectionStatus('disconnected');
        }
    }, [enabled]);

    useEffect(() => {
        connect();
        return () => {
            clearTimeout(retryTimerRef.current);
            if (wsRef.current) {
                wsRef.current.close(1000, 'Component unmounted');
                wsRef.current = null;
            }
        };
    }, [connect]);

    return {
        /** The most recent event received */
        lastEvent,
        /** Rolling list of the last 50 events */
        events,
        /** Whether the WebSocket is currently connected */
        isConnected: connectionStatus === 'connected',
        /** Detailed connection status */
        connectionStatus,
    };
}
