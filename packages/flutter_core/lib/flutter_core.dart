// Layer: 00_ENTRY_POINT
// Master export file for flutter_core.
export 'package:flutter/material.dart';
export 'package:primecare_adapters/primecare_adapters.dart'
    hide
        architecturePurposeProvider,
        databaseReportProvider,
        isOnlineProvider,
        ProviderTTL;
export 'package:easy_localization/easy_localization.dart' hide TextDirection;
// export 'package:primecare_ui/primecare_ui.dart' hide AppTheme;

export 'adapter_providers.dart';
export 'auth_service.dart';
export 'dashboard_providers.dart'
    hide dashboardServiceProvider, dashboardMetricsProvider;
export 'domain_service.dart';
export 'dynamic_page_providers.dart';
export 'preference_service.dart';
export 'provider_service.dart';
export 'routes/route_guard.dart';
export 'routes/governance_navigator.dart';
export 'registry/governance_registry.dart';
export 'registry/auditor_blueprint.dart';
export 'registry/platform_role.dart';
export 'registry/intents/app_screen_intent.dart';
export 'registry/widgets/governance_skeleton.dart';

export 'src/localization/language_provider.dart';
export 'src/resilience/app_error_boundary.dart';
export 'src/resilience/system_recovery_mode.dart';
export 'src/resilience/system_recovery_manager.dart';
export 'src/resilience/mechanical_repair_kit.dart';
export 'src/resilience/restart_wrapper.dart';
export 'src/resilience/connectivity_service.dart';
export 'src/resilience/provider_ttl.dart';
export 'src/resilience/service_modulation_governor.dart';
export 'src/resilience/widget_modulation_governor.dart';
export 'config/resilience_config.dart';
export 'verification_service.dart';
export 'verification_providers.dart'
    hide architecturePurposeProvider, databaseReportProvider;

// Mission-critical symbols for standardized Notifiers and Resilience
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'src/resilience/resilient_notifier_mixin.dart';

export 'package:lucide_icons/lucide_icons.dart';

export 'providers/portal_providers.dart';
export 'providers/user_management_provider.dart';

export 'config/data_source_mode.dart';
export 'config/feature_flags.dart';
export 'models/screen.dart';
export 'config/screen_breakpoints.dart';
export 'config/adaptive_scaling_config.dart';
export 'config/navigation_registry.dart';
export 'models/navigation_item.dart';

export 'manifest/action_manifest.dart';

export 'network/error_mapper.dart';
export 'registry/file_registry.dart';
export 'registry/screen_data_registry.dart';
export 'routes/groups/admin_routes.dart';
export 'routes/groups/business_development_routes.dart';
export 'routes/groups/client_routes.dart';
export 'routes/groups/clinical_routes.dart';
export 'routes/groups/corporate_routes.dart';
export 'routes/groups/franchise_routes.dart';
export 'routes/groups/marketing_routes.dart';
export 'routes/groups/support_routes.dart';
export 'routes/groups/office_routes.dart';
export 'routes/groups/common_routes.dart';
export 'theme/app_theme.dart';

// Dashboards and ViewModels are now consolidated in primecare_adapters
// Direct exports from local features have been removed to maintain decoupling.

export 'report_service.dart';
export 'report_providers.dart';
export 'intelligence_service.dart';
export 'intelligence_providers.dart';
export 'aura_command_service.dart';
export 'aura_pulse_service.dart';
export 'aura_providers.dart';

// Institutional Scheduler
export 'src/services/scheduler_service.dart';
export 'scheduler_providers.dart';
export 'src/models/aura_intent.dart';
export 'src/models/aura_event.dart';

// Presentation ViewModels and Adapters have been relocated to primecare_adapters and primecare_ui.
// Direct exports from local features have been removed to maintain decoupling.

export 'src/utils/prime_logger.dart';
export 'aura_behavioral_telemetry.dart';
