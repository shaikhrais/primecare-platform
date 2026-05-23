// Governance - Category: service | Purpose: audit-chain.ts — Immutable Transaction Chain Security Implements SHA-256 cryptographic hash chaining for the SystemEv...
/**
 * audit-chain.ts — Immutable Transaction Chain Security
 * Implements SHA-256 cryptographic hash chaining for the SystemEvent model.
 * Each audit entry stores a hash of itself + the previous entry's hash, creating a tamper-evident chain.
 */

async function sha256(message: string): Promise<string> { const data = new TextEncoder().encode(message); const hashBuffer = await crypto.subtle.digest('SHA-256', data); return Array.from(new Uint8Array(hashBuffer)).map(b => b.toString(16).padStart(2, '0')).join(''); }
async function computeChecksum(previousChecksum: string, operation: string, modelName: string, entityId: string, payload: string, timestamp: string): Promise<string> { return sha256([previousChecksum, operation, modelName, entityId, payload, timestamp].join('|')); }

/** Create a tamper-proof audit entry in the SystemEvent chain. Fetches the latest checksum, computes the new hash, and appends. */
export async function createAuditEntry(prisma: any, data: { tenantId: string; operation: string; modelName: string; entityId?: string; payload?: any; previousData?: any; actorUserId?: string; deviceId?: string; ipAddress?: string; }) {
    const lastEvent = await prisma.systemEvent.findFirst({ where: { tenantId: data.tenantId }, orderBy: { createdAt: 'desc' }, select: { checksum: true } });
    const previousChecksum = lastEvent?.checksum || 'GENESIS';
    const payloadStr = data.payload ? JSON.stringify(data.payload) : '';
    const previousDataStr = data.previousData ? JSON.stringify(data.previousData) : null;
    const timestamp = new Date().toISOString();
    const checksum = await computeChecksum(previousChecksum, data.operation, data.modelName, data.entityId || '', payloadStr, timestamp);
    return prisma.systemEvent.create({ data: { tenantId: data.tenantId, operation: data.operation, modelName: data.modelName, entityId: data.entityId || null, payload: payloadStr || null, previousData: previousDataStr, actorUserId: data.actorUserId || null, deviceId: data.deviceId || null, ipAddress: data.ipAddress || null, checksum, previousChecksum } });
}

/** Verify the integrity of the audit chain for a given tenant. Walks the chain and recomputes each hash. */
export async function verifyChain(prisma: any, tenantId: string): Promise<{ valid: boolean; totalEntries: number; checkedEntries: number; brokenAt?: { id: string; position: number; expected: string; actual: string }; }> {
    const events = await prisma.systemEvent.findMany({ where: { tenantId }, orderBy: { createdAt: 'asc' }, select: { id: true, operation: true, modelName: true, entityId: true, payload: true, checksum: true, previousChecksum: true, createdAt: true } });
    if (events.length === 0) return { valid: true, totalEntries: 0, checkedEntries: 0 };
    let previousChecksum = 'GENESIS';
    for (let i = 0; i < events.length; i++) {
        const event = events[i];
        if (!event.checksum || event.checksum === '') { previousChecksum = event.checksum || ''; continue; }
        if (event.previousChecksum !== previousChecksum) return { valid: false, totalEntries: events.length, checkedEntries: i + 1, brokenAt: { id: event.id, position: i, expected: previousChecksum, actual: event.previousChecksum || '' } };
        const recomputed = await computeChecksum(event.previousChecksum, event.operation, event.modelName, event.entityId || '', event.payload || '', event.createdAt.toISOString());
        if (recomputed !== event.checksum) return { valid: false, totalEntries: events.length, checkedEntries: i + 1, brokenAt: { id: event.id, position: i, expected: recomputed, actual: event.checksum } };
        previousChecksum = event.checksum;
    }
    return { valid: true, totalEntries: events.length, checkedEntries: events.length };
}

/** Get the full audit trail for a specific entity in chronological order. */
export async function getEntityAuditTrail(prisma: any, modelName: string, entityId: string): Promise<any[]> {
    return prisma.systemEvent.findMany({ where: { modelName, entityId }, orderBy: { createdAt: 'asc' }, select: { id: true, operation: true, modelName: true, entityId: true, payload: true, previousData: true, checksum: true, actorUserId: true, ipAddress: true, createdAt: true } });
}
