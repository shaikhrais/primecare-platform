library primecare_ui;

export 'package:flutter_core/flutter_core.dart';

// Add factory-specific exports here as needed
export 'src/features/common_forms/domain/review_fleet_maintenance_form_view_model.dart';
export 'src/features/common_forms/domain/schedule_facility_maintenance_form_view_model.dart';
export 'src/features/common_ui/domain/main_project_selection_view_model.dart';
export 'src/theme/prime_theme.dart';
export 'src/theme/vision_modes.dart';
export 'src/theme/vision_provider.dart';
export 'src/components/clinical_glass_panel.dart';
export 'src/components/prime_components.dart';
export 'src/components/telemetry_hud.dart';

export 'src/components/layouts/master_layout.dart';
export 'src/components/navigation/primecare_sidebar.dart';

export 'src/governance_bootstrapper.dart';
export 'src/governance/automated_audit_engine.dart';
export 'src/registry/screen_registry.dart'
    show ScreenRegistry, ScreenAuditReport;
export 'src/shared/src/integration/platform_governance_registry.dart';

export 'src/governance/dashboard_infrastructure.dart';
export 'src/governance/integrity_service.dart';

export 'src/screens/common/shared_screen_stubs.dart';
export 'src/routes/shared_routes.dart';
