// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IFamilyRepository {
  Future<Result<FamilyDashboardViewModel>> getDashboardMetrics();
}

class FamilyRepository implements IFamilyRepository {
  FamilyRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<FamilyDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('family');
    return result.map((DomainResponse domainResponse) => FamilyDashboardViewModel.fromDashboardMetrics(DashboardMetrics.fromJson(domainResponse.data)));
  }
}
