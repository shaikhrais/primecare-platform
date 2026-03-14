/**
 * Clinical Route Definitions + Handlers
 * Extracted from clinical.routes.ts
 */
import { createRoute, z } from '@hono/zod-openapi';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

export const submitAssessmentRoute = createRoute({ ...ROUTE_METADATA.RN.CLINICAL_ASSESS, method: 'post', path: '/assessments', summary: 'Submit Assessment', tags: ['RN', 'Clinical'], middleware: [requirePermission('CARE_PLAN_UPDATE')], request: { body: { content: { 'application/json': { schema: z.object({ clientId: z.string(), type: z.string(), assessmentData: z.any(), score: z.number().optional(), recommendations: z.string().optional() }) } } } }, responses: { 201: { description: 'Assessment created successfully', content: { 'application/json': { schema: z.any() } } } } });
export const syncMedicationReconRoute = createRoute({ ...ROUTE_METADATA.RN.MEDICATION_RECON, method: 'post', path: '/recon', summary: 'Sync Medication Recon', tags: ['RN', 'Clinical'], middleware: [requirePermission('CARE_PLAN_UPDATE')], request: { body: { content: { 'application/json': { schema: z.object({ clientId: z.string(), reconData: z.any(), discrepancies: z.string().optional() }) } } } }, responses: { 201: { description: 'Medication reconciliation recorded', content: { 'application/json': { schema: z.any() } } } } });
export const recordSupervisionRoute = createRoute({ ...ROUTE_METADATA.RN.SUPERVISION_LOG, method: 'post', path: '/supervision', summary: 'Record Supervision', tags: ['RN', 'Clinical'], middleware: [requirePermission('PSW_SUPERVISE')], request: { body: { content: { 'application/json': { schema: z.object({ pswId: z.string(), competencies: z.any(), isSatisfactory: z.boolean(), feedback: z.string().optional() }) } } } }, responses: { 201: { description: 'Supervision log recorded', content: { 'application/json': { schema: z.any() } } } } });
export const dailyAuditSignOffRoute = createRoute({ ...ROUTE_METADATA.RN.DAILY_AUDIT_SIGN_OFF, method: 'post', path: '/sign-off', summary: 'Daily Audit Sign Off', tags: ['RN', 'Clinical'], middleware: [requirePermission('DAILY_ENTRY_REVIEW')], request: { body: { content: { 'application/json': { schema: z.object({ visitId: z.string().uuid(), clinicalComment: z.string().optional(), status: z.enum(['verified', 'flagged']).default('verified') }) } } } }, responses: { 201: { description: 'Clinical sign-off recorded', content: { 'application/json': { schema: z.any() } } } } });
export const listDailyAuditRoute = createRoute({ summary: 'List High-Risk Daily Entries', description: 'Retrieve a list of visit entries requiring professional RN sign-off.', tags: ['RN Clinical Audit'], method: 'get', path: '/audit/list', middleware: [requirePermission('DAILY_ENTRY_REVIEW')], responses: { 200: { description: 'List of audit entries', content: { 'application/json': { schema: z.array(z.any()) } } } } });
export const reconciliationPendingRoute = createRoute({ summary: 'List Pending Reconciliation Entries', description: 'Retrieve medication reconciliation entries pending RN review.', tags: ['RN Clinical Audit'], method: 'get', path: '/reconciliation/pending', middleware: [requirePermission('CARE_PLAN_UPDATE')], responses: { 200: { description: 'Pending reconciliation entries', content: { 'application/json': { schema: z.array(z.any()) } } } } });
export const reconciliationApproveRoute = createRoute({ summary: 'Approve Reconciliation Entry', description: 'RN approves a medication reconciliation entry.', tags: ['RN Clinical Audit'], method: 'post', path: '/reconciliation/{id}/approve', middleware: [requirePermission('CARE_PLAN_UPDATE')], request: { params: z.object({ id: z.string() }), body: { content: { 'application/json': { schema: z.object({ notes: z.string().optional() }) } } } }, responses: { 200: { description: 'Reconciliation approved', content: { 'application/json': { schema: z.object({ success: z.boolean() }) } } }, 404: { description: 'Not found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } } } });

export async function handleSubmitAssessment(c: any) { const prisma = c.get('prisma'); const body = c.req.valid('json'); const userId = c.get('jwtPayload').sub; const tenantId = c.get('jwtPayload').tenantId; const assessment = await prisma.clinicalAssessment.create({ data: { ...body, rnId: userId, tenantId } }); await logAudit(prisma, userId, 'SUBMIT_ASSESSMENT', 'CLIENT', body.clientId, body); return c.json(assessment, 201); }
export async function handleSyncMedicationRecon(c: any) { const prisma = c.get('prisma'); const body = c.req.valid('json'); const userId = c.get('jwtPayload').sub; const tenantId = c.get('jwtPayload').tenantId; const recon = await prisma.medicationRecon.create({ data: { ...body, rnId: userId, tenantId } }); await logAudit(prisma, userId, 'SYNC_MED_RECON', 'CLIENT', body.clientId, body); return c.json(recon, 201); }
export async function handleRecordSupervision(c: any) {
    const prisma = c.get('prisma'); const body = c.req.valid('json'); const userId = c.get('jwtPayload').sub; const tenantId = c.get('jwtPayload').tenantId;
    const log = await prisma.supervisionLog.create({ data: { ...body, rnId: userId, tenantId } });
    if (body.isSatisfactory === false) {
        const pswUser = await prisma.user.findFirst({ where: { pswProfile: { id: body.pswId } } });
        const gamificationProfile = pswUser ? await prisma.gamificationProfile.findUnique({ where: { userId: pswUser.id } }) : null;
        if (gamificationProfile && gamificationProfile.careCoins >= 50) {
            await prisma.gamificationProfile.update({ where: { id: gamificationProfile.id }, data: { careCoins: gamificationProfile.careCoins - 50 } });
            await prisma.auditLog.create({ data: { actorUserId: userId, action: 'CARE_COIN_PENALTY', resourceType: 'GAMIFICATION_PROFILE', resourceId: gamificationProfile.id, metadataString: JSON.stringify({ reason: 'Unsatisfactory performance marked in RN Supervision Log', amount: -50 }), tenantId } });
            console.log(`[Clinical] Feature 23 Fired: Deducted 50 CareCoins from PSW ${body.pswId} following negative supervision.`);
        }
    }
    await logAudit(prisma, userId, 'RECORD_SUPERVISION', 'PSW_PROFILE', body.pswId, body);
    return c.json(log, 201);
}
export async function handleDailyAuditSignOff(c: any) { const prisma = c.get('prisma'); const body = c.req.valid('json'); const userId = c.get('jwtPayload').sub; const tenantId = c.get('jwtPayload').tenantId; const signOff = await prisma.dailyAuditSignOff.create({ data: { visitId: body.visitId, rnId: userId, tenantId, clinicalComment: body.clinicalComment, status: body.status } }); await logAudit(prisma, userId, 'CLINICAL_SIGN_OFF', 'VISIT', body.visitId, body); return c.json(signOff, 201); }
export async function handleListDailyAudit(c: any) {
    const prisma = c.get('prisma'); const tenantId = c.get('jwtPayload').tenantId;
    const visits = await prisma.visit.findMany({ where: { tenantId, status: 'completed', dailyAuditSignOff: null }, include: { client: { select: { fullName: true } }, psw: { select: { fullName: true } }, DailyEntry: { orderBy: { createdAt: 'desc' }, take: 1 } }, orderBy: { requestedStartAt: 'desc' }, take: 50 });
    const entries = visits.map((v: any) => ({ id: v.id, visitId: v.id, visitTime: v.requestedStartAt, client: { fullName: v.client.fullName }, psw: { fullName: v.psw?.fullName || 'Unassigned' }, highlights: v.DailyEntry[0]?.noteText || 'No clinical notes provided.', verificationStatus: 'pending' }));
    return c.json(entries, 200);
}
export async function handleReconciliationPending(c: any) { const prisma = c.get('prisma'); return c.json(await prisma.medicationRecon.findMany({ where: { tenantId: c.get('jwtPayload').tenantId, status: 'pending' }, orderBy: { createdAt: 'desc' }, take: 50 }), 200); }
export async function handleReconciliationApprove(c: any) { const prisma = c.get('prisma'); const { id } = c.req.valid('param'); const userId = c.get('jwtPayload').sub; const body = c.req.valid('json'); try { await prisma.medicationRecon.update({ where: { id }, data: { status: 'completed', discrepancies: body.notes ? `Approved by RN: ${body.notes}` : 'Approved by RN' } }); await logAudit(prisma, userId, 'APPROVE_RECONCILIATION', 'MEDICATION_RECON', id, body); return c.json({ success: true }, 200); } catch { return c.json({ error: 'Entry not found' }, 404); } }
