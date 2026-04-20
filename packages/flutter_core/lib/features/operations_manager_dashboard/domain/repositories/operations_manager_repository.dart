import '../../../../flutter_core.dart';

abstract class IOperationsManagerRepository {
  Future<Result<OperationsManagerDashboardViewModel>>
  getOperationsManagerData();
}

class OperationsManagerRepository implements IOperationsManagerRepository {
  final DomainService _domainService;

  OperationsManagerRepository(this._domainService);

  @override
  Future<Result<OperationsManagerDashboardViewModel>>
  getOperationsManagerData() async {
    final response = await _domainService.getDomainMetrics('OperationsManager');
    return response.map(
      (data) => OperationsManagerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
