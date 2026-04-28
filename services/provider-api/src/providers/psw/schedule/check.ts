import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { ROUTE_METADATA } from '@primecare/infrastructure';
import { handleCheckIn, handleCheckOut } from './check-handlers';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CheckEventSchema = z.object({ lat: z.number(), lng: z.number(), accuracy: z.number().optional() });
const ScheduleParamsSchema = z.object({ id: z.string().openapi({ param: { name: 'id', in: 'path' }, example: 'visit-uuid' }) });

const checkInRoute = createRoute({ ...ROUTE_METADATA.PSW_SCHEDULE.CHECK_IN, method: 'post', path: '/{id}/check-in', request: { params: ScheduleParamsSchema, body: { content: { 'application/json': { schema: CheckEventSchema } } } }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'Check-in successful' }, 400: { content: { 'application/json': { schema: z.any() } }, description: 'Validation error (e.g., too far)' }, 404: { description: 'Visit or profile not found' } } });
const checkOutRoute = createRoute({ ...ROUTE_METADATA.PSW_SCHEDULE.CHECK_OUT, method: 'post', path: '/{id}/check-out', request: { params: ScheduleParamsSchema, body: { content: { 'application/json': { schema: CheckEventSchema } } } }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'Check-out successful' }, 404: { description: 'Profile not found' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });

r.openapi(checkInRoute, handleCheckIn);
r.openapi(checkOutRoute, handleCheckOut);

export default r;
