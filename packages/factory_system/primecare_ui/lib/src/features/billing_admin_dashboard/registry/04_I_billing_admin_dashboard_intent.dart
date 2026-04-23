// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_billing_admin_dashboard_screen.dart';

class BillingAdminDashboardIntent extends AppScreenIntent {
  const BillingAdminDashboardIntent();

  @override
  String get name => 'billing_admin_dashboard';

  @override
  String get route => '/offices/corporate/roles/billing_admin/dashboard';

  @override
  String get title => 'Billing Admin Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.billingAdmin;

  @override
  dynamic get provider => billingAdminDashboardAdapterProvider;

  @override
  List<String> get componentLabels => ['Aging Accounts Grid', 'Pending Claims Queue', 'Remittance Breakdown'];

  @override
  Widget build(BuildContext context) => const BillingAdminDashboardScreen();
}

