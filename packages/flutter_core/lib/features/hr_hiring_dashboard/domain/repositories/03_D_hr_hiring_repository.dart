// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IHrHiringRepository {
  Future<Result<HrHiringDashboardViewModel>> getHrHiringData();
}

class HrHiringRepository implements IHrHiringRepository {
  final DomainService _domainService;

  HrHiringRepository(this._domainService);

  @override
  Future<Result<HrHiringDashboardViewModel>> getHrHiringData() async {
    final response = await _domainService.getDomainMetrics('HrHiring');
    return response.map(
      (DomainResponse domainResponse) => HrHiringDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
