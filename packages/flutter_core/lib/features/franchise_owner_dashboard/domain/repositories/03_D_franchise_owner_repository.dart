// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

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
      (DashboardMetrics metrics) =>
          FranchiseOwnerDashboardViewModel.fromDashboardMetrics(metrics),
    );
  }
}
