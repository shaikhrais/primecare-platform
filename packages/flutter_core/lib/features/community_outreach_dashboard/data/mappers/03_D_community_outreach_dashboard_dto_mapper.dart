// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_community_outreach_dashboard_dto_view_model.dart';
import '../dtos/02_M_community_outreach_dashboard_dto_dto.dart';

class CommunityOutreachDashboardDtoMapper {
  static CommunityOutreachDashboardDtoViewModel fromDto(CommunityOutreachDashboardDtoDto dto) {
    return CommunityOutreachDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'communityOutreachDashboardDto',
      metadata: dto.raw,
    );
  }
}

