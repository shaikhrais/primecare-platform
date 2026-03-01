import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';
import visitsRoute from './visits';
import checkRoute from './check';
import offersRoute from './offers';
import availabilityRoute from './availability';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.route('/visits', visitsRoute);
r.route('/visits', checkRoute);
r.route('/offers', offersRoute);
r.route('/availability', availabilityRoute);

export default r;
