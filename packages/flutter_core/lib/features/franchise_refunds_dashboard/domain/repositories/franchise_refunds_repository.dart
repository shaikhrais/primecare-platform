import '../../../../flutter_core.dart';

abstract class IFranchiseRefundsRepository {
  Future<Result<FranchiseRefundsDashboardViewModel>> getDashboardMetrics();
}

class FranchiseRefundsRepository implements IFranchiseRefundsRepository {
  FranchiseRefundsRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FranchiseRefundsDashboardViewModel>>
  getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('franchise_refunds');
    return result.map(
      (m) => FranchiseRefundsDashboardViewModel.fromDashboardMetrics(m),
    );
  }
}
