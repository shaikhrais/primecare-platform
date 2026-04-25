// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_client_dashboard_screen.dart';

class ClientDashboardIntent extends AppScreenIntent {
  ClientDashboardIntent();

  @override
  String get name => 'client_dashboard';

  @override
  String get route => '/portals/client/dashboard';

  @override
  String get title => 'Client Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.client;

  @override
  dynamic get provider => clientDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const ClientDashboardScreen();
}
