/**
 * Utility Hooks Collection
 *
 * useDebounce    — Debounce a value (for search inputs, API calls)
 * useThrottle    — Throttle a callback (for scroll/resize handlers)
 * useLocalStorage — Typed localStorage with sync across tabs
 * useMediaQuery  — Responsive breakpoint detection
 * usePrevious    — Track previous value of a variable
 * useClipboard   — Copy text to clipboard
 * useOnClickOutside — Detect clicks outside a ref
 */
import { useState, useEffect, useRef, useCallback } from 'react';

// ── useDebounce ───────────────────────────────────────────────────────────

export function useDebounce<T>(value: T, delayMs: number = 300): T {
    const [debounced, setDebounced] = useState(value);
    useEffect(() => {
        const timer = setTimeout(() => setDebounced(value), delayMs);
        return () => clearTimeout(timer);
    }, [value, delayMs]);
    return debounced;
}

// ── useThrottle ───────────────────────────────────────────────────────────

export function useThrottle<T extends (...args: unknown[]) => void>(
    fn: T, delayMs: number = 300
): T {
    const lastRun = useRef(0);
    const timeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);

    return useCallback((...args: unknown[]) => {
        const now = Date.now();
        const remaining = delayMs - (now - lastRun.current);

        if (remaining <= 0) {
            lastRun.current = now;
            fn(...args);
        } else if (!timeoutRef.current) {
            timeoutRef.current = setTimeout(() => {
                lastRun.current = Date.now();
                timeoutRef.current = null;
                fn(...args);
            }, remaining);
        }
    }, [fn, delayMs]) as T;
}

// ── useLocalStorage ───────────────────────────────────────────────────────

export function useLocalStorage<T>(key: string, initialValue: T): [T, (value: T | ((prev: T) => T)) => void, () => void] {
    const [stored, setStored] = useState<T>(() => {
        try {
            const item = localStorage.getItem(key);
            return item ? JSON.parse(item) : initialValue;
        } catch {
            return initialValue;
        }
    });

    const setValue = useCallback((value: T | ((prev: T) => T)) => {
        setStored(prev => {
            const next = value instanceof Function ? value(prev) : value;
            try {
                localStorage.setItem(key, JSON.stringify(next));
            } catch { /* quota exceeded */ }
            return next;
        });
    }, [key]);

    const remove = useCallback(() => {
        localStorage.removeItem(key);
        setStored(initialValue);
    }, [key, initialValue]);

    // Sync across tabs
    useEffect(() => {
        const handler = (e: StorageEvent) => {
            if (e.key === key && e.newValue) {
                try { setStored(JSON.parse(e.newValue)); } catch { /* */ }
            }
        };
        window.addEventListener('storage', handler);
        return () => window.removeEventListener('storage', handler);
    }, [key]);

    return [stored, setValue, remove];
}

// ── useMediaQuery ─────────────────────────────────────────────────────────

export function useMediaQuery(query: string): boolean {
    const [matches, setMatches] = useState(() => {
        if (typeof window === 'undefined') return false;
        return window.matchMedia(query).matches;
    });

    useEffect(() => {
        const mql = window.matchMedia(query);
        const handler = (e: MediaQueryListEvent) => setMatches(e.matches);
        mql.addEventListener('change', handler);
        setMatches(mql.matches);
        return () => mql.removeEventListener('change', handler);
    }, [query]);

    return matches;
}

/** Pre-defined breakpoints */
export const useIsMobile = () => useMediaQuery('(max-width: 768px)');
export const useIsTablet = () => useMediaQuery('(min-width: 769px) and (max-width: 1024px)');
export const useIsDesktop = () => useMediaQuery('(min-width: 1025px)');

// ── usePrevious ───────────────────────────────────────────────────────────

export function usePrevious<T>(value: T): T | undefined {
    const ref = useRef<T | undefined>(undefined);
    useEffect(() => { ref.current = value; });
    return ref.current;
}

// ── useClipboard ──────────────────────────────────────────────────────────

export function useClipboard(timeout: number = 2000) {
    const [copied, setCopied] = useState(false);

    const copy = useCallback(async (text: string) => {
        try {
            await navigator.clipboard.writeText(text);
            setCopied(true);
            setTimeout(() => setCopied(false), timeout);
            return true;
        } catch {
            // Fallback for older browsers
            const ta = document.createElement('textarea');
            ta.value = text;
            ta.style.position = 'fixed';
            ta.style.opacity = '0';
            document.body.appendChild(ta);
            ta.select();
            document.execCommand('copy');
            document.body.removeChild(ta);
            setCopied(true);
            setTimeout(() => setCopied(false), timeout);
            return true;
        }
    }, [timeout]);

    return { copy, copied };
}

// ── useOnClickOutside ─────────────────────────────────────────────────────

export function useOnClickOutside<T extends HTMLElement>(
    ref: React.RefObject<T | null>,
    handler: (event: MouseEvent | TouchEvent) => void
) {
    useEffect(() => {
        const listener = (event: MouseEvent | TouchEvent) => {
            if (!ref.current || ref.current.contains(event.target as Node)) return;
            handler(event);
        };
        document.addEventListener('mousedown', listener);
        document.addEventListener('touchstart', listener);
        return () => {
            document.removeEventListener('mousedown', listener);
            document.removeEventListener('touchstart', listener);
        };
    }, [ref, handler]);
}
