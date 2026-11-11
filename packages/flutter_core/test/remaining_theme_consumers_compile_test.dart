import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/advanced_theme/advanced_theme_region.dart' as view0;
import 'package:flutter_core/advanced_theme/prime_advanced_theme_editor.dart' as view1;
import 'package:flutter_core/manifest/action_manifest.dart' as view2;
import 'package:flutter_core/manifest/aura_action_manifest.dart' as view3;
import 'package:flutter_core/models/screen.dart' as view4;
import 'package:flutter_core/navigation/prime_workspace_navigation.dart' as view5;
import 'package:flutter_core/registry/widgets/governance_master_layout.dart' as view6;
import 'package:flutter_core/registry/widgets/theme_settings_drawer.dart' as view7;
import 'package:flutter_core/routes/auth_error_view.dart' as view8;
import 'package:flutter_core/routes/governance_navigator.dart' as view9;
import 'package:flutter_core/routes/governance_router.dart' as view10;
import 'package:flutter_core/routes/sso_redirect_view.dart' as view11;
import 'package:flutter_core/security/shortcuts/quick_access_manager.dart' as view12;
import 'package:flutter_core/src/localization/localization_scaffold.dart' as view13;

void main() { test('all reviewed remaining theme consumers compile', () {
 expect(<Type>[view0.AdvancedThemeTokens, view1.PrimeAdvancedThemeEditor, view2.ActionManifest, view3.AuraActionManifest, view4.ScreenGovernance, view5.WorkspaceNavigationLabels, view6.GovernanceMasterLayout, view7.ThemeSettingsDrawer, view8.AuthErrorView, view9.GovernanceNavigator, view10.GovernanceRouter, view11.SsoRedirectView, view12.QuickAccessManager, view13.LocalizationScaffold],hasLength(14));
 }); }
