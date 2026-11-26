import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/advanced_theme/advanced_theme_region.dart' as migrated0;
import 'package:primecare_runtime/advanced_theme/prime_advanced_theme_editor.dart' as migrated1;
import 'package:primecare_runtime/component_catalogue/prime_component_catalogue.dart' as migrated2;
import 'package:primecare_runtime/data_controls/prime_data_controls.dart' as migrated3;
import 'package:primecare_runtime/engine/form_schema_engine.dart' as migrated4;
import 'package:primecare_runtime/manifest/aura_action_manifest.dart' as migrated5;
import 'package:primecare_runtime/models/presentation_mode.dart' as migrated6;
import 'package:primecare_runtime/models/screen.dart' as migrated7;
import 'package:primecare_runtime/navigation/prime_workspace_navigation.dart' as migrated8;
import 'package:primecare_runtime/page/prime_page_template.dart' as migrated9;
import 'package:primecare_runtime/registry/widgets/governance_master_layout.dart' as migrated10;
import 'package:primecare_runtime/registry/widgets/theme_center_panel.dart' as migrated11;
import 'package:primecare_runtime/registry/widgets/theme_settings_drawer.dart' as migrated12;
import 'package:primecare_runtime/routes/auth_error_view.dart' as migrated13;
import 'package:primecare_runtime/routes/sso_redirect_view.dart' as migrated14;
import 'package:primecare_runtime/shell_utilities/prime_shell_utilities.dart' as migrated15;
import 'package:primecare_runtime/src/resilience/system_recovery_mode.dart' as migrated16;
import 'package:primecare_runtime/theme/theme_center_theme_data.dart' as migrated17;

void main() {
  test('actual migrated button consumers compile', () {
    final declarations = <Object>[
      migrated0.AdvancedThemeTokens,
      migrated1.PrimeAdvancedThemeEditor,
      migrated2.CatalogueLabels,
      migrated3.PrimeDataKit,
      migrated4.SchemaField,
      migrated5.AuraActionManifest,
      migrated6.buildPresentationScreen,
      migrated7.ScreenGovernance,
      migrated8.WorkspaceNavigationLabels,
      migrated9.PageTemplateMetrics,
      migrated10.GovernanceMasterLayout,
      migrated11.ThemeCenterPanel,
      migrated12.ThemeSettingsDrawer,
      migrated13.AuthErrorView,
      migrated14.SsoRedirectView,
      migrated15.ShellUtilityLabels,
      migrated16.SystemOfflinePanel,
      migrated17.applyPersonalThemeData
    ];
    expect(declarations, hasLength(18));
  });
}
