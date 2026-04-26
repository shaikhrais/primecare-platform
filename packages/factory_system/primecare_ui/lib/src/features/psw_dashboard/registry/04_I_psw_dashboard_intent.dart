// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_psw_dashboard_screen.dart';

class PswDashboardIntent extends AppScreenIntent {
  PswDashboardIntent();

  @override
  String get name => 'psw_dashboard';

  @override
  String get route => '/offices/clinical/roles/psw/dashboard';

  @override
  String get title => 'dashboards.psw.title';

  @override
  PlatformRole get requiredRole => PlatformRole.psw;

  @override
  dynamic get provider => pswDashboardAdapterProvider;

  @override
  List<String> get componentLabels => [
    'dashboards.psw.labels.dashboards_psw_labels_aura_hud',
    'dashboards.psw.labels.dashboards_psw_labels_clinical_summary',
    'dashboards.psw.labels.dashboards_psw_labels_care_plan_checklist',
    'dashboards.psw.labels.dashboards_psw_labels_incident_quick_report',
  ];

  @override
  Widget build(BuildContext context) => const PswDashboardScreen();
}
