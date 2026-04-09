import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { cors } from 'hono/cors';
import registerRoutes from './routes/register';
import loginRoutes from './routes/login';
import sessionRoutes from './routes/session';
import adminRoutes from './routes/admin';
import onboardRoutes from './routes/onboard';
import osmRoutes from './routes/osm';

import forgotPasswordRoutes from './routes/forgot-password';

const auth = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

auth.route('/', registerRoutes);
auth.route('/', loginRoutes);
auth.route('/', sessionRoutes);
auth.route('/', adminRoutes);
auth.route('/', onboardRoutes);
auth.route('/', osmRoutes);
auth.route('/', forgotPasswordRoutes);

export default auth;
