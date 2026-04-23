// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_rn_dashboard_screen.dart';

class RnDashboardIntent extends AppScreenIntent {
  const RnDashboardIntent();

  @override
  String get name => 'rn_dashboard';

  @override
  String get route => '/offices/clinical/roles/rn/dashboard';

  @override
  String get title => 'Rn Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.rn;

  @override
  dynamic get provider => rnDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const RnDashboardScreen();
}

