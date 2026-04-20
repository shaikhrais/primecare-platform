import '../../../../flutter_core.dart';

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
      (data) => BillingAdminDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
