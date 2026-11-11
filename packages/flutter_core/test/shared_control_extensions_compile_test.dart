import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/data_controls/prime_data_controls.dart' as migrated0;
import 'package:flutter_core/manifest/aura_action_manifest.dart' as migrated1;
import 'package:flutter_core/navigation/prime_workspace_navigation.dart' as migrated2;
import 'package:flutter_core/page/prime_page_template.dart' as migrated3;
import 'package:flutter_core/registry/widgets/governance_master_layout.dart' as migrated4;
import 'package:flutter_core/registry/widgets/theme_settings_drawer.dart' as migrated5;
import 'package:flutter_core/routes/sso_redirect_view.dart' as migrated6;
import 'package:flutter_core/widgets/clinical_article_detail_dialog.dart' as migrated7;
import 'package:flutter_core/widgets/clinical_term_highlighter.dart' as migrated8;
import 'package:flutter_core/work_modules/prime_work_module.dart' as migrated9;

void main() {
  test('actual shared control extension consumers compile', () {
    final declarations = <Object>[
      migrated0.PrimeDataKit,
      migrated1.AuraActionManifest,
      migrated2.WorkspaceNavigationLabels,
      migrated3.PageTemplateMetrics,
      migrated4.GovernanceMasterLayout,
      migrated5.ThemeSettingsDrawer,
      migrated6.SsoRedirectView,
      migrated7.ClinicalArticleDetailDialog,
      migrated8.ClinicalTermHighlighter,
      migrated9.PrimeWorkModule
    ];
    expect(declarations, hasLength(10));
  });
}
