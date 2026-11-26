import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/advanced_theme/advanced_theme_region.dart' as view0;
import 'package:primecare_runtime/advanced_theme/prime_advanced_theme_editor.dart' as view1;
import 'package:primecare_runtime/component_catalogue/prime_component_catalogue.dart' as view2;
import 'package:primecare_runtime/dashboard_widgets/prime_dashboard_widgets.dart' as view3;
import 'package:primecare_runtime/data_controls/prime_data_controls.dart' as view4;
import 'package:primecare_runtime/engine/form_schema_engine.dart' as view5;
import 'package:primecare_runtime/manifest/aura_action_manifest.dart' as view6;
import 'package:primecare_runtime/navigation/prime_workspace_navigation.dart' as view7;
import 'package:primecare_runtime/page/prime_page_template.dart' as view8;
import 'package:primecare_runtime/registry/widgets/governance_master_layout.dart' as view9;
import 'package:primecare_runtime/registry/widgets/theme_center_panel.dart' as view10;
import 'package:primecare_runtime/registry/widgets/theme_settings_drawer.dart' as view11;
import 'package:primecare_runtime/routes/sso_redirect_view.dart' as view12;
import 'package:primecare_runtime/work_modules/prime_work_module.dart' as view13;

void main() { test('all reviewed shared-control consumers compile', () {
 expect(<Type>[view0.AdvancedThemeTokens, view1.PrimeAdvancedThemeEditor, view2.CatalogueLabels, view3.PrimeChart, view4.PrimeDataKit, view5.SchemaField, view6.AuraActionManifest, view7.WorkspaceNavigationLabels, view8.PageTemplateMetrics, view9.GovernanceMasterLayout, view10.ThemeCenterPanel, view11.ThemeSettingsDrawer, view12.SsoRedirectView, view13.PrimeWorkModule],hasLength(14));
 }); }
