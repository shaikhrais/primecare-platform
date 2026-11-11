import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/advanced_theme/advanced_theme_region.dart' as migrated0;
import 'package:flutter_core/advanced_theme/prime_advanced_theme_editor.dart' as migrated1;
import 'package:flutter_core/component_catalogue/prime_component_catalogue.dart' as migrated2;
import 'package:flutter_core/data_controls/prime_data_controls.dart' as migrated3;
import 'package:flutter_core/engine/form_schema_engine.dart' as migrated4;
import 'package:flutter_core/manifest/aura_action_manifest.dart' as migrated5;
import 'package:flutter_core/models/presentation_mode.dart' as migrated6;
import 'package:flutter_core/models/screen.dart' as migrated7;
import 'package:flutter_core/navigation/prime_workspace_navigation.dart' as migrated8;
import 'package:flutter_core/page/prime_page_template.dart' as migrated9;
import 'package:flutter_core/registry/widgets/governance_master_layout.dart' as migrated10;
import 'package:flutter_core/registry/widgets/theme_center_panel.dart' as migrated11;
import 'package:flutter_core/registry/widgets/theme_settings_drawer.dart' as migrated12;
import 'package:flutter_core/routes/auth_error_view.dart' as migrated13;
import 'package:flutter_core/routes/sso_redirect_view.dart' as migrated14;
import 'package:flutter_core/shell_utilities/prime_shell_utilities.dart' as migrated15;
import 'package:flutter_core/src/resilience/system_recovery_mode.dart' as migrated16;
import 'package:flutter_core/theme/theme_center_theme_data.dart' as migrated17;

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
