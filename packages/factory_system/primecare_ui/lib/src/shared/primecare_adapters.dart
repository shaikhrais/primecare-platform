library;

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:flutter_riverpod/legacy.dart';
export 'package:flutter_core/flutter_core.dart'
    hide GovernanceRegistry, ProviderTTL;

// Infrastructure
export 'src/result.dart';
export 'src/api_client.dart';
export 'src/telemetry_service.dart';
export 'src/api_config.dart';
export 'src/resilience_service.dart';
export 'src/dashboard_service.dart';
export 'src/dashboard_providers.dart';
export 'src/legacy_bridge.dart';
export 'src/storage_providers.dart';
export 'src/retry_interceptor.dart';
export 'src/circuit_breaker.dart';

// Models Foundation
export 'src/models/view_model.dart';
export 'src/self_healing_notifier.dart';
export 'src/models/dashboard_view_model.dart';

// Core Domain Models
export 'src/models/core/render_config.dart';
export 'src/models/core/dashboard_models.dart';
export 'src/models/core/ui_blueprint.dart';
export 'src/models/core/intelligence_insight.dart';
export 'src/models/core/scheduler_models.dart';
export 'src/models/core/data_logistics_hub.dart';
export 'src/models/core/domain_response.dart';

// UI Adapters
export 'src/generic/dynamic_screen_adapter.dart';
export 'src/generic/dynamic_adapter_provider.dart';

// Unified Form DashboardRegistry
export 'src/registry/primecare_form_enum.dart';
export 'src/registry/primecare_form_provider.dart';
export 'src/utils/primecare_formatters.dart';
export 'src/config/locale_keys.dart';
export '../screen_registry.dart';
export 'src/core/primecare_components.dart';
export '../primecare_ui.dart';

// Extensions
export '../utils/async_result_extension.dart';

// --- End of consolidated header ---
