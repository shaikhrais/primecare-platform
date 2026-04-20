import '../../../../flutter_core.dart';

abstract class ICooRepository {
  Future<Result<CooDashboardViewModel>> getCooData();
}

class CooRepository implements ICooRepository {
  final DomainService _domainService;

  CooRepository(this._domainService);

  @override
  Future<Result<CooDashboardViewModel>> getCooData() async {
    final response = await _domainService.getDomainMetrics('Coo');
    return response.map(
      (data) => CooDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
