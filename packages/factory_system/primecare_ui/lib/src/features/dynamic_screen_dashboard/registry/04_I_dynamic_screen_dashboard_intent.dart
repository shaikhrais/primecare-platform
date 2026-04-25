// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_dynamic_screen_dashboard_screen.dart';

class DynamicScreenDashboardIntent extends AppScreenIntent {
  DynamicScreenDashboardIntent();

  @override
  String get name => 'dynamic_screen_dashboard';

  @override
  String get route => '/offices/corporate/roles/dynamic_screen/dashboard';

  @override
  String get title => 'Dynamic Screen Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.dynamicScreen;

  @override
  dynamic get provider => dynamicAdapterProvider;

  @override
  Widget build(BuildContext context) => const DynamicScreenDashboardScreen();
}
