import '../../../../flutter_core.dart';

abstract class ITrainingDirectorRepository {
  Future<Result<TrainingDirectorDashboardViewModel>> getTrainingDirectorData();
}

class TrainingDirectorRepository implements ITrainingDirectorRepository {
  final DomainService _domainService;

  TrainingDirectorRepository(this._domainService);

  @override
  Future<Result<TrainingDirectorDashboardViewModel>>
  getTrainingDirectorData() async {
    final response = await _domainService.getDomainMetrics('TrainingDirector');
    return response.map(
      (data) => TrainingDirectorDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
