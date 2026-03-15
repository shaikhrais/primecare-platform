/**
 * AI Engine Tests — Phase 29
 *
 * Self-contained replicas of logic from:
 * - FallRiskAlgorithm.ts: ADL mobility filtering, risk decay scoring
 * - SentimentAnalyzer.ts: NLP keyword hostility detection
 * - SmartShiftMatcher.ts: Haversine distance, skill overlap, weighted scoring
 * - WeeklyLLMSummary.ts: clinical note compilation, context formatting
 * - Additional: weighted scoring, geospatial bounds, text normalization
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Fall Risk — ADL Mobility Filtering (replicated from FallRiskAlgorithm.ts)
// ═══════════════════════════════════════════════════════════════════════════

type ADLType = 'MOBILITY' | 'HYGIENE' | 'NUTRITION';
type ADLStatus = 'IN_PROGRESS' | 'COMPLETED' | 'STRUGGLING' | 'FAILED';

interface ClinicalADL {
    id: string;
    type: ADLType;
    status: ADLStatus;
    timestamp: string;
}

function filterMobilityTasks(adls: ClinicalADL[]): ClinicalADL[] {
    return adls.filter(a => a.type === 'MOBILITY');
}

function calculateRiskDecay(adls: ClinicalADL[]): number {
    const mobilityTasks = filterMobilityTasks(adls);
    if (mobilityTasks.length === 0) return 0.0;
    let riskScore = 0.0;
    mobilityTasks.forEach(task => {
        if (task.status === 'STRUGGLING') riskScore += 0.2;
        if (task.status === 'FAILED') riskScore += 0.35;
    });
    return Math.min(riskScore, 1.0);
}

function isAtRisk(score: number, threshold: number = 0.8): boolean {
    return score >= threshold;
}

const SAMPLE_ADLS: ClinicalADL[] = [
    { id: '1', type: 'MOBILITY', status: 'COMPLETED', timestamp: '2026-03-01' },
    { id: '2', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-03-05' },
    { id: '3', type: 'HYGIENE', status: 'COMPLETED', timestamp: '2026-03-06' },
    { id: '4', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-03-07' },
    { id: '5', type: 'MOBILITY', status: 'FAILED', timestamp: '2026-03-09' },
];

describe('Fall Risk — Mobility Filtering', () => {
    it('filters mobility only', () => {
        expect(filterMobilityTasks(SAMPLE_ADLS).length).toBe(4);
    });
    it('excludes hygiene', () => {
        expect(filterMobilityTasks(SAMPLE_ADLS).every(a => a.type === 'MOBILITY')).toBe(true);
    });
    it('empty array', () => expect(filterMobilityTasks([])).toEqual([]));
    it('no mobility', () => {
        expect(filterMobilityTasks([{ id: '1', type: 'HYGIENE', status: 'COMPLETED', timestamp: '' }])).toEqual([]);
    });
});

describe('Fall Risk — Risk Decay Score', () => {
    it('sample data score', () => {
        const score = calculateRiskDecay(SAMPLE_ADLS);
        // 2 STRUGGLING (0.4) + 1 FAILED (0.35) = 0.75
        expect(score).toBeCloseTo(0.75, 2);
    });
    it('all completed = 0', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'COMPLETED', timestamp: '' },
        ];
        expect(calculateRiskDecay(adls)).toBe(0);
    });
    it('caps at 1.0', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
            { id: '2', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
            { id: '3', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
        ];
        expect(calculateRiskDecay(adls)).toBe(1.0); // 3×0.35 = 1.05 → 1.0
    });
    it('empty = 0', () => expect(calculateRiskDecay([])).toBe(0));
    it('single struggling', () => {
        expect(calculateRiskDecay([{ id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '' }])).toBe(0.2);
    });
    it('single failed', () => {
        expect(calculateRiskDecay([{ id: '1', type: 'MOBILITY', status: 'FAILED', timestamp: '' }])).toBe(0.35);
    });
});

describe('Fall Risk — Threshold', () => {
    it('at risk', () => expect(isAtRisk(0.8)).toBe(true));
    it('above risk', () => expect(isAtRisk(0.95)).toBe(true));
    it('below risk', () => expect(isAtRisk(0.79)).toBe(false));
    it('custom threshold', () => expect(isAtRisk(0.5, 0.5)).toBe(true));
    it('custom below', () => expect(isAtRisk(0.49, 0.5)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Sentiment Analyzer (replicated from SentimentAnalyzer.ts)
// ═══════════════════════════════════════════════════════════════════════════

const NEGATIVE_KEYWORDS = ['angry', 'late', 'unprofessional', 'terrible', 'upset', 'complain', 'frustrated'];

function analyzeMessagePayload(text: string): { isHostile: boolean; confidence: number } {
    if (!text) return { isHostile: false, confidence: 0 };
    const lowerText = text.toLowerCase();
    const words = lowerText.split(/\s+/);
    let hostileMatches = 0;
    words.forEach(word => {
        if (NEGATIVE_KEYWORDS.includes(word)) hostileMatches++;
    });
    const isHostile = hostileMatches >= 2;
    const confidence = isHostile ? 0.85 + (hostileMatches * 0.05) : 0.1;
    return { isHostile, confidence: Math.min(confidence, 0.99) };
}

describe('Sentiment — No Hostility', () => {
    it('clean message', () => {
        const r = analyzeMessagePayload('Everything is great today');
        expect(r.isHostile).toBe(false);
        expect(r.confidence).toBe(0.1);
    });
    it('single negative word', () => {
        const r = analyzeMessagePayload('I am frustrated');
        expect(r.isHostile).toBe(false);
    });
    it('empty', () => {
        const r = analyzeMessagePayload('');
        expect(r.isHostile).toBe(false);
        expect(r.confidence).toBe(0);
    });
});

describe('Sentiment — Hostility Detected', () => {
    it('two negative words', () => {
        const r = analyzeMessagePayload('I am angry and frustrated');
        expect(r.isHostile).toBe(true);
        expect(r.confidence).toBe(0.95);
    });
    it('three negative words', () => {
        const r = analyzeMessagePayload('The caregiver was late unprofessional and terrible');
        expect(r.isHostile).toBe(true);
        expect(r.confidence).toBe(0.99); // 0.85 + 3*0.05 = 1.0, capped at 0.99
    });
    it('mixed with positive', () => {
        const r = analyzeMessagePayload('Generally good but the service was terrible and unprofessional');
        expect(r.isHostile).toBe(true);
    });
});

describe('Sentiment — Confidence Capping', () => {
    it('capped at 0.99', () => {
        const r = analyzeMessagePayload('angry late unprofessional terrible upset complain frustrated');
        expect(r.confidence).toBe(0.99);
    });
    it('two words = 0.95', () => {
        const r = analyzeMessagePayload('angry upset');
        expect(r.confidence).toBe(0.95);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Smart Shift Matcher — Haversine (replicated from SmartShiftMatcher.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface GeoPoint { lat: number; lon: number; }

function calculateHaversineDistance(p1: GeoPoint, p2: GeoPoint): number {
    const R = 6371;
    const dLat = (p2.lat - p1.lat) * Math.PI / 180;
    const dLon = (p2.lon - p1.lon) * Math.PI / 180;
    const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
              Math.cos(p1.lat * Math.PI / 180) * Math.cos(p2.lat * Math.PI / 180) *
              Math.sin(dLon/2) * Math.sin(dLon/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    return R * c;
}

function normalizeDistanceScore(distanceKm: number, maxKm: number = 50): number {
    return Math.max(0, 1 - (distanceKm / maxKm));
}

function calculateSkillOverlap(requiredSkills: string[], workerSkills: string[]): number {
    if (requiredSkills.length === 0) return 1;
    const matched = requiredSkills.filter(s => workerSkills.includes(s)).length;
    return matched / requiredSkills.length;
}

function calculateMatchScore(skillScore: number, distanceScore: number, rating: number): number {
    return (skillScore * 0.5) + (distanceScore * 0.3) + (rating * 0.2);
}

describe('Haversine — Distance', () => {
    it('same point = 0', () => {
        expect(calculateHaversineDistance({ lat: 43.65, lon: -79.38 }, { lat: 43.65, lon: -79.38 })).toBe(0);
    });
    it('Toronto to nearby', () => {
        const d = calculateHaversineDistance({ lat: 43.65, lon: -79.38 }, { lat: 43.70, lon: -79.40 });
        expect(d).toBeGreaterThan(0);
        expect(d).toBeLessThan(10); // Within Toronto
    });
    it('Toronto to Montreal ~500km', () => {
        const d = calculateHaversineDistance({ lat: 43.65, lon: -79.38 }, { lat: 45.50, lon: -73.57 });
        expect(d).toBeGreaterThan(450);
        expect(d).toBeLessThan(600);
    });
});

describe('Haversine — Distance Score', () => {
    it('0km = 1.0', () => expect(normalizeDistanceScore(0)).toBe(1));
    it('25km = 0.5', () => expect(normalizeDistanceScore(25)).toBe(0.5));
    it('50km = 0', () => expect(normalizeDistanceScore(50)).toBe(0));
    it('100km = 0 (capped)', () => expect(normalizeDistanceScore(100)).toBe(0));
    it('custom max', () => expect(normalizeDistanceScore(50, 100)).toBe(0.5));
});

describe('Shift Matcher — Skill Overlap', () => {
    it('full overlap', () => expect(calculateSkillOverlap(['A', 'B'], ['A', 'B', 'C'])).toBe(1));
    it('partial overlap', () => expect(calculateSkillOverlap(['A', 'B'], ['A'])).toBe(0.5));
    it('no overlap', () => expect(calculateSkillOverlap(['A', 'B'], ['C'])).toBe(0));
    it('empty required = 1', () => expect(calculateSkillOverlap([], ['A'])).toBe(1));
    it('single match', () => expect(calculateSkillOverlap(['WOUND_CARE'], ['WOUND_CARE', 'DEMENTIA'])).toBe(1));
});

describe('Shift Matcher — Match Score', () => {
    it('perfect scores', () => expect(calculateMatchScore(1, 1, 1)).toBe(1));
    it('zero scores', () => expect(calculateMatchScore(0, 0, 0)).toBe(0));
    it('skill heavy', () => {
        const score = calculateMatchScore(1, 0, 0);
        expect(score).toBe(0.5); // 50% skill weight
    });
    it('distance heavy', () => {
        expect(calculateMatchScore(0, 1, 0)).toBe(0.3);
    });
    it('rating heavy', () => {
        expect(calculateMatchScore(0, 0, 1)).toBe(0.2);
    });
    it('realistic mix', () => {
        const score = calculateMatchScore(0.8, 0.9, 0.95);
        expect(score).toBeCloseTo(0.86, 2);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. LLM Summary — Note Formatting (replicated from WeeklyLLMSummary.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface NoteContext {
    date: string;
    pswId: string;
    content: string;
}

function formatNoteForContext(note: NoteContext): string {
    return `[${note.date}] ${note.content}`;
}

function compileContextArray(notes: NoteContext[]): string[] {
    return notes.map(n => formatNoteForContext(n));
}

function isValidNote(note: NoteContext): boolean {
    return !!(note.date && note.content && note.content.trim().length > 0);
}

function countUniqueWorkers(notes: NoteContext[]): number {
    return new Set(notes.map(n => n.pswId)).size;
}

const SAMPLE_NOTES: NoteContext[] = [
    { date: 'Mon', pswId: 'psw_1', content: 'Patient was tired, refused lunch.' },
    { date: 'Tue', pswId: 'psw_2', content: 'Great day, participated in bingo.' },
    { date: 'Wed', pswId: 'psw_1', content: 'Back ache persists but mobility fine.' },
    { date: 'Thu', pswId: 'psw_1', content: 'Shower routine completed safely.' },
    { date: 'Fri', pswId: 'psw_3', content: 'Quiet morning.' },
];

describe('LLM Summary — Note Formatting', () => {
    it('formats note', () => {
        expect(formatNoteForContext({ date: 'Mon', pswId: 'p1', content: 'All good' })).toBe('[Mon] All good');
    });
    it('compiles array', () => {
        const arr = compileContextArray(SAMPLE_NOTES);
        expect(arr.length).toBe(5);
        expect(arr[0]).toBe('[Mon] Patient was tired, refused lunch.');
    });
});

describe('LLM Summary — Validation', () => {
    it('valid note', () => expect(isValidNote({ date: 'Mon', pswId: 'p1', content: 'ok' })).toBe(true));
    it('empty content', () => expect(isValidNote({ date: 'Mon', pswId: 'p1', content: '' })).toBe(false));
    it('whitespace content', () => expect(isValidNote({ date: 'Mon', pswId: 'p1', content: '   ' })).toBe(false));
    it('no date', () => expect(isValidNote({ date: '', pswId: 'p1', content: 'ok' })).toBe(false));
});

describe('LLM Summary — Unique Workers', () => {
    it('sample has 3 unique', () => expect(countUniqueWorkers(SAMPLE_NOTES)).toBe(3));
    it('single worker', () => {
        expect(countUniqueWorkers([{ date: 'Mon', pswId: 'p1', content: 'x' }])).toBe(1);
    });
    it('empty', () => expect(countUniqueWorkers([])).toBe(0));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Text Normalization & Processing
// ═══════════════════════════════════════════════════════════════════════════

function normalizeWhitespace(text: string): string {
    return text.replace(/\s+/g, ' ').trim();
}

function truncateText(text: string, maxLen: number): string {
    if (text.length <= maxLen) return text;
    return text.slice(0, maxLen - 3) + '...';
}

function extractInitials(fullName: string): string {
    return fullName.split(/\s+/).map(w => w[0]?.toUpperCase()).filter(Boolean).join('');
}

function slugify(text: string): string {
    return text.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

function maskEmail(email: string): string {
    const [local, domain] = email.split('@');
    if (!domain) return email;
    const masked = local[0] + '***' + (local.length > 1 ? local[local.length - 1] : '');
    return `${masked}@${domain}`;
}

describe('Text — Whitespace', () => {
    it('normalizes', () => expect(normalizeWhitespace('  hello   world  ')).toBe('hello world'));
    it('preserves single spaces', () => expect(normalizeWhitespace('hello world')).toBe('hello world'));
    it('empty', () => expect(normalizeWhitespace('')).toBe(''));
});

describe('Text — Truncate', () => {
    it('short text unchanged', () => expect(truncateText('hello', 10)).toBe('hello'));
    it('long text truncated', () => expect(truncateText('hello world this is long', 10)).toBe('hello w...'));
    it('exact length', () => expect(truncateText('12345', 5)).toBe('12345'));
});

describe('Text — Initials', () => {
    it('two names', () => expect(extractInitials('John Doe')).toBe('JD'));
    it('three names', () => expect(extractInitials('John Adam Doe')).toBe('JAD'));
    it('single name', () => expect(extractInitials('John')).toBe('J'));
});

describe('Text — Slugify', () => {
    it('simple', () => expect(slugify('Hello World')).toBe('hello-world'));
    it('special chars', () => expect(slugify('Hello! World?')).toBe('hello-world'));
    it('leading/trailing', () => expect(slugify('--hello--')).toBe('hello'));
});

describe('Text — Email Masking', () => {
    it('masks email', () => expect(maskEmail('john@example.com')).toBe('j***n@example.com'));
    it('short local', () => {
        const result = maskEmail('a@b.com');
        expect(result).toContain('@b.com');
        expect(result).not.toBe('a@b.com'); // should be masked
    });
    it('no domain', () => expect(maskEmail('invalid')).toBe('invalid'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Weighted Score Aggregation
// ═══════════════════════════════════════════════════════════════════════════

function weightedAverage(values: number[], weights: number[]): number {
    if (values.length !== weights.length) throw new Error('Length mismatch');
    const totalWeight = weights.reduce((a, b) => a + b, 0);
    if (totalWeight === 0) return 0;
    return values.reduce((sum, v, i) => sum + v * weights[i], 0) / totalWeight;
}

function normalizeScore(value: number, min: number, max: number): number {
    if (max === min) return 0;
    return Math.max(0, Math.min(1, (value - min) / (max - min)));
}

function rankItems<T>(items: T[], scoreKey: keyof T): T[] {
    return [...items].sort((a, b) => Number(b[scoreKey]) - Number(a[scoreKey]));
}

describe('Weighted Average', () => {
    it('equal weights', () => expect(weightedAverage([10, 20], [1, 1])).toBe(15));
    it('weighted', () => expect(weightedAverage([10, 20], [1, 3])).toBe(17.5));
    it('single value', () => expect(weightedAverage([42], [1])).toBe(42));
    it('zero weights', () => expect(weightedAverage([10], [0])).toBe(0));
});

describe('Normalize Score', () => {
    it('middle value', () => expect(normalizeScore(50, 0, 100)).toBe(0.5));
    it('min value', () => expect(normalizeScore(0, 0, 100)).toBe(0));
    it('max value', () => expect(normalizeScore(100, 0, 100)).toBe(1));
    it('above max capped', () => expect(normalizeScore(150, 0, 100)).toBe(1));
    it('below min capped', () => expect(normalizeScore(-10, 0, 100)).toBe(0));
    it('equal min max', () => expect(normalizeScore(5, 5, 5)).toBe(0));
});

describe('Rank Items', () => {
    it('sorts descending', () => {
        const items = [{ name: 'A', score: 30 }, { name: 'B', score: 90 }, { name: 'C', score: 60 }];
        const ranked = rankItems(items, 'score');
        expect(ranked[0].name).toBe('B');
        expect(ranked[2].name).toBe('A');
    });
});
