// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class IIntakeRepository {
  Future<Result<IntakeDashboardViewModel>> getIntakeData();
}

class IntakeRepository implements IIntakeRepository {
  final DomainService _domainService;

  IntakeRepository(this._domainService);

  @override
  Future<Result<IntakeDashboardViewModel>> getIntakeData() async {
    final response = await _domainService.getDomainMetrics('Intake');
    return response.map(
      (DomainResponse domainResponse) => IntakeDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
