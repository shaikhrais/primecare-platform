import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const runAutoPilotRoute = createRoute({
    method: 'post',
    path: '/clinical-autopilot/run',
    tags: ['Admin // Automation'],
    summary: 'Run Clinical Auto-Pilot Engine',
    description: 'Scans pending visits for the next 48 hours and automatically matches and offers shifts to available, skilled PSWs within the tenant.',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        processedVisits: z.number(),
                        offersCreated: z.number(),
                        message: z.string()
                    }),
                },
            },
            description: 'Result of the automation run',
        },
        401: {
            content: { 'application/json': { schema: z.object({ error: z.string() }) } },
            description: 'Unauthorized',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Internal server error',
        }
    }
});

r.openapi(runAutoPilotRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user') as { id: string, role: string, tenantId?: string };

    if (!user || !user.tenantId) {
        return c.json({ data: 0, error: 'Unauthorized' } as any, 401 as const);
    }

    try {
        const now = new Date();
        const next48Hours = new Date(now.getTime() + 48 * 60 * 60 * 1000);

        // 1. Find upcoming pending visits for this tenant
        const pendingVisits = await prisma.visit.findMany({
            where: {
                tenantId: user.tenantId,
                status: { in: ['requested', 'pending', 'draft'] },
                requestedStartAt: {
                    gte: now,
                    lte: next48Hours
                },
                assignedPswId: null
            },
            include: {
                assignments: true // to check if we already offered it
            }
        });

        let offersCreated = 0;

        for (const visit of pendingVisits) {
            // Skip if it already has pending offers
            if (visit.assignments && visit.assignments.length > 0) {
                continue;
            }

            // 2. Find eligible active PSWs in this tenant
            // Simplified matching logic: Active, has matching skills 
            // In a real scenario, this would check `PswAvailability` and overlapping `ShiftAssignment`.
            const eligiblePsws = await prisma.pswProfile.findMany({
                where: {
                    tenantId: user.tenantId,
                    isApproved: true,
                    // If visit has required skills, PSW must have at least one (simplified overlap check)
                    ...(visit.requiredSkills.length > 0 ? {
                        skills: {
                            hasSome: visit.requiredSkills
                        }
                    } : {})
                },
                take: 3 // Limit offers to top 3 candidates to avoid spamming
            });

            // 3. Create Shift Assignments (Offers)
            for (const psw of eligiblePsws) {
                await prisma.shiftAssignment.create({
                    data: {
                        visitId: visit.id,
                        pswId: psw.id,
                        tenantId: user.tenantId,
                        status: 'offered',
                        score: 0.95 // Mock algorithmic confidence score
                    }
                });
                offersCreated++;
            }

            // Move visit status to offered if we sent out proposals
            if (eligiblePsws.length > 0) {
                await prisma.visit.update({
                    where: { id: visit.id },
                    data: { status: 'offered' }
                });
            }
        }

        return c.json({
            processedVisits: pendingVisits.length,
            offersCreated: offersCreated,
            message: `Auto-Pilot completed. Processed ${pendingVisits.length} visits. Generated ${offersCreated} shift offers.`
        }, 200 as const);

    } catch (error) {
        console.error('Error running clinical auto-pilot:', error);
        return c.json({ error: 'Internal server error' } as any, 500 as const);
    }
});

export { r as clinicalAutopilotRoutes };
