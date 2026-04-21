// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IClinicRepository {
  Future<Result<ClinicDashboardViewModel>> getDashboardMetrics();
}

class ClinicRepository implements IClinicRepository {
  ClinicRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<ClinicDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('clinic');
    return result.map(
      (metrics) => ClinicDashboardViewModel.fromDashboardMetrics(metrics),
    );
  }
}
