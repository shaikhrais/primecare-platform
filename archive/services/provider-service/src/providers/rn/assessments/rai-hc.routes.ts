import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const raiHc = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /templates — RAI-HC / OASIS templates
const templatesRoute = createRoute({
    method: 'get', path: '/templates',
    summary: 'Assessment Form Templates', tags: ['RAI-HC'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), name: z.string(), category: z.string(),
                        sections: z.array(z.object({ title: z.string(), fields: z.array(z.string()) })),
                    }))
                }
            }, description: 'Templates'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

raiHc.openapi(templatesRoute, async (c) => {
    const templates = [
        {
            id: 'rai-hc', name: 'RAI-HC (Home Care)', category: 'standardized',
            sections: [
                { title: 'Cognitive Performance', fields: ['cps_score', 'short_term_memory', 'daily_decision_making', 'understood'] },
                { title: 'Communication / Hearing', fields: ['hearing', 'communication', 'expression', 'comprehension'] },
                { title: 'Vision', fields: ['vision', 'visual_limitation'] },
                { title: 'Mood & Behaviour', fields: ['depression_rating', 'anxiety', 'wandering', 'verbal_abuse', 'physical_abuse'] },
                { title: 'ADL / Functional Status', fields: ['bathing', 'dressing_upper', 'dressing_lower', 'locomotion', 'transfer', 'toilet_use', 'eating'] },
                { title: 'Continence', fields: ['bladder_continence', 'bowel_continence'] },
                { title: 'Disease Diagnoses', fields: ['diagnoses_list', 'medications_count'] },
                { title: 'Health Conditions', fields: ['pain_frequency', 'pain_intensity', 'falls', 'pressure_ulcer', 'weight_loss'] },
                { title: 'Nutrition / Oral', fields: ['weight', 'height', 'bmi', 'oral_status', 'nutritional_approach'] },
                { title: 'Skin Condition', fields: ['skin_ulcers', 'wound_type', 'stage', 'healing_status'] },
                { title: 'Environmental Assessment', fields: ['home_safety', 'stairs', 'grab_bars', 'lighting'] },
                { title: 'Service Utilization', fields: ['er_visits', 'hospitalizations', 'physician_visits'] },
            ],
        },
        {
            id: 'oasis-e', name: 'OASIS-E (US Home Health)', category: 'standardized',
            sections: [
                { title: 'Patient Information', fields: ['start_of_care_date', 'referral_date', 'episode_timing'] },
                { title: 'Clinical Record Items', fields: ['diagnoses', 'risk_for_hospitalization', 'medication_management'] },
                { title: 'Functional Status', fields: ['grooming', 'upper_dressing', 'lower_dressing', 'bathing', 'toilet_transfer', 'ambulation'] },
                { title: 'Sensory Status', fields: ['vision', 'hearing', 'speech'] },
                { title: 'Wound / Integumentary', fields: ['pressure_ulcer_risk', 'wound_count', 'wound_status'] },
            ],
        },
        {
            id: 'braden', name: 'Braden Scale (Pressure Ulcer Risk)', category: 'specialized',
            sections: [
                { title: 'Braden Scoring', fields: ['sensory_perception', 'moisture', 'activity', 'mobility', 'nutrition', 'friction_shear'] },
            ],
        },
    ];
    return c.json(templates, 200);
});

// POST / — Submit completed assessment
const submitRoute = createRoute({
    method: 'post', path: '/',
    summary: 'Submit Clinical Assessment', tags: ['RAI-HC'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), templateId: z.string(), responses: z.record(z.any()),
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        id: z.string(), capTriggers: z.array(z.string()), overallScore: z.number().nullable(),
                    })
                }
            }, description: 'Submitted with CAP triggers'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

raiHc.openapi(submitRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    // CAP (Clinical Assessment Protocol) trigger logic
    const triggers: string[] = [];
    const responses = body.responses;

    // Falls risk
    if (responses.falls && parseInt(responses.falls) > 0) triggers.push('CAP_FALLS_RISK');
    // Pressure ulcer risk
    if (responses.pressure_ulcer === 'yes' || responses.pressure_ulcer_risk === 'high') triggers.push('CAP_PRESSURE_ULCER');
    // Depression
    if (responses.depression_rating && parseInt(responses.depression_rating) >= 3) triggers.push('CAP_DEPRESSION');
    // Pain management
    if (responses.pain_frequency === 'daily' || responses.pain_intensity === 'severe') triggers.push('CAP_PAIN');
    // Nutrition
    if (responses.weight_loss === 'yes' || responses.bmi && parseFloat(responses.bmi) < 18.5) triggers.push('CAP_NUTRITION');
    // Cognitive
    if (responses.cps_score && parseInt(responses.cps_score) >= 3) triggers.push('CAP_COGNITIVE');
    // ADL decline
    const adlFields = ['bathing', 'dressing_upper', 'dressing_lower', 'locomotion', 'transfer', 'toilet_use', 'eating'];
    const impairments = adlFields.filter(f => responses[f] && parseInt(responses[f]) >= 3).length;
    if (impairments >= 3) triggers.push('CAP_ADL_DECLINE');

    // Braden scoring (if template is braden)
    let overallScore: number | null = null;
    if (body.templateId === 'braden') {
        const bradenFields = ['sensory_perception', 'moisture', 'activity', 'mobility', 'nutrition', 'friction_shear'];
        overallScore = bradenFields.reduce((sum, f) => sum + (parseInt(responses[f]) || 0), 0);
        if (overallScore <= 12) triggers.push('CAP_HIGH_PRESSURE_RISK');
        else if (overallScore <= 14) triggers.push('CAP_MODERATE_PRESSURE_RISK');
    }

    const record = await prisma.clinicalAssessment.create({
        data: {
            clientId: body.clientId, tenantId,
            type: body.templateId, data: { responses, capTriggers: triggers, overallScore },
        },
    });

    return c.json({ id: record.id, capTriggers: triggers, overallScore }, 200);
});

// GET /client/:clientId — Assessment history
const historyRoute = createRoute({
    method: 'get', path: '/client/{clientId}',
    summary: 'Client Assessment History', tags: ['RAI-HC'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), type: z.string(), createdAt: z.string(), capTriggers: z.array(z.string()),
                    }))
                }
            }, description: 'History'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

raiHc.openapi(historyRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const records = await prisma.clinicalAssessment.findMany({
        where: { tenantId, clientId },
        orderBy: { createdAt: 'desc' },
    });

    const result = records.map((r: any) => ({
        id: r.id, type: r.type, createdAt: r.createdAt,
        capTriggers: r.data?.capTriggers || [],
    }));
    return c.json(result, 200);
});

// GET /caps/:assessmentId — CAP detail
const capsRoute = createRoute({
    method: 'get', path: '/caps/{assessmentId}',
    summary: 'Assessment CAP Triggers', tags: ['RAI-HC'],
    request: { params: z.object({ assessmentId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        capTriggers: z.array(z.string()), recommendations: z.array(z.object({ cap: z.string(), action: z.string() })),
                    })
                }
            }, description: 'CAP detail'
        },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

raiHc.openapi(capsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { assessmentId } = c.req.valid('param');

    const record = await prisma.clinicalAssessment.findFirst({ where: { id: assessmentId, tenantId } });
    if (!record) return c.json({ error: 'Not found' }, 404);

    const triggers = (record as any).data?.capTriggers || [];

    const capActions: Record<string, string> = {
        CAP_FALLS_RISK: 'Implement fall prevention plan. Review home environment. Consider PT referral.',
        CAP_PRESSURE_ULCER: 'Implement pressure ulcer prevention protocol. Apply Braden scale.',
        CAP_DEPRESSION: 'Screen with PHQ-9. Consider mental health referral. Monitor medication adherence.',
        CAP_PAIN: 'Reassess pain management plan. Consider medication review. Track with pain diary.',
        CAP_NUTRITION: 'Refer to dietitian. Monitor weight weekly. Review meal preparation support.',
        CAP_COGNITIVE: 'Implement cognitive stimulation activities. Assess safety for independent living.',
        CAP_ADL_DECLINE: 'Reassess service hours. Consider OT assessment. Update care plan.',
        CAP_HIGH_PRESSURE_RISK: 'Immediate pressure ulcer prevention. Reposition q2h. Specialty mattress.',
        CAP_MODERATE_PRESSURE_RISK: 'Enhanced skin monitoring. Nutritional support. Repositioning schedule.',
    };

    const recommendations = triggers.map((cap: string) => ({
        cap, action: capActions[cap] || 'Review with clinical supervisor.',
    }));

    return c.json({ capTriggers: triggers, recommendations }, 200);
});

export default raiHc;
