import '../../../../flutter_core.dart';

abstract class IPartnershipManagerRepository {
  Future<Result<PartnershipManagerDashboardViewModel>>
  getPartnershipManagerData();
}

class PartnershipManagerRepository implements IPartnershipManagerRepository {
  final DomainService _domainService;

  PartnershipManagerRepository(this._domainService);

  @override
  Future<Result<PartnershipManagerDashboardViewModel>>
  getPartnershipManagerData() async {
    final response = await _domainService.getDomainMetrics(
      'PartnershipManager',
    );
    return response.map(
      (data) => PartnershipManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
