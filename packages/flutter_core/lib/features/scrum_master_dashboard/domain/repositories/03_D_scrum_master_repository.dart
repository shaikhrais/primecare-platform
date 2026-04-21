// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IScrumMasterRepository {
  Future<Result<ScrumMasterDashboardViewModel>> getScrumMasterData();
}

class ScrumMasterRepository implements IScrumMasterRepository {
  final DomainService _domainService;

  ScrumMasterRepository(this._domainService);

  @override
  Future<Result<ScrumMasterDashboardViewModel>> getScrumMasterData() async {
    final response = await _domainService.getDomainMetrics('ScrumMaster');
    return response.map(
      (DomainResponse domainResponse) => ScrumMasterDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
