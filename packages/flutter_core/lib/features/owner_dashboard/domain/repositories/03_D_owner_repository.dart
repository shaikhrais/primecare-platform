// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IOwnerRepository {
  Future<Result<OwnerDashboardViewModel>> getOwnerDashboard();
}

class OwnerRepository implements IOwnerRepository {
  OwnerRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<OwnerDashboardViewModel>> getOwnerDashboard() async {
    final result = await _dashboardService.getMetrics('owner');
    return result.map(
      (metrics) => OwnerDashboardViewModel.fromDashboardMetrics(metrics),
    );
  }
}
