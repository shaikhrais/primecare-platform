// Registries
export * from './registries/ApiRegistry';
export * from './registries/ContentRegistry';
export * from './registries/DataRegistry';

// Existing
export * from './theme';
export * from './schemas';
import * as AdminRegistry from './apps/web-admin';
import * as MarketingRegistry from './apps/web-marketing';

export { AdminRegistry, MarketingRegistry };
