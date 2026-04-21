// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IFranchiseRepository {
  Future<Result<FranchiseDashboardViewModel>> getDashboardMetrics();
}

class FranchiseRepository implements IFranchiseRepository {
  FranchiseRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FranchiseDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('franchise');
    return result.map(
      (DomainResponse domainResponse) => FranchiseDashboardViewModel.fromDashboardMetrics(DashboardMetrics.fromJson(domainResponse.data)),
    );
  }
}
