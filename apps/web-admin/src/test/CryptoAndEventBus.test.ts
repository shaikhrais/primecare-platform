/**
 * Encryption, Event Bus, Task Queues, Geospatial & Health Monitoring — Phase 42
 *
 * Self-contained replicas covering:
 * - Encryption/hashing: key derivation, token generation, hash comparison
 * - Event bus: pub/sub, event filtering, dead letter queue
 * - Task queues: priority scheduling, retry policies, idempotency
 * - Geospatial: distance calculation, bounding box, coordinate validation
 * - Health monitoring: uptime calculation, status aggregation, alerting rules
 * - String utilities: slugify, truncate, mask, template literals
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Encryption & Hashing — Key Derivation, Token Generation
// ═══════════════════════════════════════════════════════════════════════════

function generateSalt(length: number = 16): string {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    for (let i = 0; i < length; i++) result += chars[Math.floor(Math.random() * chars.length)];
    return result;
}

function simpleHash(input: string): number {
    let hash = 0;
    for (let i = 0; i < input.length; i++) {
        hash = ((hash << 5) - hash) + input.charCodeAt(i);
        hash |= 0;
    }
    return Math.abs(hash);
}

function hashPassword(password: string, salt: string): string {
    return `${simpleHash(password + salt).toString(16)}:${salt}`;
}

function verifyPassword(password: string, stored: string): boolean {
    const [, salt] = stored.split(':');
    return hashPassword(password, salt) === stored;
}

function generateToken(length: number = 32): string {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    for (let i = 0; i < length; i++) result += chars[Math.floor(Math.random() * chars.length)];
    return result;
}

function isTokenExpired(issuedAt: number, ttlSeconds: number, now: number): boolean {
    return (now - issuedAt) > ttlSeconds * 1000;
}

function constantTimeCompare(a: string, b: string): boolean {
    if (a.length !== b.length) return false;
    let result = 0;
    for (let i = 0; i < a.length; i++) {
        result |= a.charCodeAt(i) ^ b.charCodeAt(i);
    }
    return result === 0;
}

describe('Crypto — Salt Generation', () => {
    it('correct length', () => expect(generateSalt(16).length).toBe(16));
    it('unique', () => expect(generateSalt()).not.toBe(generateSalt()));
    it('custom length', () => expect(generateSalt(32).length).toBe(32));
});

describe('Crypto — Hash', () => {
    it('deterministic', () => expect(simpleHash('hello')).toBe(simpleHash('hello')));
    it('different input', () => expect(simpleHash('hello')).not.toBe(simpleHash('world')));
    it('non-negative', () => expect(simpleHash('test')).toBeGreaterThanOrEqual(0));
});

describe('Crypto — Password', () => {
    it('hash and verify', () => {
        const hashed = hashPassword('secret123', 'mysalt');
        expect(verifyPassword('secret123', hashed)).toBe(true);
    });
    it('wrong password', () => {
        const hashed = hashPassword('secret123', 'mysalt');
        expect(verifyPassword('wrong', hashed)).toBe(false);
    });
    it('contains salt', () => expect(hashPassword('p', 'salt').split(':')[1]).toBe('salt'));
});

describe('Crypto — Token', () => {
    it('correct length', () => expect(generateToken(32).length).toBe(32));
    it('unique', () => expect(generateToken()).not.toBe(generateToken()));
    it('not expired', () => expect(isTokenExpired(1000, 3600, 2000)).toBe(false));
    it('expired', () => expect(isTokenExpired(1000, 1, 5000)).toBe(true));
});

describe('Crypto — Constant Time Compare', () => {
    it('equal', () => expect(constantTimeCompare('abc', 'abc')).toBe(true));
    it('not equal', () => expect(constantTimeCompare('abc', 'abd')).toBe(false));
    it('different length', () => expect(constantTimeCompare('abc', 'abcd')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Event Bus — Pub/Sub & Dead Letter Queue
// ═══════════════════════════════════════════════════════════════════════════

type EventHandler = (event: { type: string; payload: any }) => void;

class SimpleEventBus {
    private handlers = new Map<string, EventHandler[]>();
    private deadLetters: Array<{ type: string; payload: any; error: string }> = [];

    subscribe(eventType: string, handler: EventHandler): void {
        const existing = this.handlers.get(eventType) || [];
        existing.push(handler);
        this.handlers.set(eventType, existing);
    }

    unsubscribe(eventType: string, handler: EventHandler): void {
        const handlers = this.handlers.get(eventType) || [];
        this.handlers.set(eventType, handlers.filter(h => h !== handler));
    }

    publish(eventType: string, payload: any): number {
        const handlers = this.handlers.get(eventType) || [];
        if (handlers.length === 0) {
            this.deadLetters.push({ type: eventType, payload, error: 'No subscribers' });
            return 0;
        }
        handlers.forEach(h => h({ type: eventType, payload }));
        return handlers.length;
    }

    getSubscriberCount(eventType: string): number {
        return (this.handlers.get(eventType) || []).length;
    }

    getDeadLetters(): Array<{ type: string; payload: any; error: string }> {
        return [...this.deadLetters];
    }

    clearDeadLetters(): void {
        this.deadLetters = [];
    }
}

function matchEventPattern(eventType: string, pattern: string): boolean {
    if (pattern === '*') return true;
    if (pattern.endsWith('.*')) return eventType.startsWith(pattern.slice(0, -2) + '.');
    return eventType === pattern;
}

describe('EventBus — Subscribe/Publish', () => {
    it('basic pub/sub', () => {
        const bus = new SimpleEventBus();
        let received = false;
        bus.subscribe('test', () => { received = true; });
        bus.publish('test', {});
        expect(received).toBe(true);
    });
    it('multiple subscribers', () => {
        const bus = new SimpleEventBus();
        let count = 0;
        bus.subscribe('test', () => count++);
        bus.subscribe('test', () => count++);
        expect(bus.publish('test', {})).toBe(2);
        expect(count).toBe(2);
    });
    it('no subscribers', () => {
        const bus = new SimpleEventBus();
        expect(bus.publish('unknown', {})).toBe(0);
    });
});

describe('EventBus — Unsubscribe', () => {
    it('removes handler', () => {
        const bus = new SimpleEventBus();
        const handler = () => {};
        bus.subscribe('test', handler);
        expect(bus.getSubscriberCount('test')).toBe(1);
        bus.unsubscribe('test', handler);
        expect(bus.getSubscriberCount('test')).toBe(0);
    });
});

describe('EventBus — Dead Letters', () => {
    it('captures no-subscriber events', () => {
        const bus = new SimpleEventBus();
        bus.publish('orphan', { data: 1 });
        expect(bus.getDeadLetters().length).toBe(1);
        expect(bus.getDeadLetters()[0].type).toBe('orphan');
    });
    it('clears dead letters', () => {
        const bus = new SimpleEventBus();
        bus.publish('orphan', {});
        bus.clearDeadLetters();
        expect(bus.getDeadLetters().length).toBe(0);
    });
});

describe('EventBus — Pattern Matching', () => {
    it('exact', () => expect(matchEventPattern('user.created', 'user.created')).toBe(true));
    it('wildcard all', () => expect(matchEventPattern('user.created', '*')).toBe(true));
    it('namespace wildcard', () => expect(matchEventPattern('user.created', 'user.*')).toBe(true));
    it('no match', () => expect(matchEventPattern('user.created', 'visit.*')).toBe(false));
    it('exact no match', () => expect(matchEventPattern('user.created', 'user.deleted')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Task Queues — Priority, Retry & Idempotency
// ═══════════════════════════════════════════════════════════════════════════

type TaskPriority = 'critical' | 'high' | 'medium' | 'low';

function getPriorityValue(priority: TaskPriority): number {
    const map: Record<TaskPriority, number> = { critical: 0, high: 1, medium: 2, low: 3 };
    return map[priority];
}

function sortByPriority<T extends { priority: TaskPriority }>(tasks: T[]): T[] {
    return [...tasks].sort((a, b) => getPriorityValue(a.priority) - getPriorityValue(b.priority));
}

function shouldRetry(attempt: number, maxRetries: number, error: string): boolean {
    if (attempt >= maxRetries) return false;
    const nonRetryable = ['VALIDATION_ERROR', 'AUTH_ERROR', 'NOT_FOUND'];
    return !nonRetryable.includes(error);
}

function calculateBackoff(attempt: number, baseMs: number = 1000): number {
    return Math.min(baseMs * Math.pow(2, attempt), 300000);
}

function generateIdempotencyKey(resource: string, action: string, userId: string): string {
    return `${resource}:${action}:${userId}:${Date.now()}`;
}

function isIdempotencyKeyValid(key: string): boolean {
    const parts = key.split(':');
    return parts.length >= 4 && parts.every(p => p.length > 0);
}

describe('Queue — Priority', () => {
    it('sort order', () => {
        const tasks = [
            { name: 'A', priority: 'low' as TaskPriority },
            { name: 'B', priority: 'critical' as TaskPriority },
            { name: 'C', priority: 'high' as TaskPriority },
        ];
        const sorted = sortByPriority(tasks);
        expect(sorted[0].name).toBe('B');
        expect(sorted[1].name).toBe('C');
        expect(sorted[2].name).toBe('A');
    });
    it('values', () => {
        expect(getPriorityValue('critical')).toBe(0);
        expect(getPriorityValue('low')).toBe(3);
    });
});

describe('Queue — Retry', () => {
    it('retryable', () => expect(shouldRetry(0, 3, 'NETWORK_ERROR')).toBe(true));
    it('max retries', () => expect(shouldRetry(3, 3, 'NETWORK_ERROR')).toBe(false));
    it('validation not retryable', () => expect(shouldRetry(0, 3, 'VALIDATION_ERROR')).toBe(false));
    it('auth not retryable', () => expect(shouldRetry(0, 3, 'AUTH_ERROR')).toBe(false));
    it('not found not retryable', () => expect(shouldRetry(0, 3, 'NOT_FOUND')).toBe(false));
});

describe('Queue — Backoff', () => {
    it('attempt 0', () => expect(calculateBackoff(0)).toBe(1000));
    it('attempt 1', () => expect(calculateBackoff(1)).toBe(2000));
    it('attempt 2', () => expect(calculateBackoff(2)).toBe(4000));
    it('capped', () => expect(calculateBackoff(20)).toBe(300000));
});

describe('Queue — Idempotency', () => {
    it('generates key', () => {
        const key = generateIdempotencyKey('visit', 'create', 'u-1');
        expect(key).toContain('visit:create:u-1');
    });
    it('valid key', () => expect(isIdempotencyKeyValid('a:b:c:d')).toBe(true));
    it('invalid key', () => expect(isIdempotencyKeyValid('ab')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Geospatial — Distance, Bounding Box, Coordinate Validation
// ═══════════════════════════════════════════════════════════════════════════

function haversineDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
    const R = 6371;
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) ** 2 + Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) * Math.sin(dLon / 2) ** 2;
    return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

function isValidCoordinate(lat: number, lon: number): boolean {
    return lat >= -90 && lat <= 90 && lon >= -180 && lon <= 180;
}

function getBoundingBox(lat: number, lon: number, radiusKm: number): { minLat: number; maxLat: number; minLon: number; maxLon: number } {
    const latDelta = radiusKm / 111.32;
    const lonDelta = radiusKm / (111.32 * Math.cos(lat * Math.PI / 180));
    return {
        minLat: Math.round((lat - latDelta) * 10000) / 10000,
        maxLat: Math.round((lat + latDelta) * 10000) / 10000,
        minLon: Math.round((lon - lonDelta) * 10000) / 10000,
        maxLon: Math.round((lon + lonDelta) * 10000) / 10000,
    };
}

function isInBoundingBox(lat: number, lon: number, box: { minLat: number; maxLat: number; minLon: number; maxLon: number }): boolean {
    return lat >= box.minLat && lat <= box.maxLat && lon >= box.minLon && lon <= box.maxLon;
}

function formatCoordinate(lat: number, lon: number): string {
    const latDir = lat >= 0 ? 'N' : 'S';
    const lonDir = lon >= 0 ? 'E' : 'W';
    return `${Math.abs(lat).toFixed(4)}°${latDir}, ${Math.abs(lon).toFixed(4)}°${lonDir}`;
}

describe('Geo — Haversine', () => {
    it('same point', () => expect(haversineDistance(43.65, -79.38, 43.65, -79.38)).toBe(0));
    it('toronto to ottawa', () => {
        const d = haversineDistance(43.65, -79.38, 45.42, -75.69);
        expect(d).toBeGreaterThan(350);
        expect(d).toBeLessThan(405);
    });
});

describe('Geo — Valid Coordinates', () => {
    it('valid', () => expect(isValidCoordinate(43.65, -79.38)).toBe(true));
    it('poles', () => expect(isValidCoordinate(90, 180)).toBe(true));
    it('invalid lat', () => expect(isValidCoordinate(91, 0)).toBe(false));
    it('invalid lon', () => expect(isValidCoordinate(0, 181)).toBe(false));
});

describe('Geo — Bounding Box', () => {
    it('creates box', () => {
        const box = getBoundingBox(43.65, -79.38, 10);
        expect(box.minLat).toBeLessThan(43.65);
        expect(box.maxLat).toBeGreaterThan(43.65);
    });
    it('point in box', () => {
        const box = getBoundingBox(43.65, -79.38, 10);
        expect(isInBoundingBox(43.65, -79.38, box)).toBe(true);
    });
    it('point outside box', () => {
        const box = getBoundingBox(43.65, -79.38, 1);
        expect(isInBoundingBox(44.65, -79.38, box)).toBe(false);
    });
});

describe('Geo — Format', () => {
    it('positive', () => expect(formatCoordinate(43.6532, -79.3832)).toBe('43.6532°N, 79.3832°W'));
    it('negative', () => expect(formatCoordinate(-33.8688, 151.2093)).toBe('33.8688°S, 151.2093°E'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Health Monitoring — Uptime, Status, Alerting
// ═══════════════════════════════════════════════════════════════════════════

type ServiceStatus = 'healthy' | 'degraded' | 'unhealthy' | 'unknown';

function calculateUptime(totalMinutes: number, downMinutes: number): number {
    if (totalMinutes === 0) return 100;
    return Math.round(((totalMinutes - downMinutes) / totalMinutes) * 10000) / 100;
}

function aggregateStatus(statuses: ServiceStatus[]): ServiceStatus {
    if (statuses.some(s => s === 'unhealthy')) return 'unhealthy';
    if (statuses.some(s => s === 'degraded')) return 'degraded';
    if (statuses.every(s => s === 'healthy')) return 'healthy';
    return 'unknown';
}

function shouldAlert(status: ServiceStatus, previousStatus: ServiceStatus): boolean {
    if (status === 'unhealthy' && previousStatus !== 'unhealthy') return true;
    if (status === 'healthy' && previousStatus === 'unhealthy') return true;
    return false;
}

function getStatusEmoji(status: ServiceStatus): string {
    const emojis: Record<ServiceStatus, string> = { healthy: '🟢', degraded: '🟡', unhealthy: '🔴', unknown: '⚪' };
    return emojis[status];
}

function formatDuration(minutes: number): string {
    if (minutes < 60) return `${minutes}m`;
    if (minutes < 1440) return `${Math.floor(minutes / 60)}h ${minutes % 60}m`;
    return `${Math.floor(minutes / 1440)}d ${Math.floor((minutes % 1440) / 60)}h`;
}

describe('Health — Uptime', () => {
    it('100%', () => expect(calculateUptime(1440, 0)).toBe(100));
    it('99.9%', () => expect(calculateUptime(10000, 10)).toBe(99.9));
    it('95%', () => expect(calculateUptime(1000, 50)).toBe(95));
    it('zero total', () => expect(calculateUptime(0, 0)).toBe(100));
});

describe('Health — Aggregate', () => {
    it('all healthy', () => expect(aggregateStatus(['healthy', 'healthy'])).toBe('healthy'));
    it('one degraded', () => expect(aggregateStatus(['healthy', 'degraded'])).toBe('degraded'));
    it('one unhealthy', () => expect(aggregateStatus(['healthy', 'unhealthy'])).toBe('unhealthy'));
    it('unknown', () => expect(aggregateStatus(['healthy', 'unknown'])).toBe('unknown'));
});

describe('Health — Alert', () => {
    it('became unhealthy', () => expect(shouldAlert('unhealthy', 'healthy')).toBe(true));
    it('recovered', () => expect(shouldAlert('healthy', 'unhealthy')).toBe(true));
    it('still healthy', () => expect(shouldAlert('healthy', 'healthy')).toBe(false));
    it('still unhealthy', () => expect(shouldAlert('unhealthy', 'unhealthy')).toBe(false));
});

describe('Health — Emoji', () => {
    it('healthy', () => expect(getStatusEmoji('healthy')).toBe('🟢'));
    it('unhealthy', () => expect(getStatusEmoji('unhealthy')).toBe('🔴'));
});

describe('Health — Duration', () => {
    it('minutes', () => expect(formatDuration(45)).toBe('45m'));
    it('hours', () => expect(formatDuration(90)).toBe('1h 30m'));
    it('days', () => expect(formatDuration(1500)).toBe('1d 1h'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. String Utilities — Slugify, Truncate, Mask, Templates
// ═══════════════════════════════════════════════════════════════════════════

function slugify(text: string): string {
    return text.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

function truncate(text: string, maxLength: number, suffix: string = '...'): string {
    if (text.length <= maxLength) return text;
    return text.slice(0, maxLength - suffix.length) + suffix;
}

function maskString(value: string, visibleStart: number = 0, visibleEnd: number = 0): string {
    if (value.length <= visibleStart + visibleEnd) return '*'.repeat(value.length);
    const start = value.slice(0, visibleStart);
    const end = value.slice(value.length - visibleEnd);
    const masked = '*'.repeat(value.length - visibleStart - visibleEnd);
    return start + masked + end;
}

function capitalize(text: string): string {
    return text.charAt(0).toUpperCase() + text.slice(1).toLowerCase();
}

function titleCase(text: string): string {
    return text.split(/\s+/).map(word => capitalize(word)).join(' ');
}

function camelToSnake(text: string): string {
    return text.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);
}

function snakeToCamel(text: string): string {
    return text.replace(/_([a-z])/g, (_, letter) => letter.toUpperCase());
}

describe('String — Slugify', () => {
    it('basic', () => expect(slugify('Hello World')).toBe('hello-world'));
    it('special chars', () => expect(slugify('Hello, World!')).toBe('hello-world'));
    it('multiple spaces', () => expect(slugify('Hello   World')).toBe('hello-world'));
    it('leading/trailing', () => expect(slugify('  Hello  ')).toBe('hello'));
});

describe('String — Truncate', () => {
    it('short text', () => expect(truncate('Hi', 10)).toBe('Hi'));
    it('long text', () => expect(truncate('Hello World of Testing', 10)).toBe('Hello W...'));
    it('exact length', () => expect(truncate('12345', 5)).toBe('12345'));
    it('custom suffix', () => expect(truncate('Hello World', 8, '…')).toBe('Hello W…'));
});

describe('String — Mask', () => {
    it('full mask', () => expect(maskString('secret')).toBe('******'));
    it('show first 2', () => expect(maskString('secret', 2, 0)).toBe('se****'));
    it('show first and last', () => expect(maskString('secret', 1, 1)).toBe('s****t'));
    it('short value', () => expect(maskString('ab', 3, 0)).toBe('**'));
});

describe('String — Capitalize', () => {
    it('basic', () => expect(capitalize('hello')).toBe('Hello'));
    it('all caps', () => expect(capitalize('HELLO')).toBe('Hello'));
});

describe('String — Title Case', () => {
    it('basic', () => expect(titleCase('hello world')).toBe('Hello World'));
    it('mixed', () => expect(titleCase('hello WORLD')).toBe('Hello World'));
});

describe('String — Case Conversion', () => {
    it('camel to snake', () => expect(camelToSnake('userId')).toBe('user_id'));
    it('camel to snake multi', () => expect(camelToSnake('myFirstName')).toBe('my_first_name'));
    it('snake to camel', () => expect(snakeToCamel('user_id')).toBe('userId'));
    it('snake to camel multi', () => expect(snakeToCamel('my_first_name')).toBe('myFirstName'));
});
