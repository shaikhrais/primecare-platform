import '../../../../flutter_core.dart';

abstract class ISupportRepository {
  Future<Result<SupportDashboardViewModel>> getDashboardMetrics();
}

class SupportRepository implements ISupportRepository {
  SupportRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<SupportDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('support');
    return result.map((m) => SupportDashboardViewModel.fromDashboardMetrics(m));
  }
}
