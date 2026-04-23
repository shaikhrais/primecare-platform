// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_local_marketing_manager_dashboard_screen.dart';

class LocalMarketingManagerDashboardIntent extends AppScreenIntent {
  const LocalMarketingManagerDashboardIntent();

  @override
  String get name => 'local_marketing_manager_dashboard';

  @override
  String get route => '/offices/corporate/roles/local_marketing_manager/dashboard';

  @override
  String get title => 'Local Marketing Manager Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.localMarketingManager;

  @override
  dynamic get provider => localMarketingManagerDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const LocalMarketingManagerDashboardScreen();
}

