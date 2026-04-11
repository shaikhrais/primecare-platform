import '../../domain/models/local_marketing_manager_dashboard_view_model.dart';
import '../dtos/local_marketing_manager_dashboard_dto.dart';

class LocalMarketingManagerDashboardMapper {
  static LocalMarketingManagerDashboardViewModel fromApi(
    LocalMarketingManagerDashboardDto dto,
  ) {
    return LocalMarketingManagerDashboardViewModel(kpis: dto.rawKpis);
  }

  static LocalMarketingManagerDashboardViewModel fromMock(
    Map<String, dynamic> mock,
  ) {
    return const LocalMarketingManagerDashboardViewModel();
  }
}
