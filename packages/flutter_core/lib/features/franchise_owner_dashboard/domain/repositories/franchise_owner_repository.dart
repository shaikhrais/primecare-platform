import '../../../../flutter_core.dart';

abstract class IFranchiseOwnerRepository {
  Future<Result<FranchiseOwnerDashboardViewModel>> getDashboardMetrics();
}

class FranchiseOwnerRepository implements IFranchiseOwnerRepository {
  FranchiseOwnerRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FranchiseOwnerDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('franchise_owner');
    return result.map(
      (m) => FranchiseOwnerDashboardViewModel.fromDashboardMetrics(m),
    );
  }
}
