import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { getSecurityRoute, updateSecurityRoute, listDevicesRoute, authorizeDeviceRoute, revokeDeviceRoute, getDeviceActivityRoute, getForensicTrailsRoute, getDailySummaryRoute, getCorsRoute, updateCorsRoute, verifyIntegrityRoute,
    handleGetSecurity, handleUpdateSecurity, handleListDevices, handleAuthorizeDevice, handleRevokeDevice, handleGetDeviceActivity, handleGetForensicTrails, handleGetDailySummary, handleGetCors, handleUpdateCors, handleVerifyIntegrity
} from './security-route-defs';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.openapi(getSecurityRoute, handleGetSecurity);
r.openapi(updateSecurityRoute, handleUpdateSecurity);
r.openapi(listDevicesRoute, handleListDevices);
r.openapi(authorizeDeviceRoute, handleAuthorizeDevice);
r.openapi(revokeDeviceRoute, handleRevokeDevice);
r.openapi(getDeviceActivityRoute, handleGetDeviceActivity);
r.openapi(getForensicTrailsRoute, handleGetForensicTrails);
r.openapi(getDailySummaryRoute, handleGetDailySummary);
r.openapi(getCorsRoute, handleGetCors);
r.openapi(updateCorsRoute, handleUpdateCors);
r.openapi(verifyIntegrityRoute, handleVerifyIntegrity);

export default r;
