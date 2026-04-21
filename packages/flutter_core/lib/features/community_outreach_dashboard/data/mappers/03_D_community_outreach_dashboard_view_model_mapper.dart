// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_community_outreach_dashboard_view_model.dart';
import '../dtos/02_M_community_outreach_dashboard_view_model_dto.dart';

class CommunityOutreachDashboardViewModelMapper {
  static CommunityOutreachDashboardViewModel fromDto(
    CommunityOutreachDashboardViewModelDto dto,
  ) {
    return CommunityOutreachDashboardViewModel(
      title:
          dto.raw['title']?.toString() ?? 'communityOutreachDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
