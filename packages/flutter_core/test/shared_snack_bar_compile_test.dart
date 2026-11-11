import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/widgets/clinical_article_detail_dialog.dart';
import 'package:flutter_core/manifest/action_manifest.dart';
import 'package:flutter_core/manifest/aura_action_manifest.dart';
import 'package:flutter_core/routes/governance_navigator.dart';
import 'package:flutter_core/registry/widgets/governance_master_layout.dart';
import 'package:flutter_core/registry/widgets/theme_center_panel.dart';
import 'package:flutter_core/security/shortcuts/quick_access_manager.dart';

void main(){
  test('all migrated flutter_core snack-bar consumers compile',(){
    expect(<Type>[ClinicalArticleDetailDialog,ActionManifest,AuraActionManifest,GovernanceNavigator,GovernanceMasterLayout,ThemeCenterPanel,QuickAccessManager],hasLength(7));
  });
}
