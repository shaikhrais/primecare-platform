import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/widgets/clinical_article_detail_dialog.dart';
import 'package:primecare_runtime/routes/sso_redirect_view.dart';
import 'package:primecare_runtime/routes/governance_router.dart';
import 'package:primecare_runtime/registry/widgets/governance_master_layout.dart';
void main(){test('all migrated flutter_core app-bar consumers compile',(){expect(<Type>[ClinicalArticleDetailDialog,SsoRedirectView,GovernanceRouter,GovernanceMasterLayout],hasLength(4));});}
