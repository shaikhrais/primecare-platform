import '../../../../flutter_core.dart';

abstract class IFranchiseReportsRepository {
  Future<Result<FranchiseReportsDashboardViewModel>> getDashboardMetrics();
}

class FranchiseReportsRepository implements IFranchiseReportsRepository {
  FranchiseReportsRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FranchiseReportsDashboardViewModel>>
  getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('franchise_reports');
    return result.map(
      (m) => FranchiseReportsDashboardViewModel.fromDashboardMetrics(m),
    );
  }
}
