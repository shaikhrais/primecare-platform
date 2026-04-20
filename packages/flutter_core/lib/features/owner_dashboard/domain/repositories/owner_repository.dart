import '../../../../flutter_core.dart';

abstract class IOwnerRepository {
  Future<Result<OwnerDashboardViewModel>> getOwnerDashboard();
}

class OwnerRepository implements IOwnerRepository {
  OwnerRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<OwnerDashboardViewModel>> getOwnerDashboard() async {
    final result = await _dashboardService.getMetrics('owner');
    return result.map((m) => OwnerDashboardViewModel.fromDashboardMetrics(m));
  }
}
