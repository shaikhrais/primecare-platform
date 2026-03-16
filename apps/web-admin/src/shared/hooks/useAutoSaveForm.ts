import { useState, useEffect, useRef } from 'react';
import { useToast as useNotification } from '@/shared/hooks/useToast';

const DB_KEY_PREFIX = 'primecare_rn_draft_';

export function useAutoSaveForm<T extends Record<string, any>>(formId: string, initialData: T) {
    const { showToast } = useNotification();
    const [data, setData] = useState<T>(initialData);
    const [lastSaved, setLastSaved] = useState<Date | null>(null);
    const [isRestored, setIsRestored] = useState(false);

    // Use a ref to strictly track the latest data for the interval closure without needing it in the dependency array
    const dataRef = useRef(data);
    dataRef.current = data;

    // Load from IndexedDB
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

            // Logging auto-save operations silently
            console.log(`[AutoSave] Flushed partial form data to indexedDB offline queue.`);
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
