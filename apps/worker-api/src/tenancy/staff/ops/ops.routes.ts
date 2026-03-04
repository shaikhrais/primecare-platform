import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requireRole } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IncidentSchema = z.object({
    visitId: z.string().uuid().optional(),
    type: z.enum(['fall_risk', 'refusal', 'no_show', 'safety', 'other']),
    description: z.string(),
});

const incidentSubmitRoute = createRoute({
    ...ROUTE_METADATA.STAFF.INCIDENT_SUBMIT,
    method: 'post',
    path: '/incidents/submit',
    middleware: [requireRole(['staff', 'coordinator', 'admin'])],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: IncidentSchema,
                },
            },
        },
    },
    responses: {
        201: {
            description: 'Incident reported successfully',
        },
    },
});

const complianceScanRoute = createRoute({
    ...ROUTE_METADATA.STAFF.COMPLIANCE_SCAN,
    method: 'post',
    path: '/compliance/scan',
    middleware: [requireRole(['staff', 'coordinator', 'admin'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        status: z.string(),
                        metrics: z.any(),
                    }),
                },
            },
            description: 'Compliance scan completed',
        },
    },
});

r.openapi(incidentSubmitRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;
    const data = c.req.valid('json');

    const incident = await prisma.incident.create({
        data: {
            reporterUserId: userId,
            tenantId: tenantId,
            type: data.type,
            description: data.description,
            visitId: data.visitId,
            status: 'open',
        },
    });

    await logAudit(prisma, userId, 'LOG_INCIDENT', 'INCIDENT', incident.id, { type: data.type });

    return c.json({ status: 'success', id: incident.id }, 201);
});

r.openapi(complianceScanRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    // Simulate compliance scan logic
    const metrics = {
        totalCaregivers: 84,
        compliant: 78,
        expiringSoon: 4,
        nonCompliant: 2,
    };

    return c.json({ status: 'success', metrics }, 200);
});

export default r;
