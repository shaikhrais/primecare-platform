// Re-export central registries as the new standard
export { ApiRegistry, DataRegistry, ThemeRegistry } from '../../registries/index';
export { ContentRegistry } from './content';
export { RouteRegistry } from './RouteRegistry';
export { InteractionRegistry, InteractiveElementRegistry, ButtonRegistry, LinkRegistry, InteractionARegistry, UnifiedInteractiveRegistry, CorsRegistry } from '../../registries/index';
export { FormRegistry, getFormById, getFormsByCategory, getFormsWithDependencies, FORM_REGISTRY_COUNT } from '../../registries/FormRegistry';
export { PageRegistry, DashboardRegistry, ListRegistry, HubRegistry, WizardRegistry, ReportRegistry, ToolRegistry, getPageById, getPageBySrNo, getPageByCategoryCode, getPagesByType, getPagesByOwner, getPageTypeStats, getMasterList, PAGE_REGISTRY_COUNT, CATEGORY_PREFIXES } from '../../registries/PageRegistry';
