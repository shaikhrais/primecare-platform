// UsageTracker type definitions — extracted from UsageTracker.ts
export interface RouteVisit {
    path: string;
    count: number;
    lastVisit: number;
    totalTimeMs: number;
    maxScrollDepth: number;
    label?: string;
}

export interface FormEntry {
    formId: string;
    count: number;
    lastEntry: number;
    label?: string;
}

export interface ApiCall {
    endpoint: string;
    method: string;
    count: number;
    lastCall: number;
    errors: number;
}

export interface ClickEvent {
    target: string;
    count: number;
    lastClick: number;
    elementType: string;
}

export interface UsageSnapshot {
    routes: Record<string, RouteVisit>;
    forms: Record<string, FormEntry>;
    apiCalls: Record<string, ApiCall>;
    clicks: Record<string, ClickEvent>;
    sessionStart: number;
    totalSessions: number;
    lastActivity: number;
    totalClicks: number;
    totalFormSubmits: number;
}

export const STORAGE_KEY = 'pc_usage_stats';
export const DB_SYNC_INTERVAL = 30_000;

export const createEmptySnapshot = (): UsageSnapshot => ({
    routes: {},
    forms: {},
    apiCalls: {},
    clicks: {},
    sessionStart: Date.now(),
    totalSessions: 0,
    lastActivity: Date.now(),
    totalClicks: 0,
    totalFormSubmits: 0,
});
