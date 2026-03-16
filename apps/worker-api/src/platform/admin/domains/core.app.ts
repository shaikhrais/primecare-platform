/**
 * Admin Core Sub-App
 * Users, settings, search, staff-groups, registries, services, scrum, developer
 */
import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import userRoutes from '../users/users.routes';
import settingsRoutes from '../settings/settings.routes';
import searchRoutes from '../search/search.routes';
import staffGroupsRoutes from '../staff-groups/staff-groups.routes';
import registryRoutes from '../registries/registries.routes';
import serviceRoutes from '../services/services.routes';
import scrumRoutes from '../scrum/scrum.routes';
import developerRoutes from '../developer/developer.routes';
import adminActionsRoutes from '../actions/admin-actions.routes';
import referenceDataRoutes from '../reference-data/reference-data.routes';

const core = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

core.route('/users', userRoutes);
core.route('/settings', settingsRoutes);
core.route('/search', searchRoutes);
core.route('/staff-groups', staffGroupsRoutes);
core.route('/registries', registryRoutes);
core.route('/services', serviceRoutes);
core.route('/scrum', scrumRoutes);
core.route('/developer', developerRoutes);
core.route('/actions', adminActionsRoutes);
core.route('/', referenceDataRoutes);

export default core;
