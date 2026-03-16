/**
 * Admin Content Sub-App
 * Content, DAM, marketing, telehealth
 */
import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import contentRoutes from '../content/content.routes';
import damRoutes from '../dam/dam.routes';
import marketingRoutes from '../marketing/marketing.routes';
import telehealthRoutes from '../telehealth/telehealth.routes';

const content = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

content.route('/', contentRoutes);
content.route('/dam', damRoutes);
content.route('/marketing', marketingRoutes);
content.route('/telehealth', telehealthRoutes);

export default content;
