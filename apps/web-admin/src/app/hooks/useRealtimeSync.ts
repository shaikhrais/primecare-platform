import { useEffect, useRef, useState } from 'react';
import { useAuth } from '../../shared/context/AuthContext';

export interface SyncMessage {
    type: 'VISIT_UPDATE' | 'SHIFT_CLAIMED' | 'TELEMETRY' | 'CHAT_MESSAGE';
    visitId?: string;
    status?: string;
    lat?: number;
    lng?: number;
    time?: string;
    [key: string]: any;
}

export function useRealtimeSync(onMessage?: (data: SyncMessage) => void) {
    const { user } = useAuth();
    const wsRef = useRef<WebSocket | null>(null);
    const onMessageRef = useRef(onMessage);
    const [isConnected, setIsConnected] = useState(false);
    const retryTimeoutRef = useRef<ReturnType<typeof setTimeout>>();
    const retryCountRef = useRef(0);

    // Keep the latest callback ref fresh
    useEffect(() => {
        onMessageRef.current = onMessage;
    }, [onMessage]);

    const connect = () => {
        if (!user) return;

        // Determine correct WebSocket URL based on current environment
        const apiBase = import.meta.env.VITE_API_URL || 'http://localhost:8787';
        // Convert http/https to ws/wss
        const wsUrl = apiBase.replace(/^http/, 'ws') + '/v1/system/realtime/connect';

        console.info(`[RealtimeSync] Connecting to ${wsUrl}...`);
        
        try {
            const ws = new WebSocket(wsUrl);

            ws.onopen = () => {
                console.info('[RealtimeSync] Connected');
                setIsConnected(true);
                retryCountRef.current = 0; // Reset backoff
            };

            ws.onmessage = (event) => {
                try {
                    const data = JSON.parse(event.data) as SyncMessage;
                    if (onMessageRef.current) onMessageRef.current(data);
                } catch (e) {
                    console.error('[RealtimeSync] Failed to parse message', e);
                }
            };

            ws.onclose = () => {
                console.warn('[RealtimeSync] Disconnected');
                setIsConnected(false);
                wsRef.current = null;
                
                // Exponential backoff reconnect
                const backoff = Math.min(1000 * Math.pow(2, retryCountRef.current), 30000);
                retryCountRef.current += 1;
                retryTimeoutRef.current = setTimeout(connect, backoff);
            };

            ws.onerror = (err) => {
                console.error('[RealtimeSync] WebSocket error', err);
            };

            wsRef.current = ws;
        } catch (e) {
            console.error('[RealtimeSync] Failed to instantiate WebSocket', e);
        }
    };

    useEffect(() => {
        connect();

        return () => {
            if (retryTimeoutRef.current) clearTimeout(retryTimeoutRef.current);
            if (wsRef.current) {
                // Ensure dirty closures don't trigger reconnect loops
                wsRef.current.onclose = null;
                wsRef.current.close();
            }
        };
        // Reconnect if the auth user fundamentally changes
    }, [user]);

    return { isConnected };
}
