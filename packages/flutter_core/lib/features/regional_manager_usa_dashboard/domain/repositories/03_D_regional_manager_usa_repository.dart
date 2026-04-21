// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IRegionalManagerUsaRepository {
  Future<Result<RegionalManagerUsaDashboardViewModel>>
  getRegionalManagerUsaData();
}

class RegionalManagerUsaRepository implements IRegionalManagerUsaRepository {
  final DomainService _domainService;

  RegionalManagerUsaRepository(this._domainService);

  @override
  Future<Result<RegionalManagerUsaDashboardViewModel>>
  getRegionalManagerUsaData() async {
    final response = await _domainService.getDomainMetrics(
      'RegionalManagerUsa',
    );
    return response.map(
      (DomainResponse domainResponse) => RegionalManagerUsaDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
