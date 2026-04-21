// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IFranchiseReconciliationRepository {
  Future<Result<FranchiseReconciliationDashboardViewModel>>
  getFranchiseReconciliationData();
}

class FranchiseReconciliationRepository
    implements IFranchiseReconciliationRepository {
  final DomainService _domainService;

  FranchiseReconciliationRepository(this._domainService);

  @override
  Future<Result<FranchiseReconciliationDashboardViewModel>>
  getFranchiseReconciliationData() async {
    final response = await _domainService.getDomainMetrics(
      'FranchiseReconciliation',
    );
    return response.map(
      (DomainResponse domainResponse) => FranchiseReconciliationDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
