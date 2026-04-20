import '../../../../flutter_core.dart';

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
      (data) => TrainingCoordinatorDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
