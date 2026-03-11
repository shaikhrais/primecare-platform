import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

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
                        prescriptions: z.any()
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
        }
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

        return c.json({ prescriptions: mappedPrescriptions }, 200);
    } catch (error) {
        console.error('Failed to fetch prescriptions:', error);
        return c.json({ error: 'Failed to fetch prescriptions' }, 500);
    }
});

export default pharmacyRoutes;
