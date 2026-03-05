import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';
import carePlanRoutes from '../carePlans/carePlans.routes';

const clinical = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Delegate care-plans
clinical.route('/care-plans', carePlanRoutes);

/**
 * RN Submit Clinical Assessment
 */
const submitAssessmentRoute = createRoute({
    ...ROUTE_METADATA.RN.CLINICAL_ASSESS,
    method: 'post',
    path: '/assessments',
    middleware: [requirePermission('CARE_PLAN_UPDATE')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(),
                        type: z.string(),
                        assessmentData: z.any(),
                        score: z.number().optional(),
                        recommendations: z.string().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        201: {
            description: 'Assessment created successfully',
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
        },
    },
});

/**
 * RN Sync Medication Reconciliation
 */
const syncMedicationReconRoute = createRoute({
    ...ROUTE_METADATA.RN.MEDICATION_RECON,
    method: 'post',
    path: '/recon',
    middleware: [requirePermission('CARE_PLAN_UPDATE')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(),
                        reconData: z.any(),
                        discrepancies: z.string().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        201: {
            description: 'Medication reconciliation recorded',
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
        },
    },
});

/**
 * RN Record Supervision Log
 */
const recordSupervisionRoute = createRoute({
    ...ROUTE_METADATA.RN.SUPERVISION_LOG,
    method: 'post',
    path: '/supervision',
    middleware: [requirePermission('PSW_SUPERVISE')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        pswId: z.string(),
                        competencies: z.any(),
                        isSatisfactory: z.boolean(),
                        feedback: z.string().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        201: {
            description: 'Supervision log recorded',
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
        },
    },
});

clinical.openapi(submitAssessmentRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;

    const assessment = await prisma.clinicalAssessment.create({
        data: {
            ...body,
            rnId: userId,
            tenantId,
        },
    });

    await logAudit(prisma, userId, 'SUBMIT_ASSESSMENT', 'CLIENT', body.clientId, body);

    return c.json(assessment, 201);
});

clinical.openapi(syncMedicationReconRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;

    const recon = await prisma.medicationRecon.create({
        data: {
            ...body,
            rnId: userId,
            tenantId,
        },
    });

    await logAudit(prisma, userId, 'SYNC_MED_RECON', 'CLIENT', body.clientId, body);

    return c.json(recon, 201);
});

clinical.openapi(recordSupervisionRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;

    const log = await prisma.supervisionLog.create({
        data: {
            ...body,
            rnId: userId,
            tenantId,
        },
    });

    await logAudit(prisma, userId, 'RECORD_SUPERVISION', 'PSW_PROFILE', body.pswId, body);

    return c.json(log, 201);
});

export default clinical;
