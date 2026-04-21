// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IReceptionistRepository {
  Future<Result<ReceptionistDashboardViewModel>> getReceptionistData();
}

class ReceptionistRepository implements IReceptionistRepository {
  final DomainService _domainService;

  ReceptionistRepository(this._domainService);

  @override
  Future<Result<ReceptionistDashboardViewModel>> getReceptionistData() async {
    final response = await _domainService.getDomainMetrics('Receptionist');
    return response.map(
      (DomainResponse domainResponse) => ReceptionistDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
