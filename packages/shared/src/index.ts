// Registries
export * from './registries/ApiRegistry';
export * from './registries/ContentRegistry';
export * from './registries/DataRegistry';

// Existing
export * from './theme';
export * from './schemas';
import * as PswRegistry from './apps/mobile-psw';
import * as ClientRegistry from './apps/mobile-client';
import * as AdminRegistry from './apps/web-admin';
import * as MarketingRegistry from './apps/web-marketing';

import * as MobileAdminRegistry from './apps/mobile-admin';

export { PswRegistry, ClientRegistry, AdminRegistry, MarketingRegistry, MobileAdminRegistry };
