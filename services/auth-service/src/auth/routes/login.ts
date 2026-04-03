import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { LoginSchema } from '../auth.validation';
import { ROUTE_METADATA } from '@primecare/shared-utils';
import { authRateLimit } from '@primecare/shared-utils';
import { handleLogin, handleSwitchRole } from './login-handlers';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();
r.use('/login', authRateLimit);

const loginRoute = createRoute({
    ...ROUTE_METADATA.AUTH.LOGIN, method: 'post', path: '/login',
    request: { body: { content: { 'application/json': { schema: LoginSchema } } } },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ user: z.any(), deviceStatus: z.string().optional(), message: z.string().optional(), token: z.string().optional() }) } }, description: 'Login successful' },
        401: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Unauthorized' },
        403: { content: { 'application/json': { schema: z.object({ error: z.string(), message: z.string().optional() }) } }, description: 'Forbidden/Blocked' },
        500: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Internal server error' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const switchRoleRoute = createRoute({
    ...ROUTE_METADATA.AUTH.SWITCH_ROLE, method: 'post', path: '/switch-role',
    request: { body: { content: { 'application/json': { schema: z.object({ targetRole: z.string() }) } } } },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ token: z.string(), activeRole: z.string() }) } }, description: 'Role switched successfully' },
        401: { description: 'Unauthorized' }, 403: { description: 'Role not assigned to user' }, 404: { description: 'User not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(loginRoute, handleLogin);
r.openapi(switchRoleRoute, handleSwitchRole);

export default r;
