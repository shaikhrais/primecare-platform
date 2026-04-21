// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class ILocalMarketingManagerRepository {
  Future<Result<LocalMarketingManagerDashboardViewModel>>
  getLocalMarketingManagerData();
}

class LocalMarketingManagerRepository
    implements ILocalMarketingManagerRepository {
  final DomainService _domainService;

  LocalMarketingManagerRepository(this._domainService);

  @override
  Future<Result<LocalMarketingManagerDashboardViewModel>>
  getLocalMarketingManagerData() async {
    final response = await _domainService.getDomainMetrics(
      'LocalMarketingManager',
    );
    return response.map(
      (DomainResponse domainResponse) => LocalMarketingManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
