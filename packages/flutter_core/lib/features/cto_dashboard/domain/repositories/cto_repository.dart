import '../../../../flutter_core.dart';

abstract class ICtoRepository {
  Future<Result<CtoDashboardViewModel>> getCtoData();
}

class CtoRepository implements ICtoRepository {
  final DomainService _domainService;

  CtoRepository(this._domainService);

  @override
  Future<Result<CtoDashboardViewModel>> getCtoData() async {
    final response = await _domainService.getDomainMetrics('Cto');
    return response.map(
      (data) => CtoDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
