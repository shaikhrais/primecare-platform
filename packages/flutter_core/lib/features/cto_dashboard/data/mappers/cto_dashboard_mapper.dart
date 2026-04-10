import '../../domain/models/cto_dashboard_view_model.dart';
import '../dtos/cto_dashboard_dto.dart';

class CtoDashboardMapper {
  static CtoDashboardViewModel fromApi(CtoDashboardDto dto) {
    return CtoDashboardViewModel(kpis: dto.rawKpis);
  }

  static CtoDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const CtoDashboardViewModel();
  }
}
