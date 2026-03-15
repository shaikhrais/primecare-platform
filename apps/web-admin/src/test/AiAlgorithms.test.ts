/**
 * AI Algorithm Deep Tests
 *
 * Self-contained replicas of logic from:
 * - FallRiskAlgorithm.ts: Risk decay scoring, ADL filtering
 * - SmartShiftMatcher.ts: Haversine distance, weighted scoring
 * - SentimentAnalyzer.ts: Keyword-based hostile detection
 * - GhostDispatcher.ts: Trainee response evaluation
 * - AlexaCareSkill.ts: Voice intent routing
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Fall Risk Algorithm (replicated from FallRiskAlgorithm.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface ClinicalADL {
    id: string;
    type: 'MOBILITY' | 'HYGIENE' | 'NUTRITION';
    status: 'IN_PROGRESS' | 'COMPLETED' | 'STRUGGLING' | 'FAILED';
    timestamp: string;
}

function calculateRiskDecay(adls: ClinicalADL[]): number {
    const mobilityTasks = adls.filter(a => a.type === 'MOBILITY');
    if (mobilityTasks.length === 0) return 0.0;
    let riskScore = 0.0;
    mobilityTasks.forEach(task => {
        if (task.status === 'STRUGGLING') riskScore += 0.2;
        if (task.status === 'FAILED') riskScore += 0.35;
    });
    return Math.min(riskScore, 1.0);
}

describe('Fall Risk Algorithm — calculateRiskDecay', () => {
    it('returns 0 for no ADLs', () => {
        expect(calculateRiskDecay([])).toBe(0.0);
    });

    it('returns 0 for no mobility tasks', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'HYGIENE', status: 'COMPLETED', timestamp: '2026-01-01' },
            { id: '2', type: 'NUTRITION', status: 'COMPLETED', timestamp: '2026-01-02' },
        ];
        expect(calculateRiskDecay(adls)).toBe(0.0);
    });

    it('returns 0 for all completed mobility', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'COMPLETED', timestamp: '2026-01-01' },
            { id: '2', type: 'MOBILITY', status: 'COMPLETED', timestamp: '2026-01-02' },
        ];
        expect(calculateRiskDecay(adls)).toBe(0.0);
    });

    it('scores 0.2 for one STRUGGLING', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-01' },
        ];
        expect(calculateRiskDecay(adls)).toBeCloseTo(0.2);
    });

    it('scores 0.35 for one FAILED', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'FAILED', timestamp: '2026-01-01' },
        ];
        expect(calculateRiskDecay(adls)).toBeCloseTo(0.35);
    });

    it('scores 0.4 for two STRUGGLING', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-01' },
            { id: '2', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-02' },
        ];
        expect(calculateRiskDecay(adls)).toBeCloseTo(0.4);
    });

    it('caps at 1.0 for extreme risk', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'FAILED', timestamp: '2026-01-01' },
            { id: '2', type: 'MOBILITY', status: 'FAILED', timestamp: '2026-01-02' },
            { id: '3', type: 'MOBILITY', status: 'FAILED', timestamp: '2026-01-03' },
        ];
        expect(calculateRiskDecay(adls)).toBe(1.0);
    });

    it('mixed STRUGGLING and FAILED', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-01' },
            { id: '2', type: 'MOBILITY', status: 'FAILED', timestamp: '2026-01-02' },
        ];
        expect(calculateRiskDecay(adls)).toBeCloseTo(0.55);
    });

    it('ignores non-mobility tasks in scoring', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-01' },
            { id: '2', type: 'HYGIENE', status: 'FAILED', timestamp: '2026-01-02' },
        ];
        expect(calculateRiskDecay(adls)).toBeCloseTo(0.2);
    });

    it('isAtRisk threshold at 0.8', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-01' },
            { id: '2', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-02' },
            { id: '3', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-03' },
            { id: '4', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-04' },
        ];
        const score = calculateRiskDecay(adls);
        expect(score >= 0.8).toBe(true);
    });

    it('below threshold for moderate risk', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'STRUGGLING', timestamp: '2026-01-01' },
            { id: '2', type: 'MOBILITY', status: 'COMPLETED', timestamp: '2026-01-02' },
        ];
        const score = calculateRiskDecay(adls);
        expect(score < 0.8).toBe(true);
    });

    it('IN_PROGRESS status adds nothing', () => {
        const adls: ClinicalADL[] = [
            { id: '1', type: 'MOBILITY', status: 'IN_PROGRESS', timestamp: '2026-01-01' },
        ];
        expect(calculateRiskDecay(adls)).toBe(0.0);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Haversine Distance (replicated from SmartShiftMatcher.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface GeoPoint { lat: number; lon: number; }

function calculateDistance(p1: GeoPoint, p2: GeoPoint): number {
    const R = 6371;
    const dLat = (p2.lat - p1.lat) * Math.PI / 180;
    const dLon = (p2.lon - p1.lon) * Math.PI / 180;
    const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
              Math.cos(p1.lat * Math.PI / 180) * Math.cos(p2.lat * Math.PI / 180) *
              Math.sin(dLon/2) * Math.sin(dLon/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    return R * c;
}

describe('Haversine Distance Calculation', () => {
    it('same point = 0 km', () => {
        expect(calculateDistance({ lat: 43.65, lon: -79.38 }, { lat: 43.65, lon: -79.38 })).toBeCloseTo(0, 1);
    });

    it('Toronto to New York ~550km', () => {
        const d = calculateDistance({ lat: 43.65, lon: -79.38 }, { lat: 40.71, lon: -74.01 });
        expect(d).toBeGreaterThan(500);
        expect(d).toBeLessThan(600);
    });

    it('equator to north pole ~10,000km', () => {
        const d = calculateDistance({ lat: 0, lon: 0 }, { lat: 90, lon: 0 });
        expect(d).toBeGreaterThan(9000);
        expect(d).toBeLessThan(11000);
    });

    it('same latitude, different longitude', () => {
        const d = calculateDistance({ lat: 43.65, lon: -79.38 }, { lat: 43.65, lon: -79.40 });
        expect(d).toBeGreaterThan(0);
        expect(d).toBeLessThan(5);
    });

    it('short distance within a city', () => {
        const d = calculateDistance({ lat: 43.65, lon: -79.38 }, { lat: 43.66, lon: -79.39 });
        expect(d).toBeGreaterThan(0);
        expect(d).toBeLessThan(5);
    });

    it('antipodal points ~20,000km', () => {
        const d = calculateDistance({ lat: 0, lon: 0 }, { lat: 0, lon: 180 });
        expect(d).toBeGreaterThan(19000);
        expect(d).toBeLessThan(21000);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Shift Match Scoring (replicated from SmartShiftMatcher.ts)
// ═══════════════════════════════════════════════════════════════════════════

function computeMatchScore(distanceKm: number, matchedSkills: number, totalSkills: number, complianceRating: number): number {
    const distanceScore = Math.max(0, 1 - (distanceKm / 50));
    const skillScore = totalSkills > 0 ? (matchedSkills / totalSkills) : 1;
    return (skillScore * 0.5) + (distanceScore * 0.3) + (complianceRating * 0.2);
}

describe('Shift Match Scoring', () => {
    it('perfect match: all skills, 0 km, 1.0 rating', () => {
        expect(computeMatchScore(0, 2, 2, 1.0)).toBeCloseTo(1.0);
    });

    it('no skills, 0 km, 1.0 rating = 0.5', () => {
        expect(computeMatchScore(0, 0, 2, 1.0)).toBeCloseTo(0.5);
    });

    it('all skills, 50 km away, 1.0 rating = 0.7', () => {
        expect(computeMatchScore(50, 2, 2, 1.0)).toBeCloseTo(0.7);
    });

    it('distance beyond 50km pins to 0 distance score', () => {
        expect(computeMatchScore(100, 2, 2, 1.0)).toBeCloseTo(0.7);
    });

    it('half skills = 0.25 skill score contribution', () => {
        expect(computeMatchScore(0, 1, 2, 1.0)).toBeCloseTo(0.75);
    });

    it('no required skills = 1.0 skill score', () => {
        expect(computeMatchScore(0, 0, 0, 1.0)).toBeCloseTo(1.0);
    });

    it('low compliance rating reduces score', () => {
        expect(computeMatchScore(0, 2, 2, 0.5)).toBeCloseTo(0.9);
    });

    it('zero compliance', () => {
        expect(computeMatchScore(0, 2, 2, 0.0)).toBeCloseTo(0.8);
    });

    it('mid-range everything', () => {
        const score = computeMatchScore(25, 1, 2, 0.75);
        expect(score).toBeGreaterThan(0.3);
        expect(score).toBeLessThan(0.7);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Sentiment Analyzer (replicated from SentimentAnalyzer.ts)
// ═══════════════════════════════════════════════════════════════════════════

const negativeKeywords = ['angry', 'late', 'unprofessional', 'terrible', 'upset', 'complain', 'frustrated'];

function analyzeMessagePayload(text: string): { isHostile: boolean; confidence: number } {
    if (!text) return { isHostile: false, confidence: 0 };
    const lowerText = text.toLowerCase();
    const words = lowerText.split(/\s+/);
    let hostileMatches = 0;
    words.forEach(word => {
        if (negativeKeywords.includes(word)) hostileMatches++;
    });
    const isHostile = hostileMatches >= 2;
    const confidence = isHostile ? 0.85 + (hostileMatches * 0.05) : 0.1;
    return { isHostile, confidence: Math.min(confidence, 0.99) };
}

describe('Sentiment Analyzer', () => {
    it('empty text = not hostile', () => {
        expect(analyzeMessagePayload('').isHostile).toBe(false);
    });

    it('neutral text = not hostile', () => {
        const result = analyzeMessagePayload('The visit went well today');
        expect(result.isHostile).toBe(false);
        expect(result.confidence).toBe(0.1);
    });

    it('one negative keyword = not hostile', () => {
        expect(analyzeMessagePayload('I am angry').isHostile).toBe(false);
    });

    it('two negative keywords = hostile', () => {
        expect(analyzeMessagePayload('I am angry and upset').isHostile).toBe(true);
    });

    it('hostile confidence >= 0.85', () => {
        const result = analyzeMessagePayload('angry upset terrible');
        expect(result.isHostile).toBe(true);
        expect(result.confidence).toBeGreaterThanOrEqual(0.85);
    });

    it('confidence caps at 0.99', () => {
        const result = analyzeMessagePayload('angry late unprofessional terrible upset complain frustrated');
        expect(result.confidence).toBe(0.99);
    });

    it('case insensitive', () => {
        expect(analyzeMessagePayload('ANGRY and UPSET').isHostile).toBe(true);
    });

    it('mixed case', () => {
        expect(analyzeMessagePayload('Angry and Upset staff').isHostile).toBe(true);
    });

    it('null-like empty string', () => {
        expect(analyzeMessagePayload('').confidence).toBe(0);
    });

    it('exactly two = hostile with 0.95 confidence', () => {
        const result = analyzeMessagePayload('angry upset');
        expect(result.isHostile).toBe(true);
        expect(result.confidence).toBeCloseTo(0.95);
    });

    it('three negatives = 0.99 confidence', () => {
        const result = analyzeMessagePayload('angry upset late');
        expect(result.isHostile).toBe(true);
        expect(result.confidence).toBeCloseTo(0.99);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Ghost Dispatcher — Trainee Evaluation (replicated from GhostDispatcher.ts)
// ═══════════════════════════════════════════════════════════════════════════

function evaluateTraineeResponse(responseAction: string): { grade: string; feedback: string } {
    if (responseAction.includes('reassign') || responseAction.includes('call backup')) {
        return { grade: 'A', feedback: 'Excellent. You successfully identified the risk and prioritized covering the shift.' };
    }
    return { grade: 'C-', feedback: 'You need to proactively re-assign the shift before it becomes a missed visit violation.' };
}

describe('Ghost Dispatcher — Trainee Evaluation', () => {
    it('reassign action = A grade', () => {
        expect(evaluateTraineeResponse('I will reassign the shift').grade).toBe('A');
    });

    it('call backup action = A grade', () => {
        expect(evaluateTraineeResponse('Let me call backup').grade).toBe('A');
    });

    it('no action = C- grade', () => {
        expect(evaluateTraineeResponse('Okay I will wait').grade).toBe('C-');
    });

    it('unrelated action = C- grade', () => {
        expect(evaluateTraineeResponse('I sent an email to HR').grade).toBe('C-');
    });

    it('reassign included in longer text = A', () => {
        expect(evaluateTraineeResponse('I will try to reassign the shift and contact the client').grade).toBe('A');
    });

    it('A grade has positive feedback', () => {
        const result = evaluateTraineeResponse('reassign');
        expect(result.feedback).toContain('Excellent');
    });

    it('C- grade has corrective feedback', () => {
        const result = evaluateTraineeResponse('nothing');
        expect(result.feedback).toContain('proactively');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Alexa Voice Intent Routing (replicated from AlexaCareSkill.ts)
// ═══════════════════════════════════════════════════════════════════════════

function routeVoiceIntent(intentName: string): 'schedule' | 'unknown' {
    if (intentName === 'NextNurseVisitIntent') return 'schedule';
    return 'unknown';
}

function buildSSMLResponse(nurseName: string, role: string, arrivalTime: string): string {
    return `<speak>Your next visit is scheduled with ${nurseName}, your assigned ${role}. She will arrive ${arrivalTime}.</speak>`;
}

describe('Alexa Voice Intent Routing', () => {
    it('NextNurseVisitIntent routes to schedule', () => {
        expect(routeVoiceIntent('NextNurseVisitIntent')).toBe('schedule');
    });

    it('MedicationReminderIntent routes to unknown', () => {
        expect(routeVoiceIntent('MedicationReminderIntent')).toBe('unknown');
    });

    it('random intent = unknown', () => {
        expect(routeVoiceIntent('RandomIntent')).toBe('unknown');
    });

    it('SSML response includes nurse name', () => {
        expect(buildSSMLResponse('Sarah', 'RN', 'tomorrow')).toContain('Sarah');
    });

    it('SSML response includes speak tags', () => {
        expect(buildSSMLResponse('Sarah', 'RN', 'tomorrow')).toMatch(/^<speak>.*<\/speak>$/);
    });

    it('SSML response includes role', () => {
        expect(buildSSMLResponse('Sarah', 'RN', 'at 9 AM')).toContain('RN');
    });

    it('SSML response includes arrival time', () => {
        expect(buildSSMLResponse('Sarah', 'RN', 'tomorrow at 9:00 AM')).toContain('tomorrow at 9:00 AM');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Distance Score Normalization (replicated from SmartShiftMatcher.ts)
// ═══════════════════════════════════════════════════════════════════════════

function normalizeDistanceScore(distanceKm: number): number {
    return Math.max(0, 1 - (distanceKm / 50));
}

describe('Distance Score Normalization', () => {
    it('0 km = 1.0', () => {
        expect(normalizeDistanceScore(0)).toBe(1.0);
    });

    it('25 km = 0.5', () => {
        expect(normalizeDistanceScore(25)).toBeCloseTo(0.5);
    });

    it('50 km = 0.0', () => {
        expect(normalizeDistanceScore(50)).toBeCloseTo(0.0);
    });

    it('100 km = 0.0 (clamped)', () => {
        expect(normalizeDistanceScore(100)).toBe(0.0);
    });

    it('10 km = 0.8', () => {
        expect(normalizeDistanceScore(10)).toBeCloseTo(0.8);
    });

    it('1 km = ~0.98', () => {
        expect(normalizeDistanceScore(1)).toBeCloseTo(0.98);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Skill Overlap Heuristic (replicated from SmartShiftMatcher.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateSkillScore(workerSkills: string[], requiredSkills: string[]): number {
    if (requiredSkills.length === 0) return 1;
    const matched = requiredSkills.filter(s => workerSkills.includes(s)).length;
    return matched / requiredSkills.length;
}

describe('Skill Overlap Heuristic', () => {
    it('all skills matched = 1.0', () => {
        expect(calculateSkillScore(['WOUND_CARE', 'DEMENTIA'], ['WOUND_CARE', 'DEMENTIA'])).toBe(1.0);
    });

    it('no skills matched = 0.0', () => {
        expect(calculateSkillScore(['PALLIATIVE'], ['WOUND_CARE', 'DEMENTIA'])).toBe(0.0);
    });

    it('half skills matched = 0.5', () => {
        expect(calculateSkillScore(['WOUND_CARE'], ['WOUND_CARE', 'DEMENTIA'])).toBe(0.5);
    });

    it('no required skills = 1.0', () => {
        expect(calculateSkillScore(['WOUND_CARE'], [])).toBe(1.0);
    });

    it('extra worker skills ignored', () => {
        expect(calculateSkillScore(['WOUND_CARE', 'DEMENTIA', 'EXTRA'], ['WOUND_CARE'])).toBe(1.0);
    });

    it('one of three matched', () => {
        expect(calculateSkillScore(['A'], ['A', 'B', 'C'])).toBeCloseTo(1/3);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Weekly LLM Summary — Context Formatting (replicated from WeeklyLLMSummary.ts)
// ═══════════════════════════════════════════════════════════════════════════

function formatNoteForContext(day: string, content: string): string {
    return `[${day}] ${content}`;
}

describe('Weekly LLM Context Formatting', () => {
    it('formats note correctly', () => {
        expect(formatNoteForContext('Mon', 'Patient was tired.')).toBe('[Mon] Patient was tired.');
    });

    it('includes day in brackets', () => {
        expect(formatNoteForContext('Tue', 'Great day.')).toMatch(/^\[Tue\]/);
    });

    it('preserves full content', () => {
        expect(formatNoteForContext('Wed', 'Back ache persists.')).toContain('Back ache persists.');
    });

    it('handles empty content', () => {
        expect(formatNoteForContext('Thu', '')).toBe('[Thu] ');
    });
});
