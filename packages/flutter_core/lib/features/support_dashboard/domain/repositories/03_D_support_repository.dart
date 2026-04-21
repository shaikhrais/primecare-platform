// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class ISupportRepository {
  Future<Result<SupportDashboardViewModel>> getDashboardMetrics();
}

class SupportRepository implements ISupportRepository {
  SupportRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<SupportDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('support');
    return result.map(
      (DashboardMetrics metrics) =>
          SupportDashboardViewModel.fromDashboardMetrics(metrics),
    );
  }
}
