import '../../domain/models/cfo_dashboard_view_model.dart';
import '../dtos/cfo_dashboard_dto.dart';

class CfoDashboardMapper {
  static CfoDashboardViewModel fromApi(CfoDashboardDto dto) {
    return CfoDashboardViewModel(kpis: dto.rawKpis);
  }

  static CfoDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const CfoDashboardViewModel();
  }
}
