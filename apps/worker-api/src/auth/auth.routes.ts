import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import registerRoutes from './routes/register';
import loginRoutes from './routes/login';
import sessionRoutes from './routes/session';
import adminRoutes from './routes/admin';
import onboardRoutes from './routes/onboard';

const auth = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

auth.route('/', registerRoutes);
auth.route('/', loginRoutes);
auth.route('/', sessionRoutes);
auth.route('/', adminRoutes);
auth.route('/', onboardRoutes);

export default auth;
