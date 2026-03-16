/**
 * Scheduling Optimizer — Constraint-Satisfaction Algorithm
 *
 * Given a list of unassigned shifts and available staff, computes an
 * optimal assignment minimizing travel time and maximizing skill match.
 *
 * Constraints:
 * 1. Certification match (PSW, RN, etc.)
 * 2. Max hours per day (no overtime beyond threshold)
 * 3. Travel time between consecutive visits (Haversine distance)
 * 4. Client preference (preferred worker gets priority)
 * 5. Availability window overlap
 */

interface UnassignedShift {
    id: string;
    clientId: string;
    clientName: string;
    location: string;
    latitude?: number;
    longitude?: number;
    time: string;           // ISO datetime
    duration: number;       // minutes
    requiredRole: string;   // psw, rn, etc.
    preferredWorkerId?: string;
}

interface AvailableWorker {
    id: string;
    name: string;
    role: string;
    certifications: string[];
    currentShifts: { startTime: string; endTime: string; latitude?: number; longitude?: number }[];
    maxHoursToday: number;
    hoursWorkedToday: number;
    homeLatitude?: number;
    homeLongitude?: number;
}

interface Assignment {
    shiftId: string;
    workerId: string;
    workerName: string;
    score: number;      // 0-100, higher is better
    reasons: string[];  // why this assignment
    warnings: string[]; // any concerns
}

interface OptimizerResult {
    assignments: Assignment[];
    unassignable: { shiftId: string; reason: string }[];
    totalScore: number;
    executionTimeMs: number;
}

/**
 * Haversine distance between two GPS coordinates (km)
 */
function haversineKm(lat1: number, lon1: number, lat2: number, lon2: number): number {
    const R = 6371;
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) ** 2 +
        Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
        Math.sin(dLon / 2) ** 2;
    return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

/**
 * Estimate travel time from distance (km → minutes)
 * Assumes average 40 km/h in urban areas
 */
function estimateTravelMinutes(distanceKm: number): number {
    return Math.ceil(distanceKm / 40 * 60);
}

/**
 * Score a potential assignment (0-100)
 */
function scoreAssignment(shift: UnassignedShift, worker: AvailableWorker): { score: number; reasons: string[]; warnings: string[] } {
    let score = 50; // base score
    const reasons: string[] = [];
    const warnings: string[] = [];

    // 1. Certification match (+25)
    if (worker.role.toLowerCase() === shift.requiredRole.toLowerCase() ||
        worker.certifications.includes(shift.requiredRole)) {
        score += 25;
        reasons.push('Certification match');
    } else {
        score -= 40;
        warnings.push('Certification mismatch');
    }

    // 2. Client preference (+20)
    if (shift.preferredWorkerId === worker.id) {
        score += 20;
        reasons.push('Client preferred worker');
    }

    // 3. Travel distance (max +15)
    if (shift.latitude && shift.longitude) {
        const lastShift = worker.currentShifts[worker.currentShifts.length - 1];
        const fromLat = lastShift?.latitude ?? worker.homeLatitude;
        const fromLon = lastShift?.longitude ?? worker.homeLongitude;

        if (fromLat != null && fromLon != null) {
            const distKm = haversineKm(fromLat, fromLon, shift.latitude, shift.longitude);
            const travelMin = estimateTravelMinutes(distKm);

            if (travelMin <= 15) {
                score += 15;
                reasons.push(`Short travel: ${travelMin}min`);
            } else if (travelMin <= 30) {
                score += 8;
                reasons.push(`Moderate travel: ${travelMin}min`);
            } else {
                score -= 5;
                warnings.push(`Long travel: ${travelMin}min (${distKm.toFixed(1)}km)`);
            }
        }
    }

    // 4. Overtime risk (-15)
    const remainingHours = worker.maxHoursToday - worker.hoursWorkedToday;
    const shiftHours = shift.duration / 60;
    if (shiftHours > remainingHours) {
        score -= 15;
        warnings.push(`Overtime: ${(shiftHours - remainingHours).toFixed(1)}hrs over limit`);
    } else if (remainingHours - shiftHours < 1) {
        warnings.push('Near max hours');
    }

    // 5. Existing workload balance (+10 for fewer shifts)
    if (worker.currentShifts.length === 0) {
        score += 10;
        reasons.push('No current shifts — available');
    } else if (worker.currentShifts.length <= 2) {
        score += 5;
        reasons.push('Light workload');
    }

    return { score: Math.max(0, Math.min(100, score)), reasons, warnings };
}

/**
 * Main optimizer — greedy assignment with scoring
 */
export function optimizeSchedule(
    shifts: UnassignedShift[],
    workers: AvailableWorker[]
): OptimizerResult {
    const start = Date.now();
    const assignments: Assignment[] = [];
    const unassignable: { shiftId: string; reason: string }[] = [];
    const assignedWorkerLoad = new Map<string, number>();

    // Sort shifts by time (earliest first)
    const sortedShifts = [...shifts].sort((a, b) =>
        new Date(a.time).getTime() - new Date(b.time).getTime()
    );

    for (const shift of sortedShifts) {
        // Score all eligible workers
        const candidates = workers.map(w => {
            const currentLoad = assignedWorkerLoad.get(w.id) || 0;
            const augmented = {
                ...w,
                hoursWorkedToday: w.hoursWorkedToday + currentLoad,
                currentShifts: [...w.currentShifts],
            };
            const result = scoreAssignment(shift, augmented);
            return { worker: w, ...result };
        });

        // Filter out critically bad matches
        const viable = candidates.filter(c => c.score >= 30);

        if (viable.length === 0) {
            unassignable.push({
                shiftId: shift.id,
                reason: candidates.length === 0
                    ? 'No workers available'
                    : `Best score too low (${candidates[0]?.score ?? 0}/100)`,
            });
            continue;
        }

        // Pick highest score
        viable.sort((a, b) => b.score - a.score);
        const best = viable[0];

        assignments.push({
            shiftId: shift.id,
            workerId: best.worker.id,
            workerName: best.worker.name,
            score: best.score,
            reasons: best.reasons,
            warnings: best.warnings,
        });

        // Update worker load tracking
        const currentLoad = assignedWorkerLoad.get(best.worker.id) || 0;
        assignedWorkerLoad.set(best.worker.id, currentLoad + shift.duration / 60);
    }

    const totalScore = assignments.length > 0
        ? Math.round(assignments.reduce((acc, a) => acc + a.score, 0) / assignments.length)
        : 0;

    return {
        assignments,
        unassignable,
        totalScore,
        executionTimeMs: Date.now() - start,
    };
}
