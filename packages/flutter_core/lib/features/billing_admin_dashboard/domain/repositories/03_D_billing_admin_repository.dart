// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IBillingAdminRepository {
  Future<Result<BillingAdminDashboardViewModel>> getBillingAdminData();
}

class BillingAdminRepository implements IBillingAdminRepository {
  final DomainService _domainService;

  BillingAdminRepository(this._domainService);

  @override
  Future<Result<BillingAdminDashboardViewModel>> getBillingAdminData() async {
    final response = await _domainService.getDomainMetrics('BillingAdmin');
    return response.map(
      (DomainResponse domainResponse) => BillingAdminDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
