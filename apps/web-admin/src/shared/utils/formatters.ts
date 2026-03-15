/**
 * Date & Number Formatting Utilities
 *
 * Provides locale-aware formatting for dates, times, currencies,
 * durations, relative time, and numeric values throughout the app.
 *
 * Usage:
 *   import { formatDate, formatCurrency, formatDuration } from '@/shared/utils/formatters';
 */

// ── Date Formatting ───────────────────────────────────────────────────────

/** Format a date string or Date for display */
export function formatDate(date: string | Date, style: 'short' | 'medium' | 'long' = 'medium'): string {
    const d = typeof date === 'string' ? new Date(date) : date;
    if (isNaN(d.getTime())) return 'Invalid date';

    const options: Intl.DateTimeFormatOptions = style === 'short'
        ? { month: 'numeric', day: 'numeric', year: '2-digit' }
        : style === 'long'
            ? { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }
            : { year: 'numeric', month: 'short', day: 'numeric' };

    return d.toLocaleDateString('en-CA', options);
}

/** Format time only */
export function formatTime(date: string | Date, use24h = false): string {
    const d = typeof date === 'string' ? new Date(date) : date;
    if (isNaN(d.getTime())) return 'Invalid time';
    return d.toLocaleTimeString('en-CA', { hour: '2-digit', minute: '2-digit', hour12: !use24h });
}

/** Format as date + time */
export function formatDateTime(date: string | Date): string {
    return `${formatDate(date)} ${formatTime(date)}`;
}

/** Relative time (e.g., "2 hours ago", "in 3 days") */
export function formatRelativeTime(date: string | Date): string {
    const d = typeof date === 'string' ? new Date(date) : date;
    if (isNaN(d.getTime())) return 'Invalid date';

    const now = Date.now();
    const diff = now - d.getTime();
    const absDiff = Math.abs(diff);
    const isFuture = diff < 0;
    const prefix = isFuture ? 'in ' : '';
    const suffix = isFuture ? '' : ' ago';

    if (absDiff < 60_000) return 'just now';
    if (absDiff < 3_600_000) {
        const mins = Math.floor(absDiff / 60_000);
        return `${prefix}${mins} minute${mins > 1 ? 's' : ''}${suffix}`;
    }
    if (absDiff < 86_400_000) {
        const hrs = Math.floor(absDiff / 3_600_000);
        return `${prefix}${hrs} hour${hrs > 1 ? 's' : ''}${suffix}`;
    }
    if (absDiff < 2_592_000_000) {
        const days = Math.floor(absDiff / 86_400_000);
        return `${prefix}${days} day${days > 1 ? 's' : ''}${suffix}`;
    }
    return formatDate(d);
}

/** Is date today? */
export function isToday(date: string | Date): boolean {
    const d = typeof date === 'string' ? new Date(date) : date;
    const now = new Date();
    return d.getDate() === now.getDate() && d.getMonth() === now.getMonth() && d.getFullYear() === now.getFullYear();
}

/** Is date in the past? */
export function isPast(date: string | Date): boolean {
    const d = typeof date === 'string' ? new Date(date) : date;
    return d.getTime() < Date.now();
}

/** Get start of day */
export function startOfDay(date: string | Date): Date {
    const d = typeof date === 'string' ? new Date(date) : new Date(date);
    d.setHours(0, 0, 0, 0);
    return d;
}

/** Age from date of birth */
export function calculateAge(dob: string | Date): number {
    const d = typeof dob === 'string' ? new Date(dob) : dob;
    const today = new Date();
    let age = today.getFullYear() - d.getFullYear();
    const monthDiff = today.getMonth() - d.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < d.getDate())) age--;
    return age;
}

// ── Number Formatting ─────────────────────────────────────────────────────

/** Format as currency (CAD default) */
export function formatCurrency(amount: number, currency = 'CAD', locale = 'en-CA'): string {
    return new Intl.NumberFormat(locale, { style: 'currency', currency }).format(amount);
}

/** Format as percentage */
export function formatPercent(value: number, decimals = 1): string {
    return `${(value * 100).toFixed(decimals)}%`;
}

/** Format with compact notation (1.2K, 3.4M) */
export function formatCompact(num: number): string {
    return new Intl.NumberFormat('en', { notation: 'compact', maximumFractionDigits: 1 }).format(num);
}

/** Format with thousands separators */
export function formatNumber(num: number, decimals?: number): string {
    return new Intl.NumberFormat('en-CA', {
        minimumFractionDigits: decimals,
        maximumFractionDigits: decimals,
    }).format(num);
}

/** Clamp a number between min and max */
export function clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max);
}

// ── Duration Formatting ───────────────────────────────────────────────────

/** Format milliseconds as human-readable duration */
export function formatDuration(ms: number): string {
    if (ms < 0) return '0s';
    if (ms < 1000) return `${ms}ms`;

    const seconds = Math.floor(ms / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);

    if (hours > 0) return `${hours}h ${minutes % 60}m`;
    if (minutes > 0) return `${minutes}m ${seconds % 60}s`;
    return `${seconds}s`;
}

/** Format hours as "Xh Ym" */
export function formatHours(hours: number): string {
    const h = Math.floor(hours);
    const m = Math.round((hours - h) * 60);
    if (h === 0) return `${m}m`;
    if (m === 0) return `${h}h`;
    return `${h}h ${m}m`;
}

// ── String Utilities ──────────────────────────────────────────────────────

/** Truncate string with ellipsis */
export function truncate(str: string, maxLen: number): string {
    if (str.length <= maxLen) return str;
    return str.slice(0, maxLen - 3) + '...';
}

/** Capitalize first letter */
export function capitalize(str: string): string {
    if (!str) return '';
    return str.charAt(0).toUpperCase() + str.slice(1);
}

/** Title case */
export function titleCase(str: string): string {
    return str.replace(/\b\w/g, (c) => c.toUpperCase());
}

/** Initials from name (e.g., "John Doe" → "JD") */
export function getInitials(name: string, maxChars = 2): string {
    return name
        .split(/\s+/)
        .map(word => word.charAt(0).toUpperCase())
        .slice(0, maxChars)
        .join('');
}

/** Slugify a string */
export function slugify(str: string): string {
    return str
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/^-|-$/g, '');
}

/** Generate random ID */
export function generateId(prefix = ''): string {
    const id = Math.random().toString(36).substring(2, 10);
    return prefix ? `${prefix}_${id}` : id;
}
