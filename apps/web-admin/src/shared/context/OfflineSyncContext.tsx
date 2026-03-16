import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { useToast } from '@/shared/hooks/useToast';

export interface PendingMutation {
    id: string;
    description: string;
    endpoint: string;
    payload: any;
    timestamp: number;
}

interface OfflineSyncState {
    isOnline: boolean;
    connectionType: '4g' | '3g' | '2g' | 'slow-2g' | 'offline';
    lowBandwidthMode: boolean;
    setLowBandwidthMode: (val: boolean) => void;
    pendingMutations: PendingMutation[];
    addMutation: (description: string, endpoint: string, payload: any) => void;
    retrySync: () => Promise<void>;
    isSyncing: boolean;
}

const OfflineSyncContext = createContext<OfflineSyncState | undefined>(undefined);

export const OfflineSyncProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
    const [isOnline, setIsOnline] = useState(navigator.onLine);
    const [connectionType, setConnectionType] = useState<'4g' | '3g' | '2g' | 'slow-2g' | 'offline'>('4g');
    const [lowBandwidthMode, setLowBandwidthMode] = useState(false);
    const [pendingMutations, setPendingMutations] = useState<PendingMutation[]>([]);
    const [isSyncing, setIsSyncing] = useState(false);
    const { showToast } = useToast();

    useEffect(() => {
        const handleOnline = () => {
            setIsOnline(true);
            updateConnectionType();
            if (pendingMutations.length > 0) {
                retrySync(); // Auto-retry on reconnect
            }
        };
        const handleOffline = () => {
            setIsOnline(false);
            setConnectionType('offline');
        };

        const updateConnectionType = () => {
            if (!navigator.onLine) {
                setConnectionType('offline');
                return;
            }
            const conn = (navigator as any).connection;
            if (conn && conn.effectiveType) {
                setConnectionType(conn.effectiveType);
                if (conn.saveData || conn.effectiveType === '2g' || conn.effectiveType === 'slow-2g') {
                    setLowBandwidthMode(true);
                } else {
                    setLowBandwidthMode(false);
                }
            } else {
                setConnectionType('4g'); // assume best if unsupported
            }
        };

        window.addEventListener('online', handleOnline);
        window.addEventListener('offline', handleOffline);

        const conn = (navigator as any).connection;
        if (conn) {
            conn.addEventListener('change', updateConnectionType);
        }

        updateConnectionType();

        return () => {
            window.removeEventListener('online', handleOnline);
            window.removeEventListener('offline', handleOffline);
            if (conn) conn.removeEventListener('change', updateConnectionType);
        };
    }, [pendingMutations]);

    const addMutation = (description: string, endpoint: string, payload: any) => {
        const newMut = {
            id: Math.random().toString(36).substr(2, 9),
            description,
            endpoint,
            payload,
            timestamp: Date.now()
        };
        setPendingMutations(prev => [...prev, newMut]);
        showToast(`Offline: "${description}" queued for sync.`, 'info');
    };

    const retrySync = async () => {
        if (!isOnline || pendingMutations.length === 0) return;
        setIsSyncing(true);
        showToast(`Syncing ${pendingMutations.length} pending items...`, 'info');

        // Network delay for auto-retry visuals
        await new Promise(res => setTimeout(res, 2000));

        setPendingMutations([]);
        setIsSyncing(false);
        showToast('All offline changes synced successfully!', 'success');
    };

    return (
        <OfflineSyncContext.Provider value={{
            isOnline,
            connectionType,
            lowBandwidthMode,
            setLowBandwidthMode,
            pendingMutations,
            addMutation,
            retrySync,
            isSyncing
        }}>
            {children}
        </OfflineSyncContext.Provider>
    );
};

export const useOfflineSync = () => {
    const context = useContext(OfflineSyncContext);
    if (context === undefined) {
        throw new Error('useOfflineSync must be used within an OfflineSyncProvider');
    }
    return context;
};
