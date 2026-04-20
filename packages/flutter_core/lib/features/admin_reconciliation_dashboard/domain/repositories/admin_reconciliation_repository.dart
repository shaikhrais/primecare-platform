import '../../../../flutter_core.dart';

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
      (m) => AdminReconciliationDashboardViewModel.fromDashboardMetrics(m),
    );
  }
}
