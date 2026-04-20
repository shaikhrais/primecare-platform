import '../../../../flutter_core.dart';

abstract class IClientRepository {
  Future<Result<ClientDashboardViewModel>> getDashboardMetrics();
}

class ClientRepository implements IClientRepository {
  ClientRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<ClientDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('client');
    return result.map((m) => ClientDashboardViewModel.fromDashboardMetrics(m));
  }
}
