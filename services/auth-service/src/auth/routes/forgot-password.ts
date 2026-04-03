import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ForgotPasswordSchema } from '../auth.validation';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const forgotPasswordRoute = createRoute({
    method: 'post',
    path: '/forgot-password',
    summary: 'Request Password Reset',
    description: 'Initiates a password reset flow by email.',
    tags: ['Auth'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: ForgotPasswordSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ success: z.boolean(), message: z.string() }) } },
            description: 'Password reset instructions sent successfully',
        },
        500: { description: 'Server Error' },
    },
});

r.openapi(forgotPasswordRoute, async (c) => {
    const { email } = c.req.valid('json');

    // MOCK RESPONSE: Since email delivery is outside the scope of this testing pass,
    // we simply yield a 200 OK to successfully complete the Flutter Mobile UI workflow natively.
    return c.json({ success: true, message: 'If that email matches an account, password reset instructions have been sent.' }, 200);
});

export default r;
