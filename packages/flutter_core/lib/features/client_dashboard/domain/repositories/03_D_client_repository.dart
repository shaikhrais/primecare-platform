// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IClientRepository {
  Future<Result<ClientDashboardViewModel>> getDashboardMetrics();
}

class ClientRepository implements IClientRepository {
  ClientRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<ClientDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('client');
    return result.map((DomainResponse domainResponse) => ClientDashboardViewModel.fromDashboardMetrics(DashboardMetrics.fromJson(domainResponse.data)));
  }
}
