library;

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:flutter_riverpod/legacy.dart';

// Infrastructure
export 'src/infrastructure/result.dart';
export 'src/infrastructure/api_client.dart';
export 'src/infrastructure/telemetry_service.dart';
export 'src/infrastructure/api_config.dart';
export 'src/infrastructure/resilience_service.dart';
export 'src/infrastructure/dashboard_service.dart';
export 'src/infrastructure/dashboard_providers.dart';
export 'src/infrastructure/legacy_bridge.dart';
export 'src/infrastructure/storage_providers.dart';
export 'src/infrastructure/retry_interceptor.dart';
export 'src/infrastructure/circuit_breaker.dart';

// Models Foundation
export 'src/models/view_model.dart';
export 'src/infrastructure/self_healing_notifier.dart';
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

// Unified Form Registry
export 'src/registry/primecare_form_enum.dart';
export 'src/registry/primecare_form_provider.dart';
export 'src/utils/primecare_formatters.dart';
export 'src/config/locale_keys.dart';

// Registries
export 'src/core/models.dart';
export 'src/core/registry.dart';
export 'src/registry/governance_registry.dart';
export 'src/registry/feature_intake_registry.dart';
