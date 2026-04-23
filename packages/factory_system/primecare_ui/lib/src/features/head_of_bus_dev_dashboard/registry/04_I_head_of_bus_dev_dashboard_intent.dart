// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_head_of_bus_dev_dashboard_screen.dart';

class HeadOfBusDevDashboardIntent extends AppScreenIntent {
  const HeadOfBusDevDashboardIntent();

  @override
  String get name => 'head_of_bus_dev_dashboard';

  @override
  String get route => '/offices/corporate/roles/head_of_bus_dev/dashboard';

  @override
  String get title => 'Head Of Bus Dev Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.headOfBusDev;

  @override
  dynamic get provider => headOfBusDevDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const HeadOfBusDevDashboardScreen();
}

