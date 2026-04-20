import '../../../../flutter_core.dart';

abstract class IGeneralManagerRepository {
  Future<Result<GeneralManagerDashboardViewModel>> getGeneralManagerData();
}

class GeneralManagerRepository implements IGeneralManagerRepository {
  final DomainService _domainService;

  GeneralManagerRepository(this._domainService);

  @override
  Future<Result<GeneralManagerDashboardViewModel>>
  getGeneralManagerData() async {
    final response = await _domainService.getDomainMetrics('GeneralManager');
    return response.map(
      (data) => GeneralManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
