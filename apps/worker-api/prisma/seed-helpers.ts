/**
 * Seed Helpers — extracted from seed.ts
 * Helper functions + domain entity seeding logic
 */
import { PrismaClient } from '../generated/client';

const prisma = new PrismaClient();
export { prisma };

// ── Helper query functions ──
export async function getClientId() { const p = await prisma.clientProfile.findFirst(); return p ? p.id : ''; }
export async function getPswId() { const p = await prisma.pswProfile.findFirst(); return p ? p.id : ''; }
export async function getRnId() { const u = await prisma.user.findFirst({ where: { roles: 'rn' } }); return u ? u.id : ''; }
export async function getRnUserId() { const u = await prisma.user.findFirst({ where: { roles: 'rn' } }); return u ? u.id : ''; }
export async function getVisitId() {
    let v = await prisma.visit.findFirst();
    if (!v) {
        const client = await getClientId(); const psw = await getPswId(); const service = await prisma.service.findFirst();
        v = await prisma.visit.create({ data: { clientId: client, assignedPswId: psw, serviceId: service?.id || '', tenantId: service?.tenantId || '', requestedStartAt: new Date(), durationMinutes: 60, requiredSkills: '' } });
    }
    return v.id;
}

// ── Domain entity seeding ──
export async function seedDomainEntities(tenantAId: string) {
    console.log('🧬 Seeding complex domain domains (Telehealth, EVV, Care Plans)...');
    await prisma.telehealthSession.create({ data: { tenantId: tenantAId, patientId: await getClientId(), providerId: await getRnUserId(), startTime: new Date(Date.now() + 86400000), endTime: new Date(Date.now() + 90000000), status: 'scheduled', meetingLink: 'https://telehealth.primecare.ca/room/c5b2a-test-991' } });
    await prisma.eVVRecord.create({ data: { visitId: await getVisitId(), pswId: await getPswId(), checkType: 'check_in', verificationMethod: 'gps', status: 'exception', rawData: JSON.stringify({ accuracy_m: 852.1, computed_distance: 955.0 }), tenantId: tenantAId } });
    await prisma.carePlan.create({ data: { clientId: await getClientId(), tenantId: tenantAId, authorId: await getRnId(), diagnoses: 'Type II Diabetes (E11.9), Mild Cognitive Impairment (G31.84)', clinicalGoals: JSON.stringify([{ id: 1, text: 'Maintain fasting glucose < 7.0 mmol/L', status: 'active' }]), interventions: JSON.stringify([{ type: 'medication_assist', frequency: 'daily' }]), status: 'active', reviewDate: new Date(Date.now() + 30 * 86400000) } });
    await prisma.clinicalRecord.create({ data: { clientId: await getClientId(), tenantId: tenantAId, type: 'AllergyIntolerance', data: JSON.stringify({ resourceType: "AllergyIntolerance", clinicalStatus: { coding: [{ code: "active" }] }, code: { text: "Penicillin" }, reaction: [{ manifestation: [{ text: "Hives" }] }] }) } });
    const firstService = await prisma.service.findFirst({ where: { tenantId: tenantAId } });
    if (firstService) { await prisma.waitlistEntry.create({ data: { clientId: await getClientId(), tenantId: tenantAId, serviceId: firstService.id, priority: 85, status: 'active', requestedStartAt: new Date(Date.now() + 7 * 86400000), notes: 'Requires Mandarin speaking PSW. Urgent post-op care needed.' } }); }
}

// ── Logistics seeding ──
export async function seedLogistics(tenantAId: string) {
    console.log('🗓 Seeding global logistics arrays...');
    const service1 = await prisma.service.findFirst({ where: { slug: 'personal-care' } }) || { id: 'srv-1', tenantId: tenantAId };
    const baseDate = new Date();
    const visitsToCreate = [
        { clientId: await getClientId(), assignedPswId: await getPswId(), serviceId: service1.id, tenantId: tenantAId, status: 'completed', durationMinutes: 120, requestedStartAt: new Date(baseDate.getTime() - 86400000) },
        { clientId: await getClientId(), assignedPswId: await getPswId(), serviceId: service1.id, tenantId: tenantAId, status: 'in_progress', durationMinutes: 240, requestedStartAt: baseDate },
        { clientId: await getClientId(), assignedPswId: null, serviceId: service1.id, tenantId: tenantAId, status: 'requested', priority: 'high', crisisMode: true, durationMinutes: 60, requestedStartAt: new Date(baseDate.getTime() + 7200000) },
        { clientId: await getClientId(), assignedPswId: null, serviceId: service1.id, tenantId: tenantAId, status: 'requested', durationMinutes: 120, requestedStartAt: new Date(baseDate.getTime() + 86400000) },
    ];
    for (const vData of visitsToCreate) {
        const v = await prisma.visit.create({ data: { ...vData, requiredSkills: 'Dementia Care, Hoyer Lift' } });
        if (v.status === 'requested') {
            await prisma.shiftAssignment.createMany({ data: [
                { visitId: v.id, pswId: await getPswId(), tenantId: tenantAId, status: 'offered', score: 0.95 },
                { visitId: v.id, pswId: await getPswId(), tenantId: tenantAId, status: 'rejected', score: 0.82 }
            ] });
        }
    }
}

// ── Audit seeding ──
export async function seedAuditLogs(tenantHQId: string, tenantAId: string) {
    console.log('🛡 Seeding Global Security & Audit Timeline...');
    const hqAdmin = await prisma.user.findFirst({ where: { roles: 'admin' } });
    await prisma.auditLog.createMany({
        data: [
            { tenantId: tenantHQId, actorUserId: hqAdmin?.id, action: 'SYSTEM_HARDENING_PASSED', resourceType: 'Platform', metadataString: '{"sweep": "Auth JWT Rotation"}', ipAddress: '192.168.1.10' },
            { tenantId: tenantAId, actorUserId: await getRnId(), action: 'CARE_PLAN_SIGNED', resourceType: 'CarePlan', ipAddress: '10.0.0.45' },
            { tenantId: tenantAId, actorUserId: await getPswId(), action: 'VISIT_CLOCK_IN', resourceType: 'VisitCheckEvent', ipAddress: '172.68.90.10' },
            { tenantId: tenantAId, actorUserId: hqAdmin?.id, action: 'FIREWALL_RULE_UPDATED', resourceType: 'Network', metadataString: '{"policy": "Block Russian IPs"}', ipAddress: '192.168.1.10' },
            { tenantId: tenantHQId, actorUserId: null, action: 'DATABASE_BACKUP_COMPLETED', resourceType: 'Infrastructure', ipAddress: '127.0.0.1' }
        ]
    });
}
