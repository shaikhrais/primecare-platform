import '../../domain/models/coo_dashboard_view_model.dart';
import '../dtos/coo_dashboard_dto.dart';

class CooDashboardMapper {
  static CooDashboardViewModel fromApi(CooDashboardDto dto) {
    return CooDashboardViewModel(kpis: dto.rawKpis);
  }

  static CooDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const CooDashboardViewModel();
  }
}
