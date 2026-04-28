// Layer: 00_ENTRY_POINT
// Master export file for PrimeCare UI Platform.
// Architecture: Strict 3-File MVC (View, Controller, Model)

// Core Features (The Big 3 MVC)
export 'package:primecare_ui/src/features/features_view.dart';
export 'package:primecare_ui/src/features/features_controller.dart'
    hide ResilientNotifierMixin;
export 'package:primecare_ui/src/features/features_model.dart'
    hide FranchiseOwnerViewModel;

// Design & Theme
export 'package:primecare_ui/src/theme/design_system.dart';
export 'package:primecare_ui/src/theme/primecare_theme.dart';
export 'package:primecare_ui/src/theme/colors.dart';

// Infrastructure & Shared
export 'package:primecare_ui/src/shared/src/result.dart';
export 'package:primecare_ui/src/shared/src/api_client.dart';
export 'package:primecare_ui/src/shared/src/telemetry_service.dart';
export 'package:primecare_ui/src/shared/src/resilience_service.dart';
export 'package:primecare_ui/src/shared/src/self_healing_notifier.dart';
export 'package:primecare_ui/src/shared/src/dashboard_providers.dart';
export 'package:primecare_ui/src/shared/src/legacy_bridge.dart';
export 'package:primecare_ui/src/shared/src/models/core/dashboard_models.dart';
export 'package:primecare_ui/src/shared/src/config/locale_keys.dart';
export 'package:primecare_ui/src/shared/src/models/core/ui_blueprint.dart';
export 'package:primecare_ui/src/shared/src/models/core/data_logistics_hub.dart';
export 'package:primecare_ui/src/warehouse/component_warehouse.dart';
export 'package:primecare_ui/src/screen_registry.dart';
export 'package:primecare_ui/src/engine/screen_engine.dart';
export 'package:primecare_ui/src/platform_governance_audit.dart';

// Frameworks
export 'package:flutter_core/flutter_core.dart' hide AppTheme, tr, ProviderTTL;
export 'package:lucide_icons/lucide_icons.dart';
export 'package:easy_localization/easy_localization.dart' hide TextDirection;

// Reconstructed Components
export 'package:primecare_ui/src/shared/src/core/primecare_components.dart'
    hide ComponentWarehouse;
export 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL, tr, ComponentWarehouse;
export 'package:primecare_ui/src/shared/src/components/primecare_scaffold.dart';
export 'package:primecare_ui/src/shared/src/components/governed_widget.dart';
