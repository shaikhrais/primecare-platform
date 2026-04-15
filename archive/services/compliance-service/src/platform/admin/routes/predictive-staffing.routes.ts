import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const predictiveStaffingRoute = createRoute({
    method: 'get',
    path: '/',
    tags: ['Admin Insights'],
    summary: 'Predictive Staffing Score',
    description: 'Calculates the burnout risk score for active field staff.',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'List of staff risk scores',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Internal server error',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    }
});

r.openapi(predictiveStaffingRoute, async (c) => {
    const prisma = c.get('prisma');

    try {
        // 1. Fetch all active field staff (no need for tenantId, global middleware handles it)
        const psws = await prisma.user.findMany({
            where: {
                roles: { hasSome: ['psw', 'rn', 'rmt', 'rpt', 'rch'] },
                status: 'active'
            },
            include: {
                providerProfile: true,
                reportedIncidents: {
                    where: {
                        createdAt: {
                            gte: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000) // Last 30 days
                        }
                    }
                }
            }
        });

        // 2. Fetch timesheets for the last 14 days
        const fourteenDaysAgo = new Date(Date.now() - 14 * 24 * 60 * 60 * 1000);
        const timesheets = await prisma.timesheet.findMany({
            where: {
                createdAt: {
                    gte: fourteenDaysAgo
                }
            },
            include: {
                items: true
            }
        });

        // 3. Calculate Burnout Risk Score
        const riskScores = psws.map((psw: any) => {
            let score = 0;
            const riskFactors: string[] = [];

            // A. Hours worked in the last 14 days
            const pswTimesheets = timesheets.filter((t: any) => t.providerId === psw.providerProfile?.id);
            let totalMinutes = 0;
            pswTimesheets.forEach((ts: any) => {
                ts.items.forEach((item: any) => totalMinutes += item.minutes);
            });
            const totalHours = totalMinutes // 60;

            if (totalHours > 80) { // Overtime territory in 14 days
                score += 40;
                riskFactors.push(`High hours (${totalHours.toFixed(1)}h in last 14 days)`);
            } else if (totalHours > 60) {
                score += 20;
                riskFactors.push('Elevated hours');
            }

            // B. Recent incidents reported
            const incidentCount = psw.reportedIncidents.length;
            if (incidentCount > 2) {
                score += 30;
                riskFactors.push(`Multiple recent incidents reported (${incidentCount})`);
            } else if (incidentCount > 0) {
                score += 15;
                riskFactors.push('Recent incident reported');
            }

            // Default safe score modifier
            if (score === 0 && totalHours > 0 && totalHours <= 40) {
                score -= 10;
            }

            return {
                userId: psw.id,
                providerId: psw.providerProfile?.id,
                name: psw.providerProfile?.fullName || psw.email,
                score: Math.max(0, Math.min(score, 100)), // Cap between 0 and 100
                riskLevel: score >= 70 ? 'High' : score >= 40 ? 'Medium' : 'Low',
                riskFactors,
                totalHours14d: totalHours
            };
        });

        // 4. Sort by highest risk first
        riskScores.sort((a: any, b: any) => b.score - a.score);

        return c.json({ data: riskScores } as any, 200 as const);

    } catch (error) {
        // R14: Don't leak internal errors
        return c.json({ data: [], error: 'Internal server error' } as any, 500 as const);
    }
});

export { r as predictiveStaffingRoutes };
