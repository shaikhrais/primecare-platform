import '../../../../flutter_core.dart';

abstract class IQaRepository {
  Future<Result<QaDashboardViewModel>> getQaData();
}

class QaRepository implements IQaRepository {
  final DomainService _domainService;

  QaRepository(this._domainService);

  @override
  Future<Result<QaDashboardViewModel>> getQaData() async {
    final response = await _domainService.getDomainMetrics('Qa');
    return response.map(
      (data) => QaDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
