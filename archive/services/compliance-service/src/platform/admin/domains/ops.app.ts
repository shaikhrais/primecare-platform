/**
 * Admin Operations Sub-App
 * Visits, timesheets, incidents, booking-requests, clients, leads, reports,
 * referrals, notifications, documents
 */
import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import visitRoutes from '../visits/visits.routes';
import timesheetRoutes from '../timesheets/timesheets.routes';
import incidentRoutes from '../incidents/incidents.routes';
import bookingRequestRoutes from '../booking-requests/booking-requests.routes';
import clientRoutes from '../clients/clients.routes';
import leadRoutes from '../leads/leads.routes';
import reportRoutes from '../reports/export.routes';
import referralRoutes from '../referrals/referrals.routes';
import notificationRoutes from '../notifications/notifications.routes';
import documentRoutes from '../documents/documents.routes';

const ops = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

ops.route('/visits', visitRoutes);
ops.route('/timesheets', timesheetRoutes);
ops.route('/incidents', incidentRoutes);
ops.route('/booking-requests', bookingRequestRoutes);
ops.route('/clients', clientRoutes);
ops.route('/leads', leadRoutes);
ops.route('/reports', reportRoutes);
ops.route('/referrals', referralRoutes);
ops.route('/notifications', notificationRoutes);
ops.route('/documents', documentRoutes);

export default ops;
