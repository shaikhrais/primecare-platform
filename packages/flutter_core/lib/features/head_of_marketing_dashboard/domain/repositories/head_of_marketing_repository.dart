import '../../../../flutter_core.dart';

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
      (data) => HeadOfMarketingDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
