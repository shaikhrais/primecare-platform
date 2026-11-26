import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/advanced_theme/prime_advanced_theme_editor.dart' as migrated0;
import 'package:primecare_runtime/component_catalogue/prime_component_catalogue.dart' as migrated1;
import 'package:primecare_runtime/dashboard_pages/prime_dashboard_page.dart' as migrated2;
import 'package:primecare_runtime/dashboard_pages/prime_record_page.dart' as migrated3;
import 'package:primecare_runtime/dashboard_widgets/prime_dashboard_widgets.dart' as migrated4;
import 'package:primecare_runtime/data_controls/prime_data_controls.dart' as migrated5;
import 'package:primecare_runtime/engine/form_schema_engine.dart' as migrated6;
import 'package:primecare_runtime/manifest/action_manifest.dart' as migrated7;
import 'package:primecare_runtime/manifest/aura_action_manifest.dart' as migrated8;
import 'package:primecare_runtime/models/presentation_mode.dart' as migrated9;
import 'package:primecare_runtime/models/screen.dart' as migrated10;
import 'package:primecare_runtime/navigation/prime_workspace_navigation.dart' as migrated11;
import 'package:primecare_runtime/page/prime_page_template.dart' as migrated12;
import 'package:primecare_runtime/registry/widgets/governance_master_layout.dart' as migrated13;
import 'package:primecare_runtime/registry/widgets/responsive_split_dashboard.dart' as migrated14;
import 'package:primecare_runtime/registry/widgets/theme_center_panel.dart' as migrated15;
import 'package:primecare_runtime/registry/widgets/theme_settings_drawer.dart' as migrated16;
import 'package:primecare_runtime/routes/auth_callback_view.dart' as migrated17;
import 'package:primecare_runtime/routes/auth_error_view.dart' as migrated18;
import 'package:primecare_runtime/routes/clinic_login_bridge.dart' as migrated19;
import 'package:primecare_runtime/routes/governance_navigator.dart' as migrated20;
import 'package:primecare_runtime/routes/governance_router.dart' as migrated21;
import 'package:primecare_runtime/routes/sso_redirect_view.dart' as migrated22;
import 'package:primecare_runtime/security/shortcuts/quick_access_manager.dart' as migrated23;
import 'package:primecare_runtime/shell_utilities/prime_shell_utilities.dart' as migrated24;
import 'package:primecare_runtime/src/localization/localization_scaffold.dart' as migrated25;
import 'package:primecare_runtime/src/resilience/app_error_boundary.dart' as migrated26;
import 'package:primecare_runtime/src/resilience/system_recovery_mode.dart' as migrated27;
import 'package:primecare_runtime/widgets/clinical_article_detail_dialog.dart' as migrated28;
import 'package:primecare_runtime/work_modules/prime_work_module.dart' as migrated29;
import 'package:primecare_runtime/workspace/prime_workspace_layout.dart' as migrated30;

void main() {
  test('all 31 migrated core libraries compile with the shared primitives', () {
    final declarations = <Object>[
      migrated0.PrimeAdvancedThemeEditor,
      migrated1.CatalogueLabels,
      migrated2.PrimeDashboardPage,
      migrated3.PrimeRecordPage,
      migrated4.PrimeChart,
      migrated5.PrimeDataKit,
      migrated6.SchemaField,
      migrated7.ActionManifest,
      migrated8.AuraActionManifest,
      migrated9.buildPresentationScreen,
      migrated10.ScreenGovernance,
      migrated11.WorkspaceNavigationLabels,
      migrated12.PageTemplateMetrics,
      migrated13.GovernanceMasterLayout,
      migrated14.ResponsiveSplitDashboard,
      migrated15.ThemeCenterPanel,
      migrated16.ThemeSettingsDrawer,
      migrated17.AuthCallbackView,
      migrated18.AuthErrorView,
      migrated19.ClinicLoginBridge,
      migrated20.GovernanceNavigator,
      migrated21.GovernanceRouter,
      migrated22.SsoRedirectView,
      migrated23.QuickAccessManager,
      migrated24.ShellUtilityLabels,
      migrated25.LocalizationScaffold,
      migrated26.AppErrorBoundary,
      migrated27.SystemOfflinePanel,
      migrated28.ClinicalArticleDetailDialog,
      migrated29.PrimeWorkModule,
      migrated30.WorkspaceHandleLabels
    ];
    expect(declarations, hasLength(31));
  });
}
