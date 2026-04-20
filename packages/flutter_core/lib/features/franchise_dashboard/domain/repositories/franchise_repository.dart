import '../../../../flutter_core.dart';

abstract class IFranchiseRepository {
  Future<Result<FranchiseDashboardViewModel>> getDashboardMetrics();
}

class FranchiseRepository implements IFranchiseRepository {
  FranchiseRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FranchiseDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('franchise');
    return result.map(
      (m) => FranchiseDashboardViewModel.fromDashboardMetrics(m),
    );
  }
}
