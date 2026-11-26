import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/widgets/clinical_article_detail_dialog.dart';
import 'package:primecare_runtime/manifest/action_manifest.dart';
import 'package:primecare_runtime/manifest/aura_action_manifest.dart';
import 'package:primecare_runtime/routes/governance_navigator.dart';
import 'package:primecare_runtime/registry/widgets/governance_master_layout.dart';
import 'package:primecare_runtime/registry/widgets/theme_center_panel.dart';
import 'package:primecare_runtime/security/shortcuts/quick_access_manager.dart';

void main(){
  test('all migrated flutter_core snack-bar consumers compile',(){
    expect(<Type>[ClinicalArticleDetailDialog,ActionManifest,AuraActionManifest,GovernanceNavigator,GovernanceMasterLayout,ThemeCenterPanel,QuickAccessManager],hasLength(7));
  });
}
