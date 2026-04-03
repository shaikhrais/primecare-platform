import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { listUsersRoute, createUserRoute, verifyUserRoute, updateRolesRoute, elevateUserRoute, updateStatusRoute, churnHeatmapRoute, handleListUsers, handleCreateUser, handleVerifyUser, handleUpdateRoles, handleElevateUser, handleUpdateStatus, handleChurnHeatmap } from './users-route-defs';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.openapi(listUsersRoute, handleListUsers);
r.openapi(createUserRoute, handleCreateUser);
r.openapi(verifyUserRoute, handleVerifyUser);
r.openapi(updateRolesRoute, handleUpdateRoles);
r.openapi(elevateUserRoute, handleElevateUser);
r.openapi(updateStatusRoute, handleUpdateStatus);
r.openapi(churnHeatmapRoute, handleChurnHeatmap);

export default r;
