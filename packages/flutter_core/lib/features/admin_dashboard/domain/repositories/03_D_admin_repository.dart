// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../00_B_flutter_core.dart';

abstract class IAdminRepository {
  Future<Result<AdminDashboardViewModel>> getDashboardMetrics();
}

class AdminRepository implements IAdminRepository {
  AdminRepository(this._dashboardService);
  final DashboardService _dashboardService;

  @override
  Future<Result<AdminDashboardViewModel>> getDashboardMetrics() async {
    final result = await _dashboardService.getMetrics('admin');
    return result.map((DomainResponse domainResponse) => AdminDashboardViewModel.fromDashboardMetrics(DashboardMetrics.fromJson(domainResponse.data)));
  }
}
