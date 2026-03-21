import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import type { Bindings, Variables } from '../bindings';

export const behavioralModule = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const BehaviorStrikeBody = z.object({
    workerId: z.string().uuid(),
    infractionType: z.enum(['missed_evv', 'late_arrival', 'dropped_shift', 'patient_complaint'])
});

behavioralModule.openapi(
    createRoute({
        method: 'post',
        path: '/strike',
        tags: ['Embedded Mentor'],
        summary: 'Log a behavioral infraction and evaluate retraining requirements mathematically',
        request: {
            body: {
                content: { 'application/json': { schema: BehaviorStrikeBody } }
            }
        },
        responses: {
            200: {
                description: 'TrustScore decayed successfully. Retraining constraints calculated.',
                content: { 'application/json': { 
                    schema: z.object({ newTrustScore: z.number(), isLockedForRetraining: z.boolean(), message: z.string() }) 
                } }
            },
            404: {
                description: 'User not found',
                content: { 'application/json': { 
                    schema: z.object({ newTrustScore: z.number(), isLockedForRetraining: z.boolean(), message: z.string() }) 
                } }
            }
        }
    }),
    async (c) => {
        const db = c.get('prisma');
        const { workerId, infractionType } = c.req.valid('json');

        // Fetch User constraints
        const profile = await db.pswProfile.findUnique({ where: { userId: workerId }});
        if (!profile) return c.json({ newTrustScore: 0, isLockedForRetraining: false, message: 'Invalid Worker' }, 404);

        // Algorithmic decay calculation based on corporate vulnerability
        let decayAmount = 0;
        switch(infractionType) {
            case 'missed_evv': decayAmount = 15; break;          // Compliance breach
            case 'late_arrival': decayAmount = 5; break;         // Minor performance issue
            case 'dropped_shift': decayAmount = 25; break;       // Severe operational impact
            case 'patient_complaint': decayAmount = 30; break;   // Legal liability risk
        }

        const newScore = Math.max(0, profile.trustScore - decayAmount);
        
        // If the trust score falls below 70, the Mentor physically locks the user's app layout
        const requiresLockout = newScore < 70;

        await db.pswProfile.update({
            where: { userId: workerId },
            data: { 
                trustScore: newScore,
                isLockedForRetraining: requiresLockout
            }
        });

        return c.json({
            newTrustScore: newScore,
            isLockedForRetraining: requiresLockout,
            message: requiresLockout 
                ? 'Trust Score breached critical baseline. Physical retraining lockout engaged globally.'
                : 'Trust Score decayed. Warning issued to Field Worker.'
        }, 200);
    }
);
