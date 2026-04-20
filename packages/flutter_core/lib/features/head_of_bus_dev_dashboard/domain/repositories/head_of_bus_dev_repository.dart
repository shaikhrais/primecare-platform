import '../../../../flutter_core.dart';

abstract class IHeadOfBusDevRepository {
  Future<Result<HeadOfBusDevDashboardViewModel>> getHeadOfBusDevData();
}

class HeadOfBusDevRepository implements IHeadOfBusDevRepository {
  final DomainService _domainService;

  HeadOfBusDevRepository(this._domainService);

  @override
  Future<Result<HeadOfBusDevDashboardViewModel>> getHeadOfBusDevData() async {
    final response = await _domainService.getDomainMetrics('HeadOfBusDev');
    return response.map(
      (data) => HeadOfBusDevDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
