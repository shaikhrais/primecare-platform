import '../../../../flutter_core.dart';

abstract class ICfoRepository {
  Future<Result<CfoDashboardViewModel>> getCfoData();
}

class CfoRepository implements ICfoRepository {
  final DomainService _domainService;

  CfoRepository(this._domainService);

  @override
  Future<Result<CfoDashboardViewModel>> getCfoData() async {
    final response = await _domainService.getDomainMetrics('Cfo');
    return response.map(
      (data) => CfoDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
