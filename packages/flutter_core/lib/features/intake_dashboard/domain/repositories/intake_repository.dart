import '../../../../flutter_core.dart';

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
      (data) => IntakeDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
