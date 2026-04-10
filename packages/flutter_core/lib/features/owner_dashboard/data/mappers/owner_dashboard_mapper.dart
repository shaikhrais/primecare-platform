import '../../domain/models/owner_dashboard_view_model.dart';
import '../dtos/owner_dashboard_dto.dart';

class OwnerDashboardMapper {
  static OwnerDashboardViewModel fromApi(OwnerDashboardDto dto) {
    return OwnerDashboardViewModel(kpis: dto.rawKpis);
  }

  static OwnerDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const OwnerDashboardViewModel();
  }
}
