// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IFranchiseReportsRepository {
  Future<Result<FranchiseReportsDashboardViewModel>> getDashboardMetrics();
}

class FranchiseReportsRepository implements IFranchiseReportsRepository {
  FranchiseReportsRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FranchiseReportsDashboardViewModel>>
  getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('franchise_reports');
    return result.map(
      (DashboardMetrics metrics) =>
          FranchiseReportsDashboardViewModel.fromDashboardMetrics(metrics),
    );
  }
}
