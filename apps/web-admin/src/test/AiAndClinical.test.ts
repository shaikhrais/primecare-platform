/**
 * AI Algorithms & Location Auth Tests — Phase 23
 *
 * Self-contained replicas of logic from:
 * - FallRiskAlgorithm.ts: mobility task risk scoring, threshold-based alerts
 * - SentimentAnalyzer.ts: NLP hostile message detection with keyword heuristics
 * - SmartShiftMatcher.ts: Haversine distance, skill overlap, weighted scoring
 * - LocationGatedAuth.ts: IP-based role gating for sensitive operations
 * - Additional: date range helpers, time slot scheduling, clinical data modeling
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Fall Risk Algorithm (replicated from FallRiskAlgorithm.ts)
// ═══════════════════════════════════════════════════════════════════════════

type ADLStatus = 'COMPLETED' | 'STRUGGLING' | 'FAILED' | 'IN_PROGRESS';
type ADLType = 'MOBILITY' | 'HYGIENE' | 'NUTRITION';

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

function isAtRisk(score: number): boolean {
    return score >= 0.8;
}

describe('Fall Risk — Mobility Filtering', () => {
    const sample: ClinicalADL[] = [
        { id: '1', type: 'MOBILITY', status: 'COMPLETED', timestamp: '2026-03-01' },
        { id: '2', type: 'HYGIENE', status: 'COMPLETED', timestamp: '2026-03-02' },
        { id: '3', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-03-03' },
        { id: '4', type: 'NUTRITION', status: 'COMPLETED', timestamp: '2026-03-04' },
    ];
    it('extracts only MOBILITY', () => expect(filterMobilityTasks(sample).length).toBe(2));
    it('all are MOBILITY', () => {
        filterMobilityTasks(sample).forEach(t => expect(t.type).toBe('MOBILITY'));
    });
    it('empty array', () => expect(filterMobilityTasks([]).length).toBe(0));
    it('no mobility', () => {
        expect(filterMobilityTasks([{ id: '1', type: 'HYGIENE', status: 'COMPLETED', timestamp: '' }]).length).toBe(0);
    });
});

describe('Fall Risk — Risk Decay Calculation', () => {
    it('all completed = 0', () => {
        expect(calculateRiskDecay([
            { id: '1', type: 'MOBILITY', status: 'COMPLETED', timestamp: '' },
            { id: '2', type: 'MOBILITY', status: 'COMPLETED', timestamp: '' },
        ])).toBe(0.0);
    });
    it('one struggling = 0.2', () => {
        expect(calculateRiskDecay([
            { id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '' },
        ])).toBe(0.2);
    });
    it('one failed = 0.35', () => {
        expect(calculateRiskDecay([
            { id: '1', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
        ])).toBe(0.35);
    });
    it('two struggling + one failed = 0.75', () => {
        expect(calculateRiskDecay([
            { id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '' },
            { id: '2', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '' },
            { id: '3', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
        ])).toBe(0.75);
    });
    it('caps at 1.0', () => {
        expect(calculateRiskDecay([
            { id: '1', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
            { id: '2', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
            { id: '3', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
            { id: '4', type: 'MOBILITY', status: 'FAILED', timestamp: '' },
        ])).toBe(1.0);
    });
    it('no mobility = 0', () => {
        expect(calculateRiskDecay([
            { id: '1', type: 'HYGIENE', status: 'FAILED', timestamp: '' },
        ])).toBe(0.0);
    });
    it('empty = 0', () => expect(calculateRiskDecay([])).toBe(0.0));
    it('in-progress ignored', () => {
        expect(calculateRiskDecay([
            { id: '1', type: 'MOBILITY', status: 'IN_PROGRESS', timestamp: '' },
        ])).toBe(0.0);
    });
});

describe('Fall Risk — Threshold', () => {
    it('0.8 is at risk', () => expect(isAtRisk(0.8)).toBe(true));
    it('0.9 is at risk', () => expect(isAtRisk(0.9)).toBe(true));
    it('1.0 is at risk', () => expect(isAtRisk(1.0)).toBe(true));
    it('0.79 is not at risk', () => expect(isAtRisk(0.79)).toBe(false));
    it('0 is not at risk', () => expect(isAtRisk(0)).toBe(false));
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

describe('Sentiment — Keyword Detection', () => {
    it('no negative = not hostile', () => {
        const r = analyzeMessagePayload('The caregiver was great today');
        expect(r.isHostile).toBe(false);
    });
    it('one negative = not hostile', () => {
        const r = analyzeMessagePayload('I am upset');
        expect(r.isHostile).toBe(false);
        expect(r.confidence).toBe(0.1);
    });
    it('two negatives = hostile', () => {
        const r = analyzeMessagePayload('I am angry and frustrated');
        expect(r.isHostile).toBe(true);
    });
    it('three negatives = hostile + higher confidence', () => {
        const r = analyzeMessagePayload('I am angry upset and frustrated');
        expect(r.isHostile).toBe(true);
        expect(r.confidence).toBeGreaterThan(0.95);
    });
    it('case insensitive', () => {
        const r = analyzeMessagePayload('ANGRY and FRUSTRATED');
        expect(r.isHostile).toBe(true);
    });
    it('empty text', () => {
        const r = analyzeMessagePayload('');
        expect(r.isHostile).toBe(false);
        expect(r.confidence).toBe(0);
    });
    it('confidence capped at 0.99', () => {
        const r = analyzeMessagePayload('angry late unprofessional terrible upset complain frustrated');
        expect(r.confidence).toBe(0.99);
    });
    it('non-matching words', () => {
        const r = analyzeMessagePayload('happy joyful wonderful');
        expect(r.isHostile).toBe(false);
    });
});

describe('Sentiment — Confidence Math', () => {
    it('2 matches: 0.85 + 0.10 = 0.95', () => {
        const r = analyzeMessagePayload('angry frustrated');
        expect(r.confidence).toBe(0.95);
    });
    it('3 matches: 0.85 + 0.15 = min(1.0, 0.99) = 0.99', () => {
        const r = analyzeMessagePayload('angry frustrated upset');
        expect(r.confidence).toBe(0.99);
    });
    it('non-hostile confidence = 0.1', () => {
        const r = analyzeMessagePayload('happy day');
        expect(r.confidence).toBe(0.1);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Smart Shift Matcher — Haversine & Scoring (replicated from SmartShiftMatcher.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface GeoPoint { lat: number; lon: number; }

function haversineDistance(p1: GeoPoint, p2: GeoPoint): number {
    const R = 6371;
    const dLat = (p2.lat - p1.lat) * Math.PI / 180;
    const dLon = (p2.lon - p1.lon) * Math.PI / 180;
    const a = Math.sin(dLat / 2) ** 2 +
        Math.cos(p1.lat * Math.PI / 180) * Math.cos(p2.lat * Math.PI / 180) *
        Math.sin(dLon / 2) ** 2;
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
}

function distanceScore(distanceKm: number): number {
    return Math.max(0, 1 - (distanceKm / 50));
}

function skillOverlapScore(required: string[], has: string[]): number {
    if (required.length === 0) return 1;
    const matched = required.filter(s => has.includes(s)).length;
    return matched / required.length;
}

function compositeMatchScore(skillScore: number, distScore: number, complianceRating: number): number {
    return (skillScore * 0.5) + (distScore * 0.3) + (complianceRating * 0.2);
}

describe('Haversine — Distance', () => {
    it('same point = 0', () => {
        expect(haversineDistance({ lat: 43.65, lon: -79.38 }, { lat: 43.65, lon: -79.38 })).toBeCloseTo(0, 5);
    });
    it('short distance (Toronto)', () => {
        const d = haversineDistance({ lat: 43.65, lon: -79.38 }, { lat: 43.70, lon: -79.40 });
        expect(d).toBeGreaterThan(0);
        expect(d).toBeLessThan(10); // should be ~5-6 km
    });
    it('medium distance (Toronto to Markham)', () => {
        const d = haversineDistance({ lat: 43.65, lon: -79.38 }, { lat: 43.85, lon: -79.30 });
        expect(d).toBeGreaterThan(15);
        expect(d).toBeLessThan(30);
    });
    it('long distance (Toronto to NYC)', () => {
        const d = haversineDistance({ lat: 43.65, lon: -79.38 }, { lat: 40.71, lon: -74.01 });
        expect(d).toBeGreaterThan(500);
        expect(d).toBeLessThan(600);
    });
});

describe('Distance Score — Normalization', () => {
    it('0 km = 1.0', () => expect(distanceScore(0)).toBe(1.0));
    it('25 km = 0.5', () => expect(distanceScore(25)).toBe(0.5));
    it('50 km = 0.0', () => expect(distanceScore(50)).toBe(0.0));
    it('100 km = 0.0 (clamped)', () => expect(distanceScore(100)).toBe(0.0));
    it('5 km = 0.9', () => expect(distanceScore(5)).toBe(0.9));
});

describe('Skill Overlap Score', () => {
    it('full match', () => expect(skillOverlapScore(['A', 'B'], ['A', 'B', 'C'])).toBe(1.0));
    it('partial match', () => expect(skillOverlapScore(['A', 'B'], ['A'])).toBe(0.5));
    it('no match', () => expect(skillOverlapScore(['A', 'B'], ['C'])).toBe(0.0));
    it('no required = 1.0', () => expect(skillOverlapScore([], ['A'])).toBe(1.0));
    it('single match', () => expect(skillOverlapScore(['A'], ['A'])).toBe(1.0));
});

describe('Composite Match Score', () => {
    it('perfect = 1.0', () => expect(compositeMatchScore(1.0, 1.0, 1.0)).toBe(1.0));
    it('zeroes = 0.0', () => expect(compositeMatchScore(0, 0, 0)).toBe(0.0));
    it('weights correct: skill=0.5, dist=0.3, rating=0.2', () => {
        expect(compositeMatchScore(1.0, 0, 0)).toBe(0.5);
        expect(compositeMatchScore(0, 1.0, 0)).toBe(0.3);
        expect(compositeMatchScore(0, 0, 1.0)).toBe(0.2);
    });
    it('mixed', () => {
        const score = compositeMatchScore(0.8, 0.6, 0.9);
        expect(score).toBeCloseTo(0.8 * 0.5 + 0.6 * 0.3 + 0.9 * 0.2, 10);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Location-Gated Authentication (replicated from LocationGatedAuth.ts)
// ═══════════════════════════════════════════════════════════════════════════

const HQ_ALLOWED_IPS = ['192.168.1.50', '203.0.113.42', '10.0.0.0/24'];
type AuthRole = 'PSW' | 'RN' | 'COORDINATOR' | 'MANAGER' | 'ADMIN' | 'FINANCE';

function isFieldRole(role: AuthRole): boolean {
    return ['PSW', 'RN', 'COORDINATOR', 'MANAGER'].includes(role);
}

function isIpAuthorized(ip: string): boolean {
    return HQ_ALLOWED_IPS.includes(ip);
}

function enforceLocationPolicy(role: AuthRole, ip: string): boolean {
    if (isFieldRole(role)) return true;
    return isIpAuthorized(ip);
}

describe('Location Auth — Field Roles Bypass', () => {
    it('PSW always allowed', () => expect(enforceLocationPolicy('PSW', '1.2.3.4')).toBe(true));
    it('RN always allowed', () => expect(enforceLocationPolicy('RN', '8.8.8.8')).toBe(true));
    it('COORDINATOR always allowed', () => expect(enforceLocationPolicy('COORDINATOR', '0.0.0.0')).toBe(true));
    it('MANAGER always allowed', () => expect(enforceLocationPolicy('MANAGER', '10.10.10.10')).toBe(true));
});

describe('Location Auth — Sensitive Roles', () => {
    it('ADMIN from HQ allowed', () => expect(enforceLocationPolicy('ADMIN', '192.168.1.50')).toBe(true));
    it('ADMIN from unknown denied', () => expect(enforceLocationPolicy('ADMIN', '1.2.3.4')).toBe(false));
    it('FINANCE from HQ allowed', () => expect(enforceLocationPolicy('FINANCE', '203.0.113.42')).toBe(true));
    it('FINANCE from unknown denied', () => expect(enforceLocationPolicy('FINANCE', '8.8.8.8')).toBe(false));
});

describe('Location Auth — IP Check', () => {
    it('exact match 1', () => expect(isIpAuthorized('192.168.1.50')).toBe(true));
    it('exact match 2', () => expect(isIpAuthorized('203.0.113.42')).toBe(true));
    it('CIDR block string', () => expect(isIpAuthorized('10.0.0.0/24')).toBe(true));
    it('unknown IP', () => expect(isIpAuthorized('8.8.4.4')).toBe(false));
    it('empty string', () => expect(isIpAuthorized('')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Date Range & Scheduling Helpers
// ═══════════════════════════════════════════════════════════════════════════

function daysInRange(start: Date, end: Date): number {
    return Math.ceil((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24));
}

function isWeekday(date: Date): boolean {
    const day = date.getUTCDay();
    return day !== 0 && day !== 6;
}

function countWeekdays(start: Date, end: Date): number {
    let count = 0;
    const current = new Date(start);
    while (current <= end) {
        if (isWeekday(current)) count++;
        current.setUTCDate(current.getUTCDate() + 1);
    }
    return count;
}

function generateTimeSlots(startHour: number, endHour: number, intervalMinutes: number): string[] {
    const slots: string[] = [];
    for (let h = startHour; h < endHour; h++) {
        for (let m = 0; m < 60; m += intervalMinutes) {
            const hour = h.toString().padStart(2, '0');
            const min = m.toString().padStart(2, '0');
            slots.push(`${hour}:${min}`);
        }
    }
    return slots;
}

function isTimeSlotOverlap(s1Start: string, s1End: string, s2Start: string, s2End: string): boolean {
    return s1Start < s2End && s2Start < s1End;
}

describe('Date Range', () => {
    it('same day = 0', () => {
        const d = new Date('2026-01-15');
        expect(daysInRange(d, d)).toBe(0);
    });
    it('one day', () => {
        expect(daysInRange(new Date('2026-01-15'), new Date('2026-01-16'))).toBe(1);
    });
    it('one week', () => {
        expect(daysInRange(new Date('2026-01-01'), new Date('2026-01-08'))).toBe(7);
    });
    it('30 days', () => {
        expect(daysInRange(new Date('2026-01-01'), new Date('2026-01-31'))).toBe(30);
    });
});

describe('Weekday Check', () => {
    it('Monday is weekday', () => expect(isWeekday(new Date('2026-03-16'))).toBe(true)); // Monday
    it('Saturday is not', () => expect(isWeekday(new Date('2026-03-14'))).toBe(false)); // Saturday
    it('Sunday is not', () => expect(isWeekday(new Date('2026-03-15'))).toBe(false)); // Sunday
    it('Wednesday is weekday', () => expect(isWeekday(new Date('2026-03-18'))).toBe(true)); // Wednesday
});

describe('Count Weekdays', () => {
    it('full week start Monday = 5', () => {
        expect(countWeekdays(new Date('2026-03-16'), new Date('2026-03-20'))).toBe(5); // Mon-Fri
    });
    it('weekend only = 0', () => {
        expect(countWeekdays(new Date('2026-03-14'), new Date('2026-03-15'))).toBe(0); // Sat-Sun
    });
});

describe('Time Slots Generation', () => {
    it('9-10 with 30 min intervals', () => {
        expect(generateTimeSlots(9, 10, 30)).toEqual(['09:00', '09:30']);
    });
    it('9-12 with 60 min intervals', () => {
        expect(generateTimeSlots(9, 12, 60)).toEqual(['09:00', '10:00', '11:00']);
    });
    it('9-10 with 15 min intervals', () => {
        expect(generateTimeSlots(9, 10, 15)).toEqual(['09:00', '09:15', '09:30', '09:45']);
    });
    it('empty range', () => {
        expect(generateTimeSlots(9, 9, 30)).toEqual([]);
    });
});

describe('Time Slot Overlap', () => {
    it('overlap', () => expect(isTimeSlotOverlap('09:00', '10:00', '09:30', '10:30')).toBe(true));
    it('no overlap', () => expect(isTimeSlotOverlap('09:00', '10:00', '10:00', '11:00')).toBe(false));
    it('contained', () => expect(isTimeSlotOverlap('09:00', '12:00', '10:00', '11:00')).toBe(true));
    it('identical', () => expect(isTimeSlotOverlap('09:00', '10:00', '09:00', '10:00')).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Clinical Data Modeling
// ═══════════════════════════════════════════════════════════════════════════

type CareLevel = 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';

function assessCareLevel(riskScore: number, activeMedications: number, age: number): CareLevel {
    if (riskScore >= 0.8 || activeMedications > 10 || age >= 90) return 'CRITICAL';
    if (riskScore >= 0.5 || activeMedications > 5 || age >= 75) return 'HIGH';
    if (riskScore >= 0.3 || activeMedications > 2) return 'MEDIUM';
    return 'LOW';
}

function calculateBMI(weightKg: number, heightM: number): number {
    if (heightM <= 0) return 0;
    return +(weightKg / (heightM * heightM)).toFixed(1);
}

function classifyBMI(bmi: number): string {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
}

function bloodPressureCategory(systolic: number, diastolic: number): string {
    if (systolic < 120 && diastolic < 80) return 'Normal';
    if (systolic < 130 && diastolic < 80) return 'Elevated';
    if (systolic < 140 || diastolic < 90) return 'High Stage 1';
    if (systolic >= 140 || diastolic >= 90) return 'High Stage 2';
    return 'Unknown';
}

describe('Care Level Assessment', () => {
    it('CRITICAL: risk >= 0.8', () => expect(assessCareLevel(0.8, 0, 50)).toBe('CRITICAL'));
    it('CRITICAL: 10+ medications', () => expect(assessCareLevel(0, 11, 50)).toBe('CRITICAL'));
    it('CRITICAL: age >= 90', () => expect(assessCareLevel(0, 0, 90)).toBe('CRITICAL'));
    it('HIGH: risk >= 0.5', () => expect(assessCareLevel(0.5, 0, 50)).toBe('HIGH'));
    it('HIGH: 5+ medications', () => expect(assessCareLevel(0, 6, 50)).toBe('HIGH'));
    it('HIGH: age >= 75', () => expect(assessCareLevel(0, 0, 75)).toBe('HIGH'));
    it('MEDIUM: risk >= 0.3', () => expect(assessCareLevel(0.3, 0, 50)).toBe('MEDIUM'));
    it('MEDIUM: 2+ medications', () => expect(assessCareLevel(0, 3, 50)).toBe('MEDIUM'));
    it('LOW: all low', () => expect(assessCareLevel(0.1, 1, 40)).toBe('LOW'));
});

describe('BMI Calculation', () => {
    it('70kg / 1.75m', () => expect(calculateBMI(70, 1.75)).toBeCloseTo(22.9, 1));
    it('90kg / 1.80m', () => expect(calculateBMI(90, 1.80)).toBeCloseTo(27.8, 1));
    it('zero height', () => expect(calculateBMI(70, 0)).toBe(0));
    it('underweight example', () => expect(calculateBMI(45, 1.70)).toBeCloseTo(15.6, 1));
});

describe('BMI Classification', () => {
    it('underweight', () => expect(classifyBMI(17)).toBe('Underweight'));
    it('normal', () => expect(classifyBMI(22)).toBe('Normal'));
    it('overweight', () => expect(classifyBMI(27)).toBe('Overweight'));
    it('obese', () => expect(classifyBMI(35)).toBe('Obese'));
    it('borderline normal/overweight', () => expect(classifyBMI(24.9)).toBe('Normal'));
    it('borderline overweight/obese', () => expect(classifyBMI(30)).toBe('Obese'));
});

describe('Blood Pressure Classification', () => {
    it('normal', () => expect(bloodPressureCategory(110, 70)).toBe('Normal'));
    it('elevated', () => expect(bloodPressureCategory(125, 75)).toBe('Elevated'));
    it('high stage 1', () => expect(bloodPressureCategory(135, 85)).toBe('High Stage 1'));
    it('high stage 2', () => expect(bloodPressureCategory(145, 95)).toBe('High Stage 2'));
});
