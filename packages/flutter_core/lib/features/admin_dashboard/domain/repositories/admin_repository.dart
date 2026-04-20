import '../../../../flutter_core.dart';

abstract class IAdminRepository {
  Future<Result<AdminDashboardViewModel>> getDashboardMetrics();
}

class AdminRepository implements IAdminRepository {
  AdminRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<AdminDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('admin');
    return result.map((m) => AdminDashboardViewModel.fromDashboardMetrics(m));
  }
}
