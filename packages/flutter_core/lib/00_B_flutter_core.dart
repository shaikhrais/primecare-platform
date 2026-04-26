// Layer: 00_ENTRY_POINT
// Master export file for flutter_core.
export 'package:flutter/material.dart';
export 'package:primecare_adapters/primecare_adapters.dart'
    hide
        architecturePurposeProvider,
        databaseReportProvider,
        isOnlineProvider,
        ProviderTTL;
export 'package:easy_localization/easy_localization.dart';
// export 'package:primecare_ui/primecare_ui.dart' hide AppTheme;

export '01_I_adapter_providers.dart';
export '01_I_auth_service.dart';
export '01_I_dashboard_providers.dart'
    hide dashboardServiceProvider, dashboardMetricsProvider;
export '01_I_domain_service.dart';
export '01_I_dynamic_page_providers.dart';
export '01_I_preference_service.dart';
export '01_I_provider_service.dart';
export 'routes/01_I_route_guard.dart';
export 'routes/01_I_governance_navigator.dart';
export 'registry/01_I_governance_registry.dart';
export 'registry/01_I_auditor_blueprint.dart';
export 'registry/01_I_platform_role.dart';
export 'registry/intents/01_I_app_screen_intent.dart';
export 'registry/widgets/01_I_governance_skeleton.dart';

export 'src/localization/01_B_language_provider.dart';
export 'src/resilience/01_I_app_error_boundary.dart';
export 'src/resilience/01_I_system_recovery_mode.dart';
export 'src/resilience/01_I_system_recovery_manager.dart';
export 'src/resilience/01_I_mechanical_repair_kit.dart';
export 'src/resilience/01_I_restart_wrapper.dart';
export 'src/resilience/01_I_connectivity_service.dart';
export 'src/resilience/01_I_provider_ttl.dart';
export 'src/resilience/01_I_service_modulation_governor.dart';
export 'src/resilience/01_I_widget_modulation_governor.dart';
export 'config/01_I_resilience_config.dart';
export '01_I_verification_service.dart';
export '01_I_verification_providers.dart'
    hide architecturePurposeProvider, databaseReportProvider;

// Mission-critical symbols for standardized Notifiers and Resilience
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'src/resilience/01_I_resilient_notifier_mixin.dart';

export 'package:lucide_icons/lucide_icons.dart';

export 'providers/03_D_portal_providers.dart';
export 'providers/03_D_user_management_provider.dart';

export 'config/01_I_data_source_mode.dart';
export 'config/01_I_feature_flags.dart';
export 'models/01_I_screen.dart';
export 'config/01_I_screen_breakpoints.dart';
export 'config/01_I_adaptive_scaling_config.dart';
export 'config/01_I_navigation_registry.dart';
export 'models/01_I_navigation_item.dart';

export 'manifest/01_I_action_manifest.dart';

export 'network/01_I_error_mapper.dart';
export 'registry/01_I_file_registry.dart';
export 'registry/01_I_screen_data_registry.dart';
export 'routes/groups/01_I_admin_routes.dart';
export 'routes/groups/01_I_business_development_routes.dart';
export 'routes/groups/01_I_client_routes.dart';
export 'routes/groups/01_I_clinical_routes.dart';
export 'routes/groups/01_I_corporate_routes.dart';
export 'routes/groups/01_I_franchise_routes.dart';
export 'routes/groups/01_I_marketing_routes.dart';
export 'routes/groups/01_I_support_routes.dart';
export 'routes/groups/01_I_office_routes.dart';
export 'routes/groups/01_I_common_routes.dart';
export 'theme/01_I_app_theme.dart';

// Dashboards and ViewModels are now consolidated in primecare_adapters
// Direct exports from local features have been removed to maintain decoupling.

export '01_I_report_service.dart';
export '01_I_report_providers.dart';
export '01_I_intelligence_service.dart';
export '01_I_intelligence_providers.dart';
export '01_I_aura_command_service.dart';
export '01_I_aura_pulse_service.dart';
export '01_I_aura_providers.dart';

// Institutional Scheduler
export 'src/services/01_I_scheduler_service.dart';
export '01_I_scheduler_providers.dart';
export 'src/models/02_M_aura_intent.dart';
export 'src/models/02_M_aura_event.dart';

// Presentation ViewModels and Adapters have been relocated to primecare_adapters and primecare_ui.
// Direct exports from local features have been removed to maintain decoupling.

export 'src/utils/01_I_prime_logger.dart';
export '01_I_aura_behavioral_telemetry.dart';
