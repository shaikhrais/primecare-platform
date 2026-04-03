import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import visitsRoute from './visits';
import checkRoute from './check';
import offersRoute from './offers';
import availabilityRoute from './availability';
import marketplaceRoute from './marketplace';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.route('/visits', visitsRoute);
r.route('/visits', checkRoute);
r.route('/offers', offersRoute);
r.route('/availability', availabilityRoute);
r.route('/marketplace', marketplaceRoute);

export default r;
