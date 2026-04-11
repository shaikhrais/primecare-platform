import '../../domain/models/partnership_manager_dashboard_view_model.dart';
import '../dtos/partnership_manager_dashboard_dto.dart';

class PartnershipManagerDashboardMapper {
  static PartnershipManagerDashboardViewModel fromApi(
    PartnershipManagerDashboardDto dto,
  ) {
    return PartnershipManagerDashboardViewModel(kpis: dto.rawKpis);
  }

  static PartnershipManagerDashboardViewModel fromMock(
    Map<String, dynamic> mock,
  ) {
    return const PartnershipManagerDashboardViewModel();
  }
}
