import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CheckEventSchema = z.object({
    lat: z.number(),
    lng: z.number(),
    accuracy: z.number().optional(),
});

const ScheduleParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'visit-uuid',
    }),
});

const calculateDistance = (lat1: number, lon1: number, lat2: number, lon2: number) => {
    const R = 6371e3; // Earth radius in meters
    const φ1 = lat1 * Math.PI / 180;
    const φ2 = lat2 * Math.PI / 180;
    const Δφ = (lat2 - lat1) * Math.PI / 180;
    const Δλ = (lon2 - lon1) * Math.PI / 180;

    const a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
        Math.cos(φ1) * Math.cos(φ2) *
        Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c; // Distance in meters
};

// GET Assigned Visits
const listVisitsRoute = createRoute({
    method: 'get',
    path: '/visits',
    summary: 'Get Assigned Visits',
    description: 'Retrieve a list of visits assigned to the authenticated PSW.',
    tags: ['PSW Schedule'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of assigned visits',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(listVisitsRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visits = await prisma.visit.findMany({
        where: {
            assignedPswId: profile.id,
            status: { in: ['scheduled', 'en_route', 'arrived', 'in_progress'] },
        },
        orderBy: { requestedStartAt: 'asc' },
        include: {
            client: { select: { fullName: true, addressLine1: true, city: true } },
            service: true,
        },
    });

    return c.json(visits, 200);
});

// POST Check-In
const checkInRoute = createRoute({
    method: 'post',
    path: '/visits/{id}/check-in',
    summary: 'Visit Check-In',
    description: 'Perform a check-in for a specific visit, including GPS verification.',
    tags: ['PSW Schedule'],
    request: {
        params: ScheduleParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: CheckEventSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Check-in successful',
        },
        400: {
            description: 'Validation error (e.g., too far)',
        },
        404: {
            description: 'Visit or profile not found',
        },
    },
});

r.openapi(checkInRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findUnique({
        where: { id: visitId },
        include: { client: true },
    });
    if (!visit || visit.assignedPswId !== profile.id) {
        return c.json({ error: 'Visit not found or not assigned to you' }, 404);
    }

    let result: 'success' | 'rejected' = 'success';
    if (visit.client?.lat && visit.client?.lng) {
        const distance = calculateDistance(lat, lng, visit.client.lat, visit.client.lng);
        if (distance > 500) {
            return c.json({
                error: 'Too far from client location',
                distance: Math.round(distance),
                threshold: 500
            }, 400);
        }
    }

    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({
            data: {
                visitId,
                pswId: profile.id,
                eventType: 'check_in',
                lat,
                lng,
                accuracyM: accuracy,
                result,
                tenantId: profile.tenantId
            },
        }),
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'in_progress' },
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'CHECK_IN',
                resourceType: 'VISIT',
                resourceId: visitId,
                metadataJson: { result, lat, lng },
                tenantId: profile.tenantId
            }
        })
    ]);

    return c.json(event, 200);
});

// POST Check-Out
const checkOutRoute = createRoute({
    method: 'post',
    path: '/visits/{id}/check-out',
    summary: 'Visit Check-Out',
    description: 'Perform a check-out for a specific visit.',
    tags: ['PSW Schedule'],
    request: {
        params: ScheduleParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: CheckEventSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Check-out successful',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(checkOutRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({
            data: {
                visitId,
                pswId: profile.id,
                eventType: 'check_out',
                lat,
                lng,
                accuracyM: accuracy,
                result: 'success',
                tenantId: profile.tenantId
            },
        }),
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'completed' },
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'CHECK_OUT',
                resourceType: 'VISIT',
                resourceId: visitId,
                metadataJson: { lat, lng },
                tenantId: profile.tenantId
            }
        })
    ]);

    return c.json(event, 200);
});

// GET Offered Shifts
const listOffersRoute = createRoute({
    method: 'get',
    path: '/offers',
    summary: 'Get Offered Shifts',
    description: 'Retrieve a list of shifts offered to the authenticated PSW.',
    tags: ['PSW Schedule'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of offered shifts',
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

    const offers = await prisma.shiftAssignment.findMany({
        where: { pswId: profile.id, status: 'offered' },
        include: {
            visit: {
                include: {
                    client: { select: { fullName: true, addressLine1: true, city: true } },
                    service: true,
                }
            }
        }
    });

    return c.json(offers, 200);
});

// POST Accept Offer
const acceptOfferRoute = createRoute({
    method: 'post',
    path: '/offers/{id}/accept',
    summary: 'Accept Shift Offer',
    description: 'Accept an offered shift and mark the visit as scheduled.',
    tags: ['PSW Schedule'],
    request: {
        params: z.object({
            id: z.string().openapi({ param: { name: 'id', in: 'path' }, example: 'offer-uuid' })
        }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
                },
            },
            description: 'Offer accepted successfully',
        },
        404: {
            description: 'Offer or profile not found',
        },
    },
});

r.openapi(acceptOfferRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: assignmentId } = c.req.valid('param');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const assignment = await prisma.shiftAssignment.findUnique({
        where: { id: assignmentId },
        include: { visit: true }
    });

    if (!assignment || assignment.pswId !== profile.id) {
        return c.json({ error: 'Offer not found' }, 404);
    }

    await prisma.$transaction([
        prisma.shiftAssignment.update({
            where: { id: assignmentId },
            data: { status: 'accepted' }
        }),
        prisma.visit.update({
            where: { id: assignment.visitId },
            data: {
                status: 'accepted',
                assignedPswId: profile.id
            }
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'ACCEPT_OFFER',
                resourceType: 'VISIT',
                resourceId: assignment.visitId,
                tenantId: profile.tenantId
            }
        })
    ]);

    return c.json({ success: true }, 200);
});

// POST Decline Offer
const declineOfferRoute = createRoute({
    method: 'post',
    path: '/offers/{id}/decline',
    summary: 'Decline Shift Offer',
    description: 'Decline an offered shift.',
    tags: ['PSW Schedule'],
    request: {
        params: z.object({
            id: z.string().openapi({ param: { name: 'id', in: 'path' }, example: 'offer-uuid' })
        }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
                },
            },
            description: 'Offer declined successfully',
        },
    },
});

r.openapi(declineOfferRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id: assignmentId } = c.req.valid('param');

    await prisma.shiftAssignment.update({
        where: { id: assignmentId },
        data: { status: 'declined' }
    });

    return c.json({ success: true }, 200);
});

// POST Update Availability
const updateAvailabilityRoute = createRoute({
    method: 'post',
    path: '/availability',
    summary: 'Update Availability',
    description: 'Update the structural availability for the PSW.',
    tags: ['PSW Schedule'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        dayOfWeek: z.number().min(0).max(6),
                        startTime: z.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/),
                        endTime: z.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/),
                    })),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
                },
            },
            description: 'Availability updated successfully',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(updateAvailabilityRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const availabilityData = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    await prisma.$transaction([
        prisma.availability.deleteMany({ where: { pswId: profile.id } }),
        ...availabilityData.map(data => prisma.availability.create({
            data: {
                pswId: profile.id,
                ...data,
                tenantId: profile.tenantId
            }
        }))
    ]);

    return c.json({ success: true }, 200);
});

// POST Client Not Present (No-Show)
const reportNoShowRoute = createRoute({
    method: 'post',
    path: '/visits/{id}/no-show',
    summary: 'Report Client No-Show',
    description: 'Report that a client was not present for a visit. Requires a check-in and 15 minute wait.',
    tags: ['PSW Schedule'],
    request: {
        params: ScheduleParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean(), status: z.string() }),
                },
            },
            description: 'No-show reported successfully',
        },
        400: {
            description: 'Must check-in or wait 15 minutes',
        },
        404: {
            description: 'Visit or profile not found',
        },
    },
});

r.openapi(reportNoShowRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findFirst({
        where: { id: visitId, assignedPswId: profile.id },
        include: { checkEvents: { where: { eventType: 'check_in' }, orderBy: { serverTime: 'desc' } } }
    });

    if (!visit) return c.json({ error: 'Visit not found' }, 404);

    const checkIn = visit.checkEvents[0];
    if (!checkIn) return c.json({ error: 'Must check-in first before reporting no-show' }, 400);

    const waitTimeMs = 15 * 60 * 1000;
    const elapsed = Date.now() - new Date(checkIn.serverTime || Date.now()).getTime();
    if (elapsed < waitTimeMs) {
        return c.json({
            error: 'You must wait 15 minutes after check-in before flagging as no-show',
            remainingMinutes: Math.ceil((waitTimeMs - elapsed) / 60000)
        }, 400);
    }

    await prisma.$transaction([
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'no_show' }
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'CLIENT_NO_SHOW',
                resourceType: 'VISIT',
                resourceId: visitId,
                tenantId: profile.tenantId,
                metadataJson: { waitTimeMinutes: 15 }
            }
        })
    ]);

    return c.json({ success: true, status: 'no_show' }, 200);
});

export default r;
