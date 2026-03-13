/**
 * audit-chain.ts — Immutable Transaction Chain Security
 * 
 * Implements SHA-256 cryptographic hash chaining for the SystemEvent model.
 * Each audit entry stores a hash of itself + the previous entry's hash,
 * creating a tamper-evident chain. If any record is modified, the chain breaks.
 * 
 * Pattern: append-only ledger with cryptographic chaining (similar to blockchain)
 */

// SHA-256 using Web Crypto API (available in Cloudflare Workers)
async function sha256(message: string): Promise<string> {
    const encoder = new TextEncoder();
    const data = encoder.encode(message);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

/**
 * Compute the hash for an audit entry.
 * Hash = SHA-256(previousChecksum + operation + modelName + entityId + payload + timestamp)
 */
async function computeChecksum(
    previousChecksum: string,
    operation: string,
    modelName: string,
    entityId: string,
    payload: string,
    timestamp: string
): Promise<string> {
    const input = [previousChecksum, operation, modelName, entityId, payload, timestamp].join('|');
    return sha256(input);
}

/**
 * Create a tamper-proof audit entry in the SystemEvent chain.
 * Fetches the latest checksum, computes the new hash, and appends the entry.
 * 
 * @param prisma - Prisma client
 * @param data - Audit entry data
 * @returns The created SystemEvent with computed checksum
 */
export async function createAuditEntry(
    prisma: any,
    data: {
        tenantId: string;
        operation: string; // CREATE, UPDATE, DELETE, APPROVE, REJECT, CLOSE, BACKUP, PUBLISH
        modelName: string; // e.g. "ShiftAssignment", "Invoice", "Region"
        entityId?: string;
        payload?: any; // snapshot of the data
        previousData?: any; // previous state (for UPDATE/DELETE)
        actorUserId?: string;
        deviceId?: string;
        ipAddress?: string;
    }
) {
    // 1. Get the latest checksum from the chain for this tenant
    const lastEvent = await prisma.systemEvent.findFirst({
        where: { tenantId: data.tenantId },
        orderBy: { createdAt: 'desc' },
        select: { checksum: true },
    });

    const previousChecksum = lastEvent?.checksum || 'GENESIS'; // First entry in chain

    // 2. Serialize payload
    const payloadStr = data.payload ? JSON.stringify(data.payload) : '';
    const previousDataStr = data.previousData ? JSON.stringify(data.previousData) : null;
    const timestamp = new Date().toISOString();

    // 3. Compute SHA-256 hash
    const checksum = await computeChecksum(
        previousChecksum,
        data.operation,
        data.modelName,
        data.entityId || '',
        payloadStr,
        timestamp
    );

    // 4. Append to the immutable chain (no updatedAt — records never change)
    const event = await prisma.systemEvent.create({
        data: {
            tenantId: data.tenantId,
            operation: data.operation,
            modelName: data.modelName,
            entityId: data.entityId || null,
            payload: payloadStr || null,
            previousData: previousDataStr,
            actorUserId: data.actorUserId || null,
            deviceId: data.deviceId || null,
            ipAddress: data.ipAddress || null,
            checksum,
            previousChecksum,
        },
    });

    return event;
}

/**
 * Verify the integrity of the audit chain for a given tenant.
 * Walks the chain from oldest to newest and recomputes each hash.
 * If any hash doesn't match, the chain has been tampered with.
 * 
 * @param prisma - Prisma client  
 * @param tenantId - Tenant to verify
 * @returns Verification result with status and any broken links
 */
export async function verifyChain(
    prisma: any,
    tenantId: string
): Promise<{
    valid: boolean;
    totalEntries: number;
    checkedEntries: number;
    brokenAt?: { id: string; position: number; expected: string; actual: string };
}> {
    // Fetch all events in chronological order
    const events = await prisma.systemEvent.findMany({
        where: { tenantId },
        orderBy: { createdAt: 'asc' },
        select: {
            id: true,
            operation: true,
            modelName: true,
            entityId: true,
            payload: true,
            checksum: true,
            previousChecksum: true,
            createdAt: true,
        },
    });

    if (events.length === 0) {
        return { valid: true, totalEntries: 0, checkedEntries: 0 };
    }

    let previousChecksum = 'GENESIS';

    for (let i = 0; i < events.length; i++) {
        const event = events[i];

        // Skip events with empty checksums (pre-chain legacy data)
        if (!event.checksum || event.checksum === '') {
            previousChecksum = event.checksum || '';
            continue;
        }

        // Verify the previous checksum reference
        if (event.previousChecksum !== previousChecksum) {
            return {
                valid: false,
                totalEntries: events.length,
                checkedEntries: i + 1,
                brokenAt: {
                    id: event.id,
                    position: i,
                    expected: previousChecksum,
                    actual: event.previousChecksum || '',
                },
            };
        }

        // Recompute the hash and verify
        const recomputed = await computeChecksum(
            event.previousChecksum,
            event.operation,
            event.modelName,
            event.entityId || '',
            event.payload || '',
            event.createdAt.toISOString()
        );

        if (recomputed !== event.checksum) {
            return {
                valid: false,
                totalEntries: events.length,
                checkedEntries: i + 1,
                brokenAt: {
                    id: event.id,
                    position: i,
                    expected: recomputed,
                    actual: event.checksum,
                },
            };
        }

        previousChecksum = event.checksum;
    }

    return { valid: true, totalEntries: events.length, checkedEntries: events.length };
}

/**
 * Get the full audit trail for a specific entity.
 * Returns all chain entries related to this entity in chronological order.
 */
export async function getEntityAuditTrail(
    prisma: any,
    modelName: string,
    entityId: string
): Promise<any[]> {
    return prisma.systemEvent.findMany({
        where: { modelName, entityId },
        orderBy: { createdAt: 'asc' },
        select: {
            id: true,
            operation: true,
            modelName: true,
            entityId: true,
            payload: true,
            previousData: true,
            checksum: true,
            actorUserId: true,
            ipAddress: true,
            createdAt: true,
        },
    });
}
