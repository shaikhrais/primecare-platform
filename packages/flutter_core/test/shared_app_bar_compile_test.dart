import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/widgets/clinical_article_detail_dialog.dart';
import 'package:flutter_core/routes/sso_redirect_view.dart';
import 'package:flutter_core/routes/governance_router.dart';
import 'package:flutter_core/registry/widgets/governance_master_layout.dart';
void main(){test('all migrated flutter_core app-bar consumers compile',(){expect(<Type>[ClinicalArticleDetailDialog,SsoRedirectView,GovernanceRouter,GovernanceMasterLayout],hasLength(4));});}
