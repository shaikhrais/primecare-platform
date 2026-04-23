// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_psw_dashboard_screen.dart';

class PswDashboardIntent extends AppScreenIntent {
  const PswDashboardIntent();

  @override
  String get name => 'psw_dashboard';

  @override
  String get route => '/offices/clinical/roles/psw/dashboard';

  @override
  String get title => 'Psw Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.psw;

  @override
  dynamic get provider => pswDashboardAdapterProvider;

  @override
  List<String> get componentLabels => ['Aura HUD', 'Clinical Summary', 'Care Plan Checklist', 'Incident Quick-Report'];

  @override
  Widget build(BuildContext context) => const PswDashboardScreen();
}

