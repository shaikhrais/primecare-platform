// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

abstract class ITrainingCoordinatorRepository {
  Future<Result<TrainingCoordinatorDashboardViewModel>>
  getTrainingCoordinatorData();
}

class TrainingCoordinatorRepository implements ITrainingCoordinatorRepository {
  final DomainService _domainService;

  TrainingCoordinatorRepository(this._domainService);

  @override
  Future<Result<TrainingCoordinatorDashboardViewModel>>
  getTrainingCoordinatorData() async {
    final response = await _domainService.getDomainMetrics(
      'TrainingCoordinator',
    );
    return response.map(
      (DomainResponse domainResponse) => TrainingCoordinatorDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
