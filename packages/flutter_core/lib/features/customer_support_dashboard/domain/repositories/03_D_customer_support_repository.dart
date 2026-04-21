// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class ICustomerSupportRepository {
  Future<Result<CustomerSupportDashboardViewModel>> getCustomerSupportData();
}

class CustomerSupportRepository implements ICustomerSupportRepository {
  final DomainService _domainService;

  CustomerSupportRepository(this._domainService);

  @override
  Future<Result<CustomerSupportDashboardViewModel>>
  getCustomerSupportData() async {
    final response = await _domainService.getDomainMetrics('CustomerSupport');
    return response.map(
      (DomainResponse domainResponse) => CustomerSupportDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
