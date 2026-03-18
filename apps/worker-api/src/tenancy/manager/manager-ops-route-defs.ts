/**
 * Manager Ops Route Definitions
 * Extracted from manager_ops.routes.ts
 */
import { createRoute, z } from '@hono/zod-openapi';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';

export const StatsSchema = z.object({ revenue: z.number(), utilization: z.number(), churnRate: z.number(), activeClients: z.number(), activeProviders: z.number() });
export const ComplianceSchema = z.object({ success: z.boolean(), processed: z.number(), flags: z.number() });
export const FeedbackTriageSchema = z.object({ status: z.string(), resolutionNote: z.string().optional() });
export const WaitlistResponseSchema = z.object({ id: z.string(), fullName: z.string(), riskScore: z.number(), daysOnWaitlist: z.number(), primaryCondition: z.string().nullable(), location: z.string(), status: z.string() });
export const LogisticsBoardResponseSchema = z.object({
    unassignedShifts: z.array(z.object({ id: z.string(), clientName: z.string(), time: z.string(), duration: z.string(), location: z.string(), urgency: z.enum(['high', 'medium', 'low']) })),
    availableStaff: z.array(z.object({ id: z.string(), name: z.string(), role: z.string(), status: z.enum(['available', 'busy', 'offline']), utilization: z.number(), currentLocation: z.string() }))
});

export const branchHealthRoute = createRoute({ ...ROUTE_METADATA.MANAGER.BRANCH_HEALTH, method: 'get', path: '/branch-health', summary: 'Branch Health', tags: ['Manager'], request: {},
    responses: { 200: { content: { 'application/json': { schema: z.object({ status: z.string(), alerts: z.array(z.object({ type: z.string(), severity: z.string(), message: z.string() })) }) } }, description: 'Branch health retrieved' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const statsRoute = createRoute({ ...ROUTE_METADATA.MANAGER.OPS_STATS, method: 'get', path: '/stats', summary: 'Stats', tags: ['Manager'], request: {},
    responses: { 200: { content: { 'application/json': { schema: StatsSchema } }, description: 'Regional stats retrieved' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const complianceSyncRoute = createRoute({ ...ROUTE_METADATA.MANAGER.COMPLIANCE_SYNC, method: 'post', path: '/compliance/sync', summary: 'Compliance Sync', tags: ['Manager'], request: {},
    responses: { 200: { content: { 'application/json': { schema: ComplianceSchema } }, description: 'Compliance synchronized' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const feedbackTriageRoute = createRoute({ ...ROUTE_METADATA.MANAGER.FEEDBACK_TRIAGE, method: 'patch', path: '/feedback/{id}/triage', summary: 'Feedback Triage', tags: ['Manager'],
    request: { params: z.object({ id: z.string().openapi({ example: '123' }) }), body: { content: { 'application/json': { schema: FeedbackTriageSchema } } } },
    responses: { 200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Feedback triaged' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const waitlistRoute = createRoute({ method: 'get', path: '/intake/waitlist', summary: 'Waitlist', request: {},
    responses: { 200: { content: { 'application/json': { schema: z.array(WaitlistResponseSchema) } }, description: 'Intake waitlist retrieved' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    }, tags: ['Manager Operations'], operationId: 'getWaitlist' });

export const logisticsBoardRoute = createRoute({ method: 'get', path: '/schedule/logistics-board', summary: 'Logistics Board', request: {},
    responses: { 200: { content: { 'application/json': { schema: LogisticsBoardResponseSchema } }, description: 'Logistics board data retrieved' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    }, tags: ['Manager Operations'], operationId: 'getLogisticsBoard' });

export const getIncidentsRoute = createRoute({ method: 'get', path: '/incidents', summary: 'Get Incidents', tags: ['Manager'],
    responses: { 200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'Recent incidents' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const getLocationsRoute = createRoute({ method: 'get', path: '/locations', summary: 'Get Locations', tags: ['Manager'],
    responses: { 200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'Real-time staff coordinates' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const getApprovalsRoute = createRoute({ method: 'get', path: '/approvals', summary: 'Get Approvals', tags: ['Manager'], request: {},
    responses: { 200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'List of pending approvals' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const approveItemRoute = createRoute({ method: 'post', path: '/approvals/{id}/approve', summary: 'Approve Item', tags: ['Manager'],
    request: { params: z.object({ id: z.string() }) },
    responses: { 200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Item approved' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const rejectItemRoute = createRoute({ method: 'post', path: '/approvals/{id}/reject', summary: 'Reject Item', tags: ['Manager'],
    request: { params: z.object({ id: z.string() }) },
    responses: { 200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Item rejected' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });

export const authorizeCrisisPayRoute = createRoute({ method: 'post', path: '/schedule/logistics-board/{visitId}/crisis-pay', summary: 'Authorize Crisis Pay', tags: ['Manager Operations'],
    request: { params: z.object({ visitId: z.string() }) },
    responses: { 200: { content: { 'application/json': { schema: z.object({ success: z.boolean(), payoutId: z.string() }) } }, description: 'Crisis pay authorized' }, 404: { description: 'Visit or assignment not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    } });
