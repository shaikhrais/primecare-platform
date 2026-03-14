import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { listBookingsRoute, createBookingRoute, updateBookingRoute, createBookingRequestRoute, handleListBookings, handleCreateBooking, handleUpdateBooking, handleCreateBookingRequest } from './bookings-defs';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.openapi(listBookingsRoute, handleListBookings);
r.openapi(createBookingRoute, handleCreateBooking);
r.openapi(updateBookingRoute, handleUpdateBooking);
r.openapi(createBookingRequestRoute, handleCreateBookingRequest);

export default r;
