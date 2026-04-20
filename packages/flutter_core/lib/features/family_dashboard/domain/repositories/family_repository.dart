import '../../../../flutter_core.dart';

abstract class IFamilyRepository {
  Future<Result<FamilyDashboardViewModel>> getDashboardMetrics();
}

class FamilyRepository implements IFamilyRepository {
  FamilyRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FamilyDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('family');
    return result.map((m) => FamilyDashboardViewModel.fromDashboardMetrics(m));
  }
}
