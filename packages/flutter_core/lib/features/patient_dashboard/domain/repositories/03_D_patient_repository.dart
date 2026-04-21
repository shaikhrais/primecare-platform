// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IPatientRepository {
  Future<Result<PatientDashboardViewModel>> getDashboardMetrics();
}

class PatientRepository implements IPatientRepository {
  PatientRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<PatientDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('patient');
    return result.map((DomainResponse domainResponse) => PatientDashboardViewModel.fromDashboardMetrics(DashboardMetrics.fromJson(domainResponse.data)));
  }
}
