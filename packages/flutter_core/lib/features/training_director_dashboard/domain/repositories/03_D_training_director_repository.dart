// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

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
      (DomainResponse domainResponse) => TrainingDirectorDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
