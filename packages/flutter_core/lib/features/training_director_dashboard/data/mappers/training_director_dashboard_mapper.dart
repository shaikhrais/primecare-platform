import '../../domain/models/training_director_dashboard_view_model.dart';
import '../dtos/training_director_dashboard_dto.dart';

class TrainingDirectorDashboardMapper {
  static TrainingDirectorDashboardViewModel fromApi(TrainingDirectorDashboardDto dto) {
    return TrainingDirectorDashboardViewModel(kpis: dto.rawKpis);
  }

  static TrainingDirectorDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const TrainingDirectorDashboardViewModel();
  }
}
