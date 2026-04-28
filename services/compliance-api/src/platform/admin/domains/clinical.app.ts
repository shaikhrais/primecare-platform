/**
 * Admin Clinical Sub-App
 * EVV, consent, authorizations, pharmacy, discharge, clinical autopilot
 */
import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import evvRoutes from '../evv/evv.routes';
import consentRoutes from '../consent/consent.routes';
import authorizationRoutes from '../authorizations/authorizations.routes';
import pharmacyRoutes from '../pharmacy/pharmacy.routes';
import dischargeRoutes from '../discharge/discharge.routes';
import { clinicalAutopilotRoutes } from '../routes/clinical-autopilot.routes';

const clinical = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

clinical.route('/evv', evvRoutes);
clinical.route('/consent', consentRoutes);
clinical.route('/authorizations', authorizationRoutes);
clinical.route('/pharmacy', pharmacyRoutes);
clinical.route('/discharge', dischargeRoutes);
clinical.route('/automation/clinical-autopilot', clinicalAutopilotRoutes);

export default clinical;
