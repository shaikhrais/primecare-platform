import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { SocialMediaAutoPoster } from '../../../marketing/syndication/SocialMediaAutoPoster';

const marketingRoutes = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /v1/system/marketing/churn-risks
marketingRoutes.openapi(
    createRoute({
        method: 'get',
        path: '/churn-risks',
    tags: ['Admin', 'Marketing'],
        summary: 'Get Algorithmic Churn Risks',
        responses: { 200: { description: 'Success' },
            '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
            '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
        }
    }),
    async (c) => {
        // Retrieve dynamic metrics based on actual system state if available. 
        // For now we serve intelligent synthetics directly from edge instead of bundled in client bundle.
        return c.json([
            { id: '1', name: 'James W.', contractStartDate: '2022-04-15', historicalWeeklyAvgHours: 120, currentWeeklyHours: 40, hoursDropPercentage: 66, riskLevel: 'CRITICAL', assignedRn: 'Sarah J.' },
            { id: '2', name: 'Eleanor F.', contractStartDate: '2023-01-10', historicalWeeklyAvgHours: 40, currentWeeklyHours: 20, hoursDropPercentage: 50, riskLevel: 'HIGH', assignedRn: 'Marcus C.' },
            { id: '3', name: 'Robert M.', contractStartDate: '2023-08-22', historicalWeeklyAvgHours: 24, currentWeeklyHours: 16, hoursDropPercentage: 33, riskLevel: 'MODERATE', assignedRn: 'Elena R.' }
        ]);
    }
);

// GET /v1/system/marketing/drip-sequences
marketingRoutes.openapi(
    createRoute({
        method: 'get',
        path: '/drip-sequences',
    tags: ['Admin', 'Marketing'],
        summary: 'Get Drip Sequence Configuration and Performance',
        responses: { 200: { description: 'Success' },
            '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
            '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
        }
    }),
    async (c) => {
        return c.json([
            { id: '1', type: 'TRIGGER', title: 'Lead Capture Form', description: 'User downloads "Dementia Pricing Guide PDF"' },
            { id: '2', type: 'EMAIL', title: 'Email 1: Guide Delivery', description: 'Subject: Here is your Pricing Guide', metrics: { sent: 480, openRate: 72, clickRate: 45 } },
            { id: '3', type: 'DELAY', title: 'Wait 3 Days', description: 'Give them time to read the PDF.' },
            { id: '4', type: 'EMAIL', title: 'Email 2: Trust Building', description: 'Subject: How we screen our caregivers', metrics: { sent: 410, openRate: 48, clickRate: 18 } },
            { id: '5', type: 'CONDITION', title: 'Did they click?', description: 'Branch based on engagement.' },
            { id: '6', type: 'EMAIL', title: 'Email 3 (High Intent)', description: 'Subject: Book a free RN assessment', metrics: { sent: 74, openRate: 85, clickRate: 40 } },
        ]);
    }
);

// GET /v1/system/marketing/revenue-attribution
marketingRoutes.openapi(
    createRoute({
        method: 'get',
        path: '/revenue-attribution',
    tags: ['Admin', 'Marketing'],
        summary: 'Get Marketing Revenue Attribution',
        responses: { 200: { description: 'Success' },
            '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
            '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
        }
    }),
    async (c) => {
        return c.json([
            { id: '1', campaignName: 'Q4_Dementia_Search', utmSource: 'google_cpc', spend: 4500, clicksTracked: 1300, leadsCaptured: 90, contractsSigned: 14, actualBilledRevenue: 165000 },
            { id: '2', campaignName: 'Winter_Respite_Promo', utmSource: 'facebook_ads', spend: 2200, clicksTracked: 3500, leadsCaptured: 125, contractsSigned: 5, actualBilledRevenue: 22000 },
            { id: '3', campaignName: 'Hospital_Discharge_Flyer', utmSource: 'print_qr', spend: 350, clicksTracked: 50, leadsCaptured: 20, contractsSigned: 9, actualBilledRevenue: 104000 },
            { id: '4', campaignName: 'Local_Magazine_Ad', utmSource: 'print_vanity_url', spend: 1800, clicksTracked: 15, leadsCaptured: 3, contractsSigned: 0, actualBilledRevenue: 0 }
        ]);
    }
);

// GET /v1/system/marketing/subscribers
marketingRoutes.openapi(
    createRoute({
        method: 'get',
        path: '/subscribers',
    tags: ['Admin', 'Marketing'],
        summary: 'Get Newsletter Subscribers',
        responses: { 200: { description: 'Success' },
            '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
            '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
        }
    }),
    async (c) => {
        return c.json([
            { id: '1', email: 'j.smith@hospital.org', name: 'Dr. John Smith', segment: 'B2B_HOSPITAL', engagementScore: 'HIGH', lastOpened: '2 days ago', status: 'SUBSCRIBED' },
            { id: '2', email: 'mary.jones@email.com', name: 'Mary Jones', segment: 'B2C_DEMENTIA_FAMILY', engagementScore: 'HIGH', lastOpened: '3 days ago', status: 'SUBSCRIBED' },
            { id: '3', email: 'r.williams@email.com', name: 'Robert Williams', segment: 'B2C_GENERAL_LEAD', engagementScore: 'LOW', lastOpened: '3 months ago', status: 'SUBSCRIBED' },
            { id: '4', email: 'a.nurses@clinic.net', name: 'Amanda (Clinic RN)', segment: 'B2B_HOSPITAL', engagementScore: 'MEDIUM', lastOpened: '1 month ago', status: 'SUBSCRIBED' },
            { id: '5', email: 'fake.email@bounce.com', name: 'Unknown', segment: 'B2C_GENERAL_LEAD', engagementScore: 'LOW', lastOpened: 'Never', status: 'BOUNCED' }
        ]);
    }
);

// GET /v1/system/marketing/promotions
marketingRoutes.openapi(
    createRoute({
        method: 'get',
        path: '/promotions',
    tags: ['Admin', 'Marketing'],
        summary: 'Get Promotional Code Engine Status',
        responses: { 200: { description: 'Success' },
            '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
            '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
        }
    }),
    async (c) => {
        return c.json([
            { id: '1', code: 'FREE_ASSESS_2026', discountType: 'FIXED_AMOUNT', value: 150, expirationDate: '2026-12-31', maxRedemptions: 50, currentRedemptions: 15, status: 'ACTIVE' },
            { id: '2', code: 'WINTER_RESPITE_10', discountType: 'PERCENTAGE', value: 10, expirationDate: '2026-03-01', maxRedemptions: 20, currentRedemptions: 20, status: 'DEPLETED' },
            { id: '3', code: 'VETERAN_CARE', discountType: 'PERCENTAGE', value: 15, expirationDate: '2099-12-31', maxRedemptions: 9999, currentRedemptions: 155, status: 'ACTIVE' }
        ]);
    }
);
// GET /v1/system/marketing/syndication/vault
marketingRoutes.openapi(
    createRoute({
        method: 'get',
        path: '/syndication/vault',
    tags: ['Admin', 'Marketing'],
        summary: 'Get Social Media Vault Status',
        responses: { 200: { description: 'Success' },
            '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
            '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
        }
    }),
    async (c) => {
 // Return active connections for the demo
        return c.json([
            { id: '1', platform: 'facebook', name: 'PrimeCare HC', status: 'connected', lastSync: '2 hours ago', accountId: 'fb-12345' },
            { id: '2', platform: 'linkedin', name: 'PrimeCare Corp', status: 'connected', lastSync: '10 mins ago', accountId: 'li-9876' },
            { id: '3', platform: 'instagram', name: 'PrimeCare.Health', status: 'disconnected', lastSync: 'N/A', accountId: '' },
            { id: '4', platform: 'twitter', name: '@PrimeCareTeam', status: 'error', lastSync: '3 days ago', accountId: 'tw-555' }
        ]);
    }
);

const SyndicationPostSchema = z.object({
    platforms: z.array(z.string()),
    content: z.string(),
    scheduleTime: z.string().optional()
});

// POST /v1/system/marketing/syndication/post
marketingRoutes.openapi(
    createRoute({
        method: 'post',
        path: '/syndication/post',
    tags: ['Admin', 'Marketing'],
        summary: 'Trigger Social Media Auto-Poster',
        request: {
            body: {
                content: {
                    'application/json': {
                        schema: SyndicationPostSchema
                    }
                }
            }
        },
        responses: { 200: { description: 'Success' }, 500: { description: 'Error' },
            '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
            '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
        }
    }),
    async (c) => {
        const body = await c.req.valid('json');
        
        // Ensure non-blocking execution inside the Cloudflare Worker via trigger
        c.executionCtx.waitUntil(
            SocialMediaAutoPoster.executeSyndicationBlast({
                assetId: `asset_${Date.now()}`,
                campaignName: 'Automated_Syndicated_Blast',
                mediaUrl: 'https://cdn.primecare.org/auto',
                captionBody: body.content,
                targetPlatforms: body.platforms
            })
        );

        return c.json({
            success: true,
            jobId: `job-${Math.random().toString(36).substring(2, 9)}`,
            dispatchedTo: body.platforms.map(p => ({ platform: p, status: 'QUEUED', timestamp: new Date().toISOString() })),
            scheduledFor: body.scheduleTime || 'IMMEDIATE'
        });
    }
);

export default marketingRoutes;
