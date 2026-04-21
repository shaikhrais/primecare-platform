// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

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
      (DomainResponse domainResponse) => CooDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
