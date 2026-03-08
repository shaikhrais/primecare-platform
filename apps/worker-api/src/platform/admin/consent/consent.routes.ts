import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const consent = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /client/:clientId — Client's consent forms
const listRoute = createRoute({
    method: 'get', path: '/client/{clientId}',
    summary: 'Client Consent Forms', tags: ['Consent'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), formType: z.string(), status: z.string(),
                        signedAt: z.string().nullable(), expiresAt: z.string().nullable(),
                    }))
                }
            }, description: 'Forms'
        },
    },
});

consent.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const forms = await prisma.consentForm.findMany({
        where: { tenantId, clientId }, orderBy: { createdAt: 'desc' },
    });
    return c.json(forms, 200);
});

// POST / — Submit signed consent
const submitRoute = createRoute({
    method: 'post', path: '/',
    summary: 'Submit Signed Consent', tags: ['Consent'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(),
                        formType: z.enum(['service_agreement', 'phipa_consent', 'dnr', 'hipaa', 'general']),
                        signatureDataUrl: z.string().optional(),
                        witnessName: z.string().optional(),
                        expiresAt: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: { 200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Submitted' } },
});

consent.openapi(submitRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const form = await prisma.consentForm.create({
        data: {
            clientId: body.clientId, formType: body.formType,
            signatureDataUrl: body.signatureDataUrl, witnessName: body.witnessName,
            signedAt: new Date(), status: 'signed',
            expiresAt: body.expiresAt ? new Date(body.expiresAt) : null,
            tenantId,
        },
    });
    return c.json(form, 200);
});

// GET /templates — Consent form templates
const templatesRoute = createRoute({
    method: 'get', path: '/templates',
    summary: 'Consent Form Templates', tags: ['Consent'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        type: z.string(), name: z.string(), description: z.string(),
                        requiredForAdmission: z.boolean(),
                    }))
                }
            }, description: 'Templates'
        },
    },
});

consent.openapi(templatesRoute, async (c) => {
    const templates = [
        { type: 'service_agreement', name: 'Service Agreement', description: 'Agreement for home care services including scope, schedule, and fees.', requiredForAdmission: true },
        { type: 'phipa_consent', name: 'PHIPA / Privacy Consent', description: 'Consent for collection, use, and disclosure of personal health information under PHIPA.', requiredForAdmission: true },
        { type: 'dnr', name: 'Do Not Resuscitate Directive', description: 'Advanced care directive for end-of-life preferences.', requiredForAdmission: false },
        { type: 'hipaa', name: 'HIPAA Authorization', description: 'US health information privacy consent (for cross-border clients).', requiredForAdmission: false },
        { type: 'general', name: 'General Consent', description: 'General consent to care and treatment.', requiredForAdmission: true },
    ];
    return c.json(templates, 200);
});

// GET /expiring — Expiring consent alerts
const expiringRoute = createRoute({
    method: 'get', path: '/expiring',
    summary: 'Expiring Consent Alerts', tags: ['Consent'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), clientId: z.string(), formType: z.string(), expiresAt: z.string(),
                    }))
                }
            }, description: 'Expiring'
        },
    },
});

consent.openapi(expiringRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const thirtyDays = new Date();
    thirtyDays.setDate(thirtyDays.getDate() + 30);

    const expiring = await prisma.consentForm.findMany({
        where: {
            tenantId, status: 'signed',
            expiresAt: { lte: thirtyDays, gte: new Date() },
        },
        include: { client: { select: { fullName: true } } },
        orderBy: { expiresAt: 'asc' },
    });
    return c.json(expiring, 200);
});

export default consent;
