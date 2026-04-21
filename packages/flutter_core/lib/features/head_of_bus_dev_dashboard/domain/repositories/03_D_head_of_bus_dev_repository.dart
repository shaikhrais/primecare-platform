// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

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
      (DomainResponse domainResponse) => HeadOfBusDevDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
