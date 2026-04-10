import '../../domain/models/ceo_dashboard_view_model.dart';
import '../dtos/ceo_dashboard_dto.dart';

class CeoDashboardMapper {
  static CeoDashboardViewModel fromApi(CeoDashboardDto dto) {
    return CeoDashboardViewModel(kpis: dto.rawKpis);
  }

  static CeoDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const CeoDashboardViewModel();
  }
}
