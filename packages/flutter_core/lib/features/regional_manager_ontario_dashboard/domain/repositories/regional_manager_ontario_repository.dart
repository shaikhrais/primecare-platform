import '../../../../flutter_core.dart';

abstract class IRegionalManagerOntarioRepository {
  Future<Result<RegionalManagerOntarioDashboardViewModel>>
  getRegionalManagerOntarioData();
}

class RegionalManagerOntarioRepository
    implements IRegionalManagerOntarioRepository {
  final DomainService _domainService;

  RegionalManagerOntarioRepository(this._domainService);

  @override
  Future<Result<RegionalManagerOntarioDashboardViewModel>>
  getRegionalManagerOntarioData() async {
    final response = await _domainService.getDomainMetrics(
      'RegionalManagerOntario',
    );
    return response.map(
      (data) => RegionalManagerOntarioDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
