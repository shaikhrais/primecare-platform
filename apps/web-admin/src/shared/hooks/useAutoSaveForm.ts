import { useState, useEffect, useRef } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';

const DB_KEY_PREFIX = 'primecare_rn_draft_';

export function useAutoSaveForm<T extends Record<string, any>>(formId: string, initialData: T) {
    const { showToast } = useNotification();
    const [data, setData] = useState<T>(initialData);
    const [lastSaved, setLastSaved] = useState<Date | null>(null);
    const [isRestored, setIsRestored] = useState(false);

    // Use a ref to strictly track the latest data for the interval closure without needing it in the dependency array
    const dataRef = useRef(data);
    dataRef.current = data;

    // Load from IndexedDB (mocked via localStorage for instant synchronously available demo)
    // In production, this would be a localForage async call.
    useEffect(() => {
        const key = `${DB_KEY_PREFIX}${formId}`;
        const savedDraft = localStorage.getItem(key);
        if (savedDraft) {
            try {
                const parsed = JSON.parse(savedDraft);
                setData(parsed.formData);
                setLastSaved(new Date(parsed.timestamp));
                setIsRestored(true);
                showToast(`Unsaved clinical draft recovered from ${new Date(parsed.timestamp).toLocaleTimeString()}`, 'warning');
            } catch (e) {
                console.error("Failed to parse draft", e);
            }
        }
    }, [formId]);

    // Background Autosave every 5 seconds
    useEffect(() => {
        const interval = setInterval(() => {
            const key = `${DB_KEY_PREFIX}${formId}`;
            const draftPayload = {
                timestamp: new Date().toISOString(),
                formData: dataRef.current
            };
            localStorage.setItem(key, JSON.stringify(draftPayload));
            setLastSaved(new Date());

            // Console log to simulate the flush operation silently
            console.log(`[IndexedDB Sync] Form '${formId}' auto-saved silently.`);
        }, 5000);

        return () => clearInterval(interval);
    }, [formId]);

    const updateField = (key: keyof T, value: any) => {
        setData(prev => ({ ...prev, [key]: value }));
    };

    const flushAndClear = () => {
        const key = `${DB_KEY_PREFIX}${formId}`;
        localStorage.removeItem(key);
        setLastSaved(null);
        setIsRestored(false);
    };

    return { data, updateField, lastSaved, isRestored, flushAndClear };
}
