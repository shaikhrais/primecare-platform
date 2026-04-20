import '../../../../flutter_core.dart';

abstract class IHrHiringRepository {
  Future<Result<HRHiringDashboardViewModel>> getHrHiringData();
}

class HrHiringRepository implements IHrHiringRepository {
  final DomainService _domainService;

  HrHiringRepository(this._domainService);

  @override
  Future<Result<HRHiringDashboardViewModel>> getHrHiringData() async {
    final response = await _domainService.getDomainMetrics('HrHiring');
    return response.map(
      (data) => HRHiringDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
