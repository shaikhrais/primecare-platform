// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import { ADMIN_METADATA } from './route_metadata/admin';
import { AUTH_METADATA } from './route_metadata/auth';
import { USER_METADATA, MANAGER_METADATA } from './route_metadata/user_manager';
import { PSW_METADATA } from './route_metadata/psw';
import { SYSTEM_METADATA } from './route_metadata/system';
import { STAFF_METADATA, RN_METADATA } from './route_metadata/staff_rn';
import { CLIENT_METADATA } from './route_metadata/client';
import { COORDINATOR_METADATA } from './route_metadata/coordinator';

export const ROUTE_METADATA = {
    ADMIN_VISITS: ADMIN_METADATA.VISITS,
    ADMIN_EXTRA: ADMIN_METADATA.EXTRA,
    AUTH: AUTH_METADATA,
    USER: USER_METADATA,
    MANAGER: MANAGER_METADATA,
    PSW_SCHEDULE: PSW_METADATA.SCHEDULE,
    PSW_EXTRA: PSW_METADATA.EXTRA,
    SYSTEM: SYSTEM_METADATA,
    STAFF: STAFF_METADATA,
    RN: RN_METADATA,
    CLIENT: CLIENT_METADATA,
    COORDINATOR: COORDINATOR_METADATA,
};
