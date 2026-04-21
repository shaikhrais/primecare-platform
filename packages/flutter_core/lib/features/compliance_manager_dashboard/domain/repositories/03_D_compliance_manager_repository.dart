// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IComplianceManagerRepository {
  Future<Result<ComplianceManagerDashboardViewModel>>
  getComplianceManagerData();
}

class ComplianceManagerRepository implements IComplianceManagerRepository {
  final DomainService _domainService;

  ComplianceManagerRepository(this._domainService);

  @override
  Future<Result<ComplianceManagerDashboardViewModel>>
  getComplianceManagerData() async {
    final response = await _domainService.getDomainMetrics('ComplianceManager');
    return response.map(
      (DomainResponse domainResponse) => ComplianceManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
