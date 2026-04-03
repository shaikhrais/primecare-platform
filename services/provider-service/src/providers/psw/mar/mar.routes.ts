import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import { requirePermission } from '../../../../_shared/middleware/rbac';
import { logAudit } from '../../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const createMarEntryRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Create Mar Entry',
    tags: ['PSW', 'Mar'],
    description: 'Record a Medication Administration Record (MAR) entry. Supports medication refusal escalations.',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        patientId: z.string().uuid(),
                        prescriptionId: z.string().uuid(),
                        status: z.enum(['administered', 'missed', 'refused']).default('administered'),
                        notes: z.string().optional()
                    })
                }
            }
        }
    },
    responses: {
        201: { description: 'MAR entry created successfully', content: { 'application/json': { schema: z.any() } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    }
});

r.openapi(createMarEntryRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user');
    const data = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;

    const entry = await prisma.mAR_Entry.create({
        data: {
            patientId: data.patientId,
            prescriptionId: data.prescriptionId,
            administerId: user.id,
            status: data.status,
            notes: data.notes
        }
    });

    // Feature 6: Medication Refusal Workflow
    if (data.status === 'refused') {
        const headRn = await prisma.user.findFirst({
            where: { tenantId: tenantId, role: 'rn' }
        });

        if (headRn) {
            await prisma.clinicalAssessment.create({
                data: {
                    clientId: data.patientId,
                    rnId: headRn.id,
                    tenantId: tenantId,
                    type: 'MEDICATION_REVIEW',
                    assessmentData: '{}',
                    recommendations: `URGENT: Patient refused medication for Prescription ${data.prescriptionId}. Note: ${data.notes || 'No note'}`
                }
            });
            console.log(`[Worker] Feature 6 Fired: Medication refusal logged. Mandatory ClinicalAssessment queued for RN.`);
        }
    }

    await logAudit(prisma, user.id, 'CREATE_MAR_ENTRY', 'MAR_ENTRY', entry.id, data);
    return c.json(entry, 201);
});

export default r;
