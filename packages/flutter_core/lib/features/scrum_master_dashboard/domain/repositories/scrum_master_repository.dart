import '../../../../flutter_core.dart';

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
      (data) => ScrumMasterDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
