// Registries
export * from './registries/ApiRegistry';
export * from './registries/ContentRegistry';
export * from './registries/DataRegistry';
export * from './registries/ThemeRegistry';
export * from './registries/ButtonRegistry';
export * from './registries/FormRegistry';
export * from './registries/PageRegistry';
export * from './registries/PageActionRegistry';
export * from './registries/PermissionRegistry';
export * from './registries/FeatureIntegrityChecker';

// Existing
export * from './theme';
export * from './schemas';
import * as AdminRegistry from './apps/web-admin';
import * as MarketingRegistry from './apps/web-marketing';

export { AdminRegistry, MarketingRegistry };
