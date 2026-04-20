import '../../../../flutter_core.dart';

abstract class IClinicRepository {
  Future<Result<ClinicDashboardViewModel>> getDashboardMetrics();
}

class ClinicRepository implements IClinicRepository {
  ClinicRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<ClinicDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('clinic');
    return result.map((m) => ClinicDashboardViewModel.fromDashboardMetrics(m));
  }
}
