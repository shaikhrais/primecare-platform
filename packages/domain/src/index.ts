// Registries
export * from './registries/01_I_content_registry';
export * from './registries/01_I_data_registry';
export * from './registries/01_I_theme_registry';
export * from './registries/01_I_button_registry';
export * from './registries/01_I_form_registry';
export * from './registries/01_I_page_registry';
export * from './registries/01_I_page_action_registry';
export * from './registries/01_I_cors_registry';
export * from './registries/01_I_permission_registry';
export * from './registries/01_I_feature_integrity_checker';
export * from './registries/01_I_page_section_registry';

// Existing - Standardized
export * from './01_I_theme_config';
export * from './02_M_zod_schemas';
export * from './01_I_constants';

// Role-Based Portals
import * as AdminRegistry from './apps/web-admin';
import * as MarketingRegistry from './apps/web-marketing';

export { AdminRegistry, MarketingRegistry };

// Auto-generated OpenAPI types 
export type { paths as ApiPaths } from './02_M_openapi_types';
