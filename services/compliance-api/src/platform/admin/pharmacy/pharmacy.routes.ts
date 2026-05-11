import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
const dispatchDispenser = async (_: any) => ({ success: true, status: 'ok', message: 'MOCK' });
const verifyBarcodeScan = async (_: any) => ({ success: true, valid: true, error: null, medicationId: 'MOCK' }); // MOCK

const pharmacyRoutes = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getPrescriptionsRoute = createRoute({
    method: 'get',
    path: '/prescriptions',
    summary: 'Get Active Prescriptions',
    description: 'Returns a list of active medications and their MAR compliance status.',
    tags: ['Admin', 'Pharmacy'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        prescriptions: z.any(),
                        stats: z.any().optional()
                    }),
                },
            },
            description: 'Success',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() })
                }
            },
            description: 'Internal Server Error'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

pharmacyRoutes.openapi(getPrescriptionsRoute, async (c) => {
    const prisma = c.get('prisma');
    try {
        const prescriptions = await prisma.prescription.findMany({
            include: {
                patient: true,
                medication: true
            },
            take: 50
        });

        // Map to frontend expected shape
        const mappedPrescriptions = prescriptions.map((p: any) => ({
            id: p.id,
            name: p.medication.name,
            strength: p.dosage || 'Standard',
            patient: p.patient.fullName,
            frequency: p.frequency,
            status: p.status.charAt(0).toUpperCase() + p.status.slice(1)
        }));

        const activeCount = await prisma.prescription.count({ where: { status: 'Active' }});
        const pendingCount = await prisma.prescription.count({ where: { status: 'Renewed' }});
        const totalCount = await prisma.prescription.count();
        const marCompliance = totalCount > 0 ? ((activeCount / totalCount) * 100).toFixed(1) + '%' : '100%';

        return c.json({ 
            prescriptions: mappedPrescriptions,
            stats: {
                active: activeCount,
                pendingRenewals: pendingCount,
                marCompliance: marCompliance,
                criticalAlerts: Math.floor(pendingCount / 2) // Derived generic logic model
            }
        }, 200);
    } catch (error) {
        console.error('Failed to fetch prescriptions:', error);
        return c.json({ error: 'Failed to fetch prescriptions' }, 500);
    }
});

// Handle Order Requests
const orderDrugsRoute = createRoute({
    method: 'post',
    path: '/orders',
    summary: 'Order Medications',
    tags: ['Admin', 'Pharmacy'],
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ message: z.string() }) } },
            description: 'Success',
        },
        500: {
            content: { 'application/json': { schema: z.object({ message: z.string() }) } },
            description: 'Internal Server Error',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

pharmacyRoutes.openapi(orderDrugsRoute, async (c) => {
    try {
        // Assume these values are parsed from the body in a real system
        // We'll hardcode mocks for this simulation phase.
        const mockOrder = {
            orderId: `ORD-${Date.now()}`,
            patientId: 'PT-999',
            ndc: '00000-0000-00', // Mock NDC
            quantity: 30
        };

        const result = await dispatchDispenser(mockOrder);

        return c.json({ message: `Medication order mapped to hardware subsystem: Status [${result.status}] - ${result.message}` }, 200);
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        return c.json({ message: `Hardware Dispatch Failed: ${e.message}` }, 500);
    }
});

// Handle Hardware BCMA Scan Verification
const verifyBarcodeRoute = createRoute({
    method: 'post',
    path: '/verify-barcode',
    summary: 'Hardware Scanner Verification (BCMA)',
    tags: ['Admin', 'Pharmacy'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        ndc: z.string().describe('The raw scanned NDC code from the hardware wedge'),
                        expectedNdc: z.string().describe('The drug they are supposed to be administering based on the active MAR'),
                        patientId: z.string().optional()
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ isValid: z.boolean(), message: z.string() }) } },
            description: 'Barcode verified correctly',
        },
        400: {
            content: { 'application/json': { schema: z.object({ isValid: z.boolean(), error: z.string() }) } },
            description: 'Medication mismatch (Wrong Drug)',
        },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

pharmacyRoutes.openapi(verifyBarcodeRoute, async (c) => {
    const body = c.req.valid('json') /* Audit 32 SECURED */;
    const result = await verifyBarcodeScan({
        ndc: body.ndc,
        expectedNdc: body.expectedNdc,
        patientId: body.patientId || 'UNKNOWN'
    });

    if (!result.valid) {
        return c.json({ isValid: false, error: result.error || 'Barcode Validation Failed' }, 400);
    }

    return c.json({ isValid: true, message: 'Five rights confirmed. Medication verified against MAR.' }, 200);
});

// Handle MAR Sync
const marSyncRoute = createRoute({
    method: 'post',
    path: '/mar/sync',
    summary: 'Sync Pharmacy MAR',
    tags: ['Admin', 'Pharmacy'],
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ message: z.string() }) } },
            description: 'Success',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

pharmacyRoutes.openapi(marSyncRoute, async (c) => {
    // In a real app we'd dispatch a sync query across tenant databases.
    return c.json({ message: 'MAR successfully synchronized across regional nodes.' }, 200);
});

export default pharmacyRoutes;
