import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requireRole } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FeedbackSchema = z.object({
    visitId: z.string().uuid().optional(),
    rating: z.number().min(1).max(5),
    comment: z.string().optional(),
});

const teamRosterRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.TEAM_ROSTER,
    method: 'get',
    path: '/team/roster',
    summary: 'Team Roster',
    tags: ['Client', 'Relationship'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'Care team roster retrieved',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

const feedbackSubmitRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.FEEDBACK_SUBMIT,
    method: 'post',
    path: '/support/feedback',
    summary: 'Feedback Submit',
    tags: ['Client', 'Relationship'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: FeedbackSchema,
                },
            },
        },
    },
    responses: {
        201: {
            description: 'Feedback submitted successfully',
        },
    },
});

r.openapi(teamRosterRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // In a real system, we'd query visits joined with pswProfile
    // Returning seeded team data for the UI
    const team = [
        { id: '1', name: 'Sarah Jenkins', role: 'Primary PSW', specialty: 'Dementia Care', rating: 4.9, visits: 124, bio: 'Sarah has over 8 years of experience in geriatric support.' },
        { id: '2', name: 'Michael Chen', role: 'Relief PSW', specialty: 'Post-Op Recovery', rating: 4.8, visits: 42, bio: 'Michael specializes in assisting clients during their recovery.' },
    ];

    return c.json(team, 200);
});

r.openapi(feedbackSubmitRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;
    const data = c.req.valid('json');

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const feedback = await prisma.careFeedback.create({
        data: {
            clientId: profile.id,
            tenantId: tenantId,
            rating: data.rating,
            comment: data.comment,
            visitId: data.visitId || '', // Ensuring visitId is handled
        },
    });

    await logAudit(prisma, userId, 'SUBMIT_FEEDBACK', 'FEEDBACK', feedback.id, { rating: data.rating });

    return c.json({ status: 'success', id: feedback.id }, 201);
});

export default r;
