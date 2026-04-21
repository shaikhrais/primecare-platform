// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IFranchiseSalesManagerRepository {
  Future<Result<FranchiseSalesManagerDashboardViewModel>>
  getFranchiseSalesManagerData();
}

class FranchiseSalesManagerRepository
    implements IFranchiseSalesManagerRepository {
  final DomainService _domainService;

  FranchiseSalesManagerRepository(this._domainService);

  @override
  Future<Result<FranchiseSalesManagerDashboardViewModel>>
  getFranchiseSalesManagerData() async {
    final response = await _domainService.getDomainMetrics(
      'FranchiseSalesManager',
    );
    return response.map(
      (DomainResponse domainResponse) => FranchiseSalesManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
