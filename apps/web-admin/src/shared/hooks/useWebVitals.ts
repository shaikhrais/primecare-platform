/**
 * useWebVitals — Performance monitoring hook
 *
 * Captures Core Web Vitals (LCP, FID, CLS, TTFB, INP) and reports
 * them via structured console logging for Cloudflare analytics.
 *
 * Usage: Call once in App.tsx
 *   useWebVitals();
 */
import { useEffect } from 'react';

interface VitalMetric {
    name: string;
    value: number;
    rating: 'good' | 'needs-improvement' | 'poor';
    delta: number;
}

function getRating(name: string, value: number): VitalMetric['rating'] {
    const thresholds: Record<string, [number, number]> = {
        LCP: [2500, 4000],
        FID: [100, 300],
        CLS: [0.1, 0.25],
        TTFB: [800, 1800],
        INP: [200, 500],
        FCP: [1800, 3000],
    };
    const [good, poor] = thresholds[name] || [1000, 3000];
    if (value <= good) return 'good';
    if (value <= poor) return 'needs-improvement';
    return 'poor';
}

function reportVital(metric: VitalMetric) {
    console.log(JSON.stringify({
        level: 'info',
        type: 'WEB_VITAL',
        timestamp: new Date().toISOString(),
        metric: metric.name,
        value: Math.round(metric.value * 100) / 100,
        rating: metric.rating,
        delta: Math.round(metric.delta * 100) / 100,
        url: window.location.pathname,
    }));
}

export function useWebVitals() {
    useEffect(() => {
        // Use PerformanceObserver to capture Core Web Vitals
        if (typeof window === 'undefined' || !('PerformanceObserver' in window)) return;

        // Largest Contentful Paint (LCP)
        try {
            const lcpObserver = new PerformanceObserver((list) => {
                const entries = list.getEntries();
                const lastEntry = entries[entries.length - 1] as any;
                if (lastEntry) {
                    reportVital({
                        name: 'LCP',
                        value: lastEntry.startTime,
                        rating: getRating('LCP', lastEntry.startTime),
                        delta: lastEntry.startTime,
                    });
                }
            });
            lcpObserver.observe({ type: 'largest-contentful-paint', buffered: true });
        } catch { /* Browser doesn't support this observer */ }

        // First Contentful Paint (FCP)
        try {
            const fcpObserver = new PerformanceObserver((list) => {
                const entries = list.getEntries();
                const fcp = entries.find(e => e.name === 'first-contentful-paint');
                if (fcp) {
                    reportVital({
                        name: 'FCP',
                        value: fcp.startTime,
                        rating: getRating('FCP', fcp.startTime),
                        delta: fcp.startTime,
                    });
                }
            });
            fcpObserver.observe({ type: 'paint', buffered: true });
        } catch { /* */ }

        // Cumulative Layout Shift (CLS)
        try {
            let clsValue = 0;
            const clsObserver = new PerformanceObserver((list) => {
                for (const entry of list.getEntries() as any[]) {
                    if (!entry.hadRecentInput) {
                        clsValue += entry.value;
                    }
                }
            });
            clsObserver.observe({ type: 'layout-shift', buffered: true });

            // Report CLS on page hide
            const reportCLS = () => {
                reportVital({ name: 'CLS', value: clsValue, rating: getRating('CLS', clsValue), delta: clsValue });
            };
            document.addEventListener('visibilitychange', () => {
                if (document.visibilityState === 'hidden') reportCLS();
            });
        } catch { /* */ }

        // Time to First Byte (TTFB)
        try {
            const navEntry = performance.getEntriesByType('navigation')[0] as PerformanceNavigationTiming;
            if (navEntry) {
                const ttfb = navEntry.responseStart - navEntry.requestStart;
                reportVital({ name: 'TTFB', value: ttfb, rating: getRating('TTFB', ttfb), delta: ttfb });
            }
        } catch { /* */ }

        // First Input Delay (FID) / Interaction to Next Paint (INP)
        try {
            const fidObserver = new PerformanceObserver((list) => {
                const entries = list.getEntries() as any[];
                const firstInput = entries[0];
                if (firstInput) {
                    const fid = firstInput.processingStart - firstInput.startTime;
                    reportVital({ name: 'FID', value: fid, rating: getRating('FID', fid), delta: fid });
                }
            });
            fidObserver.observe({ type: 'first-input', buffered: true });
        } catch { /* */ }

    }, []);
}

export default useWebVitals;
