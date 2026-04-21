// Re-export central registries as the new standard
export { ApiRegistry, DataRegistry, ThemeRegistry } from '../../registries/index';
export { ContentRegistry } from './content';
export { RouteRegistry } from './RouteRegistry';
export { ButtonRegistry, LinkRegistry, InteractionARegistry, InteractiveElementRegistry, InteractionRegistry, UnifiedInteractiveRegistry, getButtonById, getButtonsByRole, getButtonsByModule, getButtonsForPage, getLinksForRole, getTouchpointsForSweep, getInteractionsByTrigger, BUTTON_REGISTRY_COUNT } from '../../registries/01_I_button_registry';
export { CorsRegistry } from '../../registries/01_I_cors_registry';
export { FormRegistry, getFormById, getFormsByCategory, getFormsWithDependencies, FORM_REGISTRY_COUNT } from '../../registries/01_I_form_registry';
export { PageRegistry, HomeRegistry, ListRegistry, HubRegistry, WizardRegistry, ReportRegistry, ToolRegistry, getPageById, getPageBySrNo, getPageByCategoryCode, getPagesByType, getPagesByOwner, getPageTypeStats, getMasterList, PAGE_REGISTRY_COUNT, CATEGORY_PREFIXES, MASTER_REGISTRY, MASTER_REGISTRY_COUNT, getMasterEntry, getAssociates, getMasterByType, getMasterByOwner, FILE_IDENTITY_MAP, FILE_ASSOCIATE_MAP } from '../../registries/01_I_page_registry';
export { PageActionRegistry } from '../../registries/01_I_page_action_registry';
