import '../../../../flutter_core.dart';

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
      (data) => LocalMarketingManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
