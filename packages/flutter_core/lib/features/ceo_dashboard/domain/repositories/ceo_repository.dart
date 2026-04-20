import '../../../../flutter_core.dart';

abstract class ICeoRepository {
  Future<Result<CeoDashboardViewModel>> getCeoData();
}

class CeoRepository implements ICeoRepository {
  final DomainService _domainService;

  CeoRepository(this._domainService);

  @override
  Future<Result<CeoDashboardViewModel>> getCeoData() async {
    final response = await _domainService.getDomainMetrics('Ceo');
    return response.map(
      (data) => CeoDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
