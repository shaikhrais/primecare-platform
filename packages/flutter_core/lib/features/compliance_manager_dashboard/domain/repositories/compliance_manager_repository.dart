import '../../../../flutter_core.dart';

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
      (data) => ComplianceManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
