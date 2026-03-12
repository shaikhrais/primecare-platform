import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Offered Shifts
const listOffersRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.LIST_OFFERS,
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of shift offers',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(listOffersRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const offers = await prisma.visit.findMany({
        where: {
            status: 'posted',
            offers: { some: { pswId: profile.id, status: 'pending' } },
        },
        orderBy: { requestedStartAt: 'asc' },
        include: {
            client: { select: { fullName: true, city: true } },
            service: true,
        },
    });

    return c.json(offers, 200);
});

// POST Accept Offer
const acceptOfferRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.ACCEPT_OFFER,
    method: 'post',
    path: '/{id}/accept',
    request: {
        params: z.object({ id: z.string() }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Offer accepted successfully',
        },
        400: {
            description: 'Offer already accepted or no longer available',
        },
        404: {
            description: 'Offer not found',
        },
    },
});

r.openapi(acceptOfferRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findUnique({
        where: { id: visitId },
        include: { offers: { where: { pswId: profile.id } } },
    });

    if (!visit || visit.status !== 'posted') {
        return c.json({ error: 'Offer no longer available' }, 400);
    }

    // Feature 11: Wellness Thresholds -> block CrisisMode shifts
    if (visit.service?.name?.toLowerCase().includes('crisis') || visit.priority === 'CRITICAL') {
        const sevenDaysAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
        const recentPulses = await prisma.wellnessPulse.findMany({
            where: {
                pswId: profile.id,
                createdAt: { gt: sevenDaysAgo },
                score: { lt: 3 } // Assume < 3 is burnout/low wellness
            }
        });

        if (recentPulses.length >= 2) {
            console.log(`[Worker] Feature 11 Fired: Blocked CrisisMode shift assignment for burnt-out PSW ${profile.id}`);
            return c.json({ 
                error: 'Wellness Protocol Active. You have reported multiple low wellness scores recently. Please rest. Crisis shifts are temporarily blocked for 48 hours for your safety.' 
            }, 403);
        }
    }

    // Feature 15: Overtime Sentinel Webhook
    // Check if the current accepted cumulative week pushes > 44 hours.
    const startOfWeek = new Date();
    startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay());
    
    const weekVisits = await prisma.visit.findMany({
        where: {
            assignedPswId: profile.id,
            requestedStartAt: { gte: startOfWeek }
        }
    });

    // Assume average 1 hour per visit for simplicty of heuristic. 44 visits = 44 hours.
    const totalHoursBeforeThis = weekVisits.length;
    if (totalHoursBeforeThis >= 44 && profile.tenantId) {
        console.log(`[Worker] Feature 15 Fired: PSW ${profile.id} exceeded 44 hour limit. Triggering Overtime Sentinel Webhook Notification.`);
        const adminManager = await prisma.user.findFirst({
            where: { tenantId: profile.tenantId, role: 'manager' } // Escalate to manager/HR mapping
        });

        if (adminManager) {
            await prisma.appNotification.create({
                data: {
                    userId: adminManager.id,
                    tenantId: profile.tenantId,
                    title: 'System Alert: Overtime Exceeded',
                    message: `PSW ID ${profile.id} has accepted a shift pushing them past 44 total weekly hours. Standard Overtime parameters will apply to Payroll outputs.`,
                    type: 'warning'
                }
            });
        }
    }

    // Feature 17: Training Expired Blocker
    const expiredTrainings = await prisma.trainingAssignment.count({
        where: {
            pswId: profile.id,
            status: 'assigned', // Assuming 'assigned' is the pending state in schema
            dueDate: { lt: new Date() }
        }
    });

    if (expiredTrainings > 0) {
        console.log(`[Worker] Feature 17 Fired: Blocked shift assignment for Profile ${profile.id} due to ${expiredTrainings} expired training modules.`);
        return c.json({ error: `Mandatory Compliance Block: You have ${expiredTrainings} overdue training modules. Please complete them to resume accepting shifts.` }, 403);
    }

    await prisma.$transaction(async (tx: any) => {
        await tx.visit.update({
            where: { id: visitId },
            data: { status: 'scheduled', assignedPswId: profile.id },
        });
        await tx.shiftOffer.updateMany({
            where: { visitId, pswId: profile.id },
            data: { status: 'accepted' },
        });
        await tx.shiftOffer.updateMany({
            where: { visitId, pswId: { not: profile.id } },
            data: { status: 'expired' },
        });

        // Feature 32: Gamified Picking
        const coinsAwarded = (visit.priority === 'CRITICAL' || visit.priority === 'HIGH') ? 100 : 50;
        
        let gamification = await tx.gamificationProfile.findUnique({
            where: { pswId: profile.id }
        });
        
        if (!gamification) {
             gamification = await tx.gamificationProfile.create({
                 data: { pswId: profile.id, tenantId: profile.tenantId || 'system', careCoins: 0, currentLevel: 1, currentTier: 'Bronze' }
             });
        }
        
        const updatedGamification = await tx.gamificationProfile.update({
            where: { id: gamification.id },
            data: { careCoins: { increment: coinsAwarded } }
        });
        
        // Feature 35: Tier Progression Webhook
        if (updatedGamification.careCoins >= 1000 && updatedGamification.currentTier === 'Bronze') {
             await tx.gamificationProfile.update({
                 where: { id: gamification.id },
                 data: { currentTier: 'Silver', currentLevel: 2 }
             });
             
             // Trigger WebhookDelivery requesting a physical certificate print and shipment
             await tx.webhookDelivery.create({
                 data: {
                     tenantId: profile.tenantId || 'system',
                     endpointUrl: 'https://api.printmail.example.com/certificates',
                     payload: JSON.stringify({
                         pswId: profile.id,
                         award: 'Bronze to Silver Promotion',
                         instruction: 'Print and mail physical certificate'
                     }),
                     status: 'pending',
                     attempts: 0
                 }
             });
             console.log(`[Worker] Feature 35 Fired: Promoted PSW ${profile.id} to Silver. WebhookDelivery queued for physical certificate printing.`);
        }
        
        await tx.auditLog.create({
            data: {
                tenantId: profile.tenantId || 'system', actorUserId: userId,
                action: 'GAMIFIED_PICKING_REWARD', resourceType: 'GAMIFICATION', resourceId: gamification.id,
                metadataString: JSON.stringify({ visitId, priority: visit.priority, coinsAwarded })
            }
        });
        console.log(`[Worker] Feature 32 Fired: Awarded ${coinsAwarded} CareCoins to PSW ${profile.id} for accepting ${visit.priority || 'ROUTINE'} shift ${visit.id}.`);
    });

    return c.json({ success: true }, 200);
});

// POST Decline Offer
const declineOfferRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.DECLINE_OFFER,
    method: 'post',
    path: '/{id}/decline',
    request: {
        params: z.object({ id: z.string() }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Offer declined successfully',
        },
        404: {
            description: 'Offer not found',
        },
    },
});

r.openapi(declineOfferRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    await prisma.shiftOffer.updateMany({
        where: { visitId, pswId: profile.id },
        data: { status: 'declined' },
    });

    return c.json({ success: true }, 200);
});

export default r;
