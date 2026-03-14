/**
 * UsageTracker — Singleton service that tracks ALL platform usage statistics.
 *
 * Tracks:
 * - Route visits (count + timestamps + time spent)
 * - Form submissions / data entries
 * - API calls (endpoint, method, errors)
 * - Click interactions (buttons, links, nav items)
 * - Scroll depth per route
 *
 * Persistence:
 * - localStorage for instant access (primary)
 * - Database sync via /v1/admin/settings/usage-stats (secondary, periodic)
 */
import type { UsageSnapshot } from './UsageTrackerTypes';
import { STORAGE_KEY, DB_SYNC_INTERVAL, createEmptySnapshot } from './UsageTrackerTypes';

// Re-export types for consumers
export type { RouteVisit, FormEntry, ApiCall, ClickEvent, UsageSnapshot } from './UsageTrackerTypes';

class UsageTrackerService {
    private data: UsageSnapshot;
    private currentRoute: string | null = null;
    private routeStartTime: number = 0;
    private saveTimeout: ReturnType<typeof setTimeout> | null = null;
    private globalListenersAttached = false;
    private dbSyncTimer: ReturnType<typeof setInterval> | null = null;
    private dirty = false;
    private dbLoaded = false;

    constructor() {
        this.data = this.load();
        this.data.totalSessions++;
        this.data.sessionStart = Date.now();
        this.saveLocal();
        this.loadFromDB();
        this.dbSyncTimer = setInterval(() => this.syncToDB(), DB_SYNC_INTERVAL);
    }

    private load(): UsageSnapshot {
        try { const raw = localStorage.getItem(STORAGE_KEY); if (raw) return { ...createEmptySnapshot(), ...JSON.parse(raw) }; } catch { }
        return createEmptySnapshot();
    }

    private saveLocal() {
        if (this.saveTimeout) clearTimeout(this.saveTimeout);
        this.saveTimeout = setTimeout(() => { try { localStorage.setItem(STORAGE_KEY, JSON.stringify(this.data)); } catch { } }, 300);
    }

    private async loadFromDB() {
        if (!localStorage.getItem('user')) return;
        try {
            const { apiClient } = await import('@/shared/utils/apiClient');
            const res = await apiClient.get('/v1/admin/settings/usage-stats');
            if (res.ok) { const { usageStats } = await res.json(); if (usageStats) { this.mergeSnapshot(usageStats); this.saveLocal(); this.dbLoaded = true; } }
        } catch { }
    }

    private mergeSnapshot(remote: UsageSnapshot) {
        if (remote.routes) {
            for (const [key, rv] of Object.entries(remote.routes)) {
                if (!this.data.routes[key]) { this.data.routes[key] = rv; } else {
                    const local = this.data.routes[key];
                    local.count = Math.max(local.count, rv.count); local.totalTimeMs = Math.max(local.totalTimeMs, rv.totalTimeMs);
                    local.maxScrollDepth = Math.max(local.maxScrollDepth || 0, rv.maxScrollDepth || 0); local.lastVisit = Math.max(local.lastVisit, rv.lastVisit);
                }
            }
        }
        if (remote.clicks) { for (const [key, ce] of Object.entries(remote.clicks)) { if (!this.data.clicks[key]) { this.data.clicks[key] = ce; } else { this.data.clicks[key].count = Math.max(this.data.clicks[key].count, ce.count); this.data.clicks[key].lastClick = Math.max(this.data.clicks[key].lastClick, ce.lastClick); } } }
        if (remote.forms) { for (const [key, fe] of Object.entries(remote.forms)) { if (!this.data.forms[key]) { this.data.forms[key] = fe; } else { this.data.forms[key].count = Math.max(this.data.forms[key].count, fe.count); this.data.forms[key].lastEntry = Math.max(this.data.forms[key].lastEntry, fe.lastEntry); } } }
        if (remote.apiCalls) { for (const [key, ac] of Object.entries(remote.apiCalls)) { if (!this.data.apiCalls[key]) { this.data.apiCalls[key] = ac; } else { this.data.apiCalls[key].count = Math.max(this.data.apiCalls[key].count, ac.count); this.data.apiCalls[key].errors = Math.max(this.data.apiCalls[key].errors, ac.errors); this.data.apiCalls[key].lastCall = Math.max(this.data.apiCalls[key].lastCall, ac.lastCall); } } }
        this.data.totalClicks = Math.max(this.data.totalClicks || 0, remote.totalClicks || 0);
        this.data.totalFormSubmits = Math.max(this.data.totalFormSubmits || 0, remote.totalFormSubmits || 0);
        this.data.totalSessions = Math.max(this.data.totalSessions || 0, remote.totalSessions || 0);
    }

    async syncToDB() {
        if (!this.dirty || !localStorage.getItem('user')) return;
        try { const { apiClient } = await import('@/shared/utils/apiClient'); const res = await apiClient.patch('/v1/admin/settings/usage-stats', { usageStats: this.data }); if (res.ok) this.dirty = false; } catch { }
    }

    async forceSyncToDB() { this.dirty = true; await this.syncToDB(); }

    attachGlobalListeners() {
        if (this.globalListenersAttached) return;
        this.globalListenersAttached = true;

        document.addEventListener('click', (e) => {
            const target = e.target as HTMLElement; if (!target) return;
            const tag = target.tagName?.toLowerCase() || 'unknown';
            const role = target.getAttribute('role') || '';
            const isInteractive = ['button', 'a', 'input', 'select', 'textarea', 'label'].includes(tag) || role === 'button' || role === 'tab' || role === 'link' || target.closest('button') || target.closest('a') || target.style?.cursor === 'pointer';
            if (!isInteractive) return;
            const btn = target.closest('button'); const link = target.closest('a');
            const interactive = btn || link || target; const iTag = interactive.tagName?.toLowerCase() || tag;
            const iText = (interactive.textContent || '').trim().slice(0, 40); const iId = interactive.id ? `#${interactive.id}` : '';
            const ariaLabel = interactive.getAttribute('aria-label') || '';
            const label = iText || ariaLabel || iId || `<${iTag}>`;
            const key = `${iTag}:${label}`;
            if (!this.data.clicks[key]) { this.data.clicks[key] = { target: label, count: 0, lastClick: 0, elementType: iTag }; }
            this.data.clicks[key].count++; this.data.clicks[key].lastClick = Date.now();
            this.data.totalClicks++; this.data.lastActivity = Date.now(); this.dirty = true; this.saveLocal();
        }, true);

        document.addEventListener('submit', (e) => { const form = e.target as HTMLFormElement; const formId = form.id || form.getAttribute('name') || form.action || 'unknown-form'; this.trackForm(formId); }, true);

        let scrollTimeout: ReturnType<typeof setTimeout>;
        window.addEventListener('scroll', () => {
            clearTimeout(scrollTimeout);
            scrollTimeout = setTimeout(() => {
                if (!this.currentRoute) return;
                const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
                const depth = scrollHeight > 0 ? Math.round((window.scrollY / scrollHeight) * 100) : 100;
                if (this.data.routes[this.currentRoute]) { this.data.routes[this.currentRoute].maxScrollDepth = Math.max(this.data.routes[this.currentRoute].maxScrollDepth || 0, depth); this.dirty = true; this.saveLocal(); }
            }, 200);
        }, { passive: true });

        window.addEventListener('beforeunload', () => {
            this.dirty = true;
            try {
                const API_URL = (window as any).__VITE_API_URL || '';
                navigator.sendBeacon(`${API_URL}/v1/admin/settings/usage-stats`, new Blob([JSON.stringify({ usageStats: this.data })], { type: 'application/json' }));
            } catch { }
        });
    }

    trackRoute(path: string, label?: string) {
        if (this.currentRoute && this.routeStartTime) { const elapsed = Date.now() - this.routeStartTime; if (this.data.routes[this.currentRoute]) { this.data.routes[this.currentRoute].totalTimeMs += elapsed; } }
        this.currentRoute = path; this.routeStartTime = Date.now();
        if (!this.data.routes[path]) { this.data.routes[path] = { path, count: 0, lastVisit: 0, totalTimeMs: 0, maxScrollDepth: 0, label }; }
        this.data.routes[path].count++; this.data.routes[path].lastVisit = Date.now(); if (label) this.data.routes[path].label = label;
        this.data.lastActivity = Date.now(); this.dirty = true; this.saveLocal();
    }

    trackForm(formId: string, label?: string) {
        if (!this.data.forms[formId]) { this.data.forms[formId] = { formId, count: 0, lastEntry: 0, label }; }
        this.data.forms[formId].count++; this.data.forms[formId].lastEntry = Date.now(); if (label) this.data.forms[formId].label = label;
        this.data.totalFormSubmits++; this.data.lastActivity = Date.now(); this.dirty = true; this.saveLocal();
    }

    trackApiCall(endpoint: string, method: string, isError = false) {
        if (endpoint.includes('usage-stats')) return;
        const key = `${method}:${endpoint}`;
        if (!this.data.apiCalls[key]) { this.data.apiCalls[key] = { endpoint, method, count: 0, lastCall: 0, errors: 0 }; }
        this.data.apiCalls[key].count++; this.data.apiCalls[key].lastCall = Date.now(); if (isError) this.data.apiCalls[key].errors++;
        this.data.lastActivity = Date.now(); this.dirty = true; this.saveLocal();
    }

    getSnapshot(): UsageSnapshot {
        if (this.currentRoute && this.routeStartTime && this.data.routes[this.currentRoute]) { this.data.routes[this.currentRoute].totalTimeMs += (Date.now() - this.routeStartTime); this.routeStartTime = Date.now(); }
        return { ...this.data };
    }

    reset() {
        this.data = createEmptySnapshot(); this.data.totalSessions = 1; this.dirty = true;
        try { localStorage.setItem(STORAGE_KEY, JSON.stringify(this.data)); } catch { }
        this.syncToDB();
    }
}

// Singleton
export const UsageTracker = new UsageTrackerService();
