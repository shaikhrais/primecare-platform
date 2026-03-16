import React, { createContext, useContext, useState, useEffect, useCallback, ReactNode } from 'react';
import { useToast } from '@/shared/hooks/useToast';
import { apiClient } from '@/shared/utils/apiClient';

// ── IndexedDB Helper ──────────────────────────────────────────────────────

const DB_NAME = 'primecare-offline';
const STORE_NAME = 'pending-mutations';

function openDB(): Promise<IDBDatabase> {
    return new Promise((resolve, reject) => {
        const request = indexedDB.open(DB_NAME, 1);
        request.onupgradeneeded = () => {
            const db = request.result;
            if (!db.objectStoreNames.contains(STORE_NAME)) {
                db.createObjectStore(STORE_NAME, { keyPath: 'id' });
            }
        };
        request.onsuccess = () => resolve(request.result);
        request.onerror = () => reject(request.error);
    });
}

async function dbGetAll(): Promise<PendingMutation[]> {
    const db = await openDB();
    return new Promise((resolve, reject) => {
        const tx = db.transaction(STORE_NAME, 'readonly');
        const store = tx.objectStore(STORE_NAME);
        const req = store.getAll();
        req.onsuccess = () => resolve(req.result);
        req.onerror = () => reject(req.error);
    });
}

async function dbAdd(mutation: PendingMutation): Promise<void> {
    const db = await openDB();
    return new Promise((resolve, reject) => {
        const tx = db.transaction(STORE_NAME, 'readwrite');
        const store = tx.objectStore(STORE_NAME);
        store.put(mutation);
        tx.oncomplete = () => resolve();
        tx.onerror = () => reject(tx.error);
    });
}

async function dbDelete(id: string): Promise<void> {
    const db = await openDB();
    return new Promise((resolve, reject) => {
        const tx = db.transaction(STORE_NAME, 'readwrite');
        const store = tx.objectStore(STORE_NAME);
        store.delete(id);
        tx.oncomplete = () => resolve();
        tx.onerror = () => reject(tx.error);
    });
}

async function dbClear(): Promise<void> {
    const db = await openDB();
    return new Promise((resolve, reject) => {
        const tx = db.transaction(STORE_NAME, 'readwrite');
        const store = tx.objectStore(STORE_NAME);
        store.clear();
        tx.oncomplete = () => resolve();
        tx.onerror = () => reject(tx.error);
    });
}

// ── Types ─────────────────────────────────────────────────────────────────

export interface PendingMutation {
    id: string;
    description: string;
    endpoint: string;
    method: 'POST' | 'PUT' | 'PATCH' | 'DELETE';
    payload: any;
    timestamp: number;
    retryCount: number;
    status: 'pending' | 'syncing' | 'failed';
    error?: string;
}

interface OfflineSyncState {
    isOnline: boolean;
    connectionType: '4g' | '3g' | '2g' | 'slow-2g' | 'offline';
    lowBandwidthMode: boolean;
    setLowBandwidthMode: (val: boolean) => void;
    pendingMutations: PendingMutation[];
    addMutation: (description: string, endpoint: string, method: PendingMutation['method'], payload: any) => void;
    retrySync: () => Promise<void>;
    clearFailed: () => Promise<void>;
    isSyncing: boolean;
    syncProgress: { current: number; total: number };
}

const OfflineSyncContext = createContext<OfflineSyncState | undefined>(undefined);

// ── Provider ──────────────────────────────────────────────────────────────

export const OfflineSyncProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
    const [isOnline, setIsOnline] = useState(navigator.onLine);
    const [connectionType, setConnectionType] = useState<'4g' | '3g' | '2g' | 'slow-2g' | 'offline'>('4g');
    const [lowBandwidthMode, setLowBandwidthMode] = useState(false);
    const [pendingMutations, setPendingMutations] = useState<PendingMutation[]>([]);
    const [isSyncing, setIsSyncing] = useState(false);
    const [syncProgress, setSyncProgress] = useState({ current: 0, total: 0 });
    const { showToast } = useToast();

    // Load persisted mutations from IndexedDB on mount
    useEffect(() => {
        dbGetAll().then(setPendingMutations).catch(() => {});
    }, []);

    // Network detection
    useEffect(() => {
        const updateConnectionType = () => {
            if (!navigator.onLine) { setConnectionType('offline'); return; }
            const conn = (navigator as any).connection;
            if (conn?.effectiveType) {
                setConnectionType(conn.effectiveType);
                setLowBandwidthMode(conn.saveData || conn.effectiveType === '2g' || conn.effectiveType === 'slow-2g');
            } else {
                setConnectionType('4g');
            }
        };

        const handleOnline = () => { setIsOnline(true); updateConnectionType(); };
        const handleOffline = () => { setIsOnline(false); setConnectionType('offline'); };

        window.addEventListener('online', handleOnline);
        window.addEventListener('offline', handleOffline);
        const conn = (navigator as any).connection;
        if (conn) conn.addEventListener('change', updateConnectionType);
        updateConnectionType();

        return () => {
            window.removeEventListener('online', handleOnline);
            window.removeEventListener('offline', handleOffline);
            if (conn) conn.removeEventListener('change', updateConnectionType);
        };
    }, []);

    // Auto-sync when coming back online
    useEffect(() => {
        if (isOnline && pendingMutations.length > 0 && !isSyncing) {
            retrySync();
        }
    }, [isOnline]);

    // Queue a mutation for offline replay
    const addMutation = useCallback(async (
        description: string, endpoint: string, method: PendingMutation['method'], payload: any
    ) => {
        const mutation: PendingMutation = {
            id: `${Date.now()}-${Math.random().toString(36).slice(2, 9)}`,
            description, endpoint, method, payload,
            timestamp: Date.now(),
            retryCount: 0,
            status: 'pending',
        };
        await dbAdd(mutation);
        setPendingMutations(prev => [...prev, mutation]);
        showToast(`📡 Offline: "${description}" queued for sync`, 'info');
    }, [showToast]);

    // Replay all pending mutations sequentially
    const retrySync = useCallback(async () => {
        if (!navigator.onLine || isSyncing) return;
        const pending = await dbGetAll();
        if (pending.length === 0) return;

        setIsSyncing(true);
        setSyncProgress({ current: 0, total: pending.length });
        showToast(`🔄 Syncing ${pending.length} offline changes...`, 'info');

        let successCount = 0;
        let failCount = 0;

        for (let i = 0; i < pending.length; i++) {
            const mut = pending[i];
            setSyncProgress({ current: i + 1, total: pending.length });

            try {
                const fetchMethod = mut.method.toLowerCase() as 'post' | 'put' | 'patch' | 'delete';
                if (fetchMethod === 'delete') {
                    await apiClient.delete(mut.endpoint);
                } else {
                    await (apiClient as any)[fetchMethod](mut.endpoint, mut.payload);
                }
                await dbDelete(mut.id);
                successCount++;
            } catch (err: any) {
                failCount++;
                // Update retry count in IndexedDB
                const updated = { ...mut, retryCount: mut.retryCount + 1, status: 'failed' as const, error: err?.message };
                if (updated.retryCount >= 5) {
                    // Give up after 5 retries — move to dead letter
                    await dbDelete(mut.id);
                    console.error(`[OfflineSync] Permanently failed: ${mut.description}`, err);
                } else {
                    await dbAdd(updated);
                }
            }
        }

        const remaining = await dbGetAll();
        setPendingMutations(remaining);
        setIsSyncing(false);
        setSyncProgress({ current: 0, total: 0 });

        if (failCount === 0) {
            showToast(`✅ All ${successCount} changes synced successfully!`, 'success');
        } else {
            showToast(`⚠️ Synced ${successCount}/${pending.length}. ${failCount} failed — will retry.`, 'warning');
        }
    }, [isSyncing, showToast]);

    // Clear all failed mutations
    const clearFailed = useCallback(async () => {
        await dbClear();
        setPendingMutations([]);
        showToast('Cleared all pending offline changes', 'info');
    }, [showToast]);

    return (
        <OfflineSyncContext.Provider value={{
            isOnline, connectionType, lowBandwidthMode, setLowBandwidthMode,
            pendingMutations, addMutation, retrySync, clearFailed,
            isSyncing, syncProgress,
        }}>
            {children}
        </OfflineSyncContext.Provider>
    );
};

export const useOfflineSync = () => {
    const context = useContext(OfflineSyncContext);
    if (context === undefined) throw new Error('useOfflineSync must be used within an OfflineSyncProvider');
    return context;
};
