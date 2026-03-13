// Registries
export * from './registries/ApiRegistry';
export * from './registries/ContentRegistry';
export * from './registries/DataRegistry';
export * from './registries/ThemeRegistry';
export * from './registries/InteractionRegistry';
export * from './registries/InteractiveElementRegistry';
export * from './registries/ButtonRegistry';
export * from './registries/LinkRegistry';
export * from './registries/InteractionARegistry';
export * from './registries/InteractiveRegistry';
export * from './registries/SummaryRegistry';
export * from './registries/FormRegistry';
export * from './registries/PageRegistry';

// Existing
export * from './theme';
export * from './schemas';
import * as AdminRegistry from './apps/web-admin';
import * as MarketingRegistry from './apps/web-marketing';

export { AdminRegistry, MarketingRegistry };
