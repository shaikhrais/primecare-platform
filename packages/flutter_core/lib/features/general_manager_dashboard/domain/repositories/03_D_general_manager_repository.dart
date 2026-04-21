// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

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
      (DomainResponse domainResponse) => GeneralManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
