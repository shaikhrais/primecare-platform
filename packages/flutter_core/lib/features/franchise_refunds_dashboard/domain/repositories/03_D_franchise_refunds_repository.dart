// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IFranchiseRefundsRepository {
  Future<Result<FranchiseRefundsDashboardViewModel>> getDashboardMetrics();
}

class FranchiseRefundsRepository implements IFranchiseRefundsRepository {
  FranchiseRefundsRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FranchiseRefundsDashboardViewModel>>
  getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('franchise_refunds');
    return result.map(
      (DashboardMetrics metrics) =>
          FranchiseRefundsDashboardViewModel.fromDashboardMetrics(metrics),
    );
  }
}
