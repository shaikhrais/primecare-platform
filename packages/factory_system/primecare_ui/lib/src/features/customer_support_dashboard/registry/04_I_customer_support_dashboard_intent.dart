// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_customer_support_dashboard_screen.dart';

class CustomerSupportDashboardIntent extends AppScreenIntent {
  CustomerSupportDashboardIntent();

  @override
  String get name => 'customer_support_dashboard';

  @override
  String get route => '/offices/corporate/roles/customer_support/dashboard';

  @override
  String get title => 'Customer Support Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.customerSupport;

  @override
  dynamic get provider => customerSupportMetricsProvider;

  @override
  Widget build(BuildContext context) => const CustomerSupportDashboardScreen();
}
