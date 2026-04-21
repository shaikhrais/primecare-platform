// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

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
      (DomainResponse domainResponse) => CtoDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
