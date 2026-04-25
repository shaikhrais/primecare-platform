// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_owner_dashboard_screen.dart';

class OwnerDashboardIntent extends AppScreenIntent {
  OwnerDashboardIntent();

  @override
  String get name => 'owner_dashboard';

  @override
  String get route => '/offices/corporate/roles/owner/dashboard';

  @override
  String get title => 'Owner Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.owner;

  @override
  dynamic get provider => ownerMetricsProvider;

  @override
  Widget build(BuildContext context) => const OwnerDashboardScreen();
}
