import '../../domain/models/community_outreach_dashboard_view_model.dart';
import '../dtos/community_outreach_dashboard_dto.dart';

class CommunityOutreachDashboardMapper {
  static CommunityOutreachDashboardViewModel fromApi(CommunityOutreachDashboardDto dto) {
    return CommunityOutreachDashboardViewModel(kpis: dto.rawKpis);
  }

  static CommunityOutreachDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const CommunityOutreachDashboardViewModel();
  }
}
