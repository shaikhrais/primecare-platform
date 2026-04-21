// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class ITerritorySalesManagerRepository {
  Future<Result<TerritorySalesManagerDashboardViewModel>>
  getTerritorySalesManagerData();
}

class TerritorySalesManagerRepository
    implements ITerritorySalesManagerRepository {
  final DomainService _domainService;

  TerritorySalesManagerRepository(this._domainService);

  @override
  Future<Result<TerritorySalesManagerDashboardViewModel>>
  getTerritorySalesManagerData() async {
    final response = await _domainService.getDomainMetrics(
      'TerritorySalesManager',
    );
    return response.map(
      (DomainResponse domainResponse) => TerritorySalesManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
