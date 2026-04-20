import '../../../../flutter_core.dart';

abstract class IPatientRepository {
  Future<Result<PatientDashboardViewModel>> getDashboardMetrics();
}

class PatientRepository implements IPatientRepository {
  PatientRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<PatientDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('patient');
    return result.map((m) => PatientDashboardViewModel.fromDashboardMetrics(m));
  }
}
