// Layer: 00_ENTRY_POINT
// Master export file for backwards compatibility.
// Prefer using specific nested libraries instead:
// import 'package:primecare_ui/components.dart';
// import 'package:primecare_ui/screens.dart';

export 'package:primecare_ui/components.dart';
export 'package:primecare_ui/forms.dart';
export 'package:primecare_ui/layouts.dart';
export 'package:primecare_ui/screens.dart';
export 'package:primecare_ui/theme.dart';
export 'package:primecare_ui/adapters.dart';
export 'package:primecare_adapters/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;
export 'package:flutter_core/flutter_core.dart' hide AppTheme;

// UI Discovery Tier (AssemblyLine Metadata)
export 'package:primecare_ui/src/assembly_line/assembly_line.dart';
export 'package:primecare_ui/src/fabricator/component_fabricator.dart';
export 'package:primecare_ui/src/warehouse/component_warehouse.dart';

// Global Shared Screens (Common)
export 'package:primecare_ui/src/screens/common/global_settings.dart';
export 'package:primecare_ui/src/screens/common/global_profile.dart';
export 'package:primecare_ui/src/screens/common/not_found_screen.dart';
export 'package:primecare_ui/src/routes/shared_routes.dart';
export 'package:primecare_ui/src/screens/common/document_vault.dart';
export 'package:primecare_ui/src/screens/common/messaging_hub.dart';
export 'package:primecare_ui/src/screens/common/notification_center.dart';
export 'package:primecare_ui/src/screens/common/dynamic_role_dashboard_screen.dart';
export 'package:primecare_ui/src/screens/common/primecare_report_screen.dart';
export 'package:primecare_ui/src/screens/common/aura_interactive_sheet.dart';
export 'package:primecare_ui/src/screens/common/history_logs.dart';
export 'package:primecare_ui/src/screens/common/messaging.dart';
export 'package:primecare_ui/src/screens/common/profile_settings.dart';
export 'package:primecare_ui/src/screens/common/splash_screen.dart';
export 'package:primecare_ui/src/screens/common/subscription_upgrade_screen.dart';
export 'package:primecare_ui/src/screens/common/primecare_horizon_scheduler_screen.dart';
export 'package:primecare_ui/src/screens/common/institutional_scheduler_screen.dart';
export 'package:primecare_ui/src/features/system_verification_dashboard/presentation/widgets/system_verification_dashboard_screen.dart';
export 'package:primecare_ui/src/components/governance_blueprint_hud.dart';

export 'package:primecare_ui/src/components/dashboards/prime_care_disk_usage_card.dart';

// Developer Samples (Reference Implementations)

// Registry & Governance
export 'package:primecare_ui/src/features/features_manifest.dart';
export 'package:primecare_ui/src/registry/dynamic_adapter_resolver.dart';
export 'package:primecare_ui/src/registry/governance_bootstrapper.dart';
export 'package:primecare_ui/src/registry/platform_governance_audit.dart';
export 'package:primecare_ui/src/registry/screen_registry.dart';
export 'package:primecare_ui/src/registry/blueprint_seeder.dart';
export 'package:primecare_ui/src/utils/async_result_extension.dart';

// Layer: 06_NEW_FRAMEWORK
export 'src/features/dashboard/dynamic_dashboard.dart';
