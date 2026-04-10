import '../../domain/models/head_of_marketing_dashboard_view_model.dart';
import '../dtos/head_of_marketing_dashboard_dto.dart';

class HeadOfMarketingDashboardMapper {
  static HeadOfMarketingDashboardViewModel fromApi(HeadOfMarketingDashboardDto dto) {
    return HeadOfMarketingDashboardViewModel(kpis: dto.rawKpis);
  }

  static HeadOfMarketingDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const HeadOfMarketingDashboardViewModel();
  }
}
