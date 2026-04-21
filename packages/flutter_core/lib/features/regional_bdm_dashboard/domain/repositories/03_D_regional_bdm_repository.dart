// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IRegionalBdmRepository {
  Future<Result<RegionalBdmDashboardViewModel>> getRegionalBdmData();
}

class RegionalBdmRepository implements IRegionalBdmRepository {
  final DomainService _domainService;

  RegionalBdmRepository(this._domainService);

  @override
  Future<Result<RegionalBdmDashboardViewModel>> getRegionalBdmData() async {
    final response = await _domainService.getDomainMetrics('RegionalBdm');
    return response.map(
      (DomainResponse domainResponse) => RegionalBdmDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
