import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import getProfileRoute from './routes/getProfile';
import updateProfileRoute from './routes/updateProfile';

const user = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// All /v1/user routes require authentication
user.use('*', async (c, next) => {
    const secret = c.env.JWT_SECRET || 'fallback_secret';
    const middleware = requireAuth(secret);
    return await middleware(c, next);
});

user.route('/profile', getProfileRoute);
user.route('/profile', updateProfileRoute);

export default user;
