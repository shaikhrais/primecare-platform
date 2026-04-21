// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IAdminReconciliationRepository {
  Future<Result<AdminReconciliationDashboardViewModel>> getDashboardMetrics();
}

class AdminReconciliationRepository implements IAdminReconciliationRepository {
  AdminReconciliationRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<AdminReconciliationDashboardViewModel>>
  getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('admin_reconciliation');
    return result.map(
      (DomainResponse domainResponse) => AdminReconciliationDashboardViewModel.fromDashboardMetrics(DashboardMetrics.fromJson(domainResponse.data)),
    );
  }
}
