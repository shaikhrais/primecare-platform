// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_billing_admin_dashboard_screen.dart';

class BillingAdminDashboardIntent extends AppScreenIntent {
  BillingAdminDashboardIntent();

  @override
  String get name => 'billing_admin_dashboard';

  @override
  String get route => '/offices/corporate/roles/billing_admin/dashboard';

  @override
  String get title => 'dashboards.billingadmin.title';

  @override
  PlatformRole get requiredRole => PlatformRole.billingAdmin;

  @override
  dynamic get provider => billingAdminMetricsProvider;

  @override
  List<String> get componentLabels => [
    'dashboards.billingadmin.labels.aging_accounts_grid',
    'dashboards.billingadmin.labels.pending_claims_queue',
    'dashboards.billingadmin.labels.remittance_breakdown',
  ];

  @override
  Widget build(BuildContext context) => const BillingAdminDashboardScreen();
}
