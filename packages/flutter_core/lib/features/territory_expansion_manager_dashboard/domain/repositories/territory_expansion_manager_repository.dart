import '../../../../flutter_core.dart';

abstract class ITerritoryExpansionManagerRepository {
  Future<Result<TerritoryExpansionManagerDashboardViewModel>>
  getTerritoryExpansionManagerData();
}

class TerritoryExpansionManagerRepository
    implements ITerritoryExpansionManagerRepository {
  final DomainService _domainService;

  TerritoryExpansionManagerRepository(this._domainService);

  @override
  Future<Result<TerritoryExpansionManagerDashboardViewModel>>
  getTerritoryExpansionManagerData() async {
    final response = await _domainService.getDomainMetrics(
      'TerritoryExpansionManager',
    );
    return response.map(
      (data) =>
          TerritoryExpansionManagerDashboardViewModel.fromDashboardMetrics(
            DashboardMetrics.fromJson(data.data),
          ),
    );
  }
}
