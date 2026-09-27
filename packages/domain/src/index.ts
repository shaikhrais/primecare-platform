// Governance - Category: service | Purpose: Registries Existing - Standardized Role-Based Portals
// Registries
export * from './contracts';
export * from './registries/content_registry';
export * from './registries/data_registry';
export * from './registries/theme_registry';
export * from './registries/button_registry';
export * from './registries/form_registry';
export * from './registries/page_registry';
export * from './registries/page_action_registry';
export * from './registries/cors_registry';
export * from './registries/permission_registry';
export * from './registries/feature_integrity_checker';
export * from './registries/page_section_registry';
export * from './registries/ApiRegistry';
// Existing - Standardized
export * from './theme_config';
export * from './zod_schemas';
export * from './constants';

// Role-Based Portals
import * as AdminRegistry from './apps/web-admin';
import * as MarketingRegistry from './apps/web-marketing';

export { AdminRegistry, MarketingRegistry };

// Auto-generated OpenAPI types 
export type { paths as ApiPaths } from './openapi_types';
