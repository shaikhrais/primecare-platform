// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IHeadOfMarketingRepository {
  Future<Result<HeadOfMarketingDashboardViewModel>> getHeadOfMarketingData();
}

class HeadOfMarketingRepository implements IHeadOfMarketingRepository {
  final DomainService _domainService;

  HeadOfMarketingRepository(this._domainService);

  @override
  Future<Result<HeadOfMarketingDashboardViewModel>>
  getHeadOfMarketingData() async {
    final response = await _domainService.getDomainMetrics('HeadOfMarketing');
    return response.map(
      (DomainResponse domainResponse) => HeadOfMarketingDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
