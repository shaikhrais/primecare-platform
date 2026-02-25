import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import visitsRoute from './routes/visits';
import checkRoute from './routes/check';
import offersRoute from './routes/offers';
import availabilityRoute from './routes/availability';
import noShowRoute from './routes/noShow';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.route('/visits', visitsRoute);
r.route('/visits', checkRoute);
r.route('/visits', noShowRoute);
r.route('/offers', offersRoute);
r.route('/availability', availabilityRoute);

export default r;
