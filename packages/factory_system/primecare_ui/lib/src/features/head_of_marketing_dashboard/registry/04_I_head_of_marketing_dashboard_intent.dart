// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_head_of_marketing_dashboard_screen.dart';

class HeadOfMarketingDashboardIntent extends AppScreenIntent {
  const HeadOfMarketingDashboardIntent();

  @override
  String get name => 'head_of_marketing_dashboard';

  @override
  String get route => '/offices/corporate/roles/head_of_marketing/dashboard';

  @override
  String get title => 'Head Of Marketing Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.headOfMarketing;

  @override
  dynamic get provider => headOfMarketingDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const HeadOfMarketingDashboardScreen();
}

