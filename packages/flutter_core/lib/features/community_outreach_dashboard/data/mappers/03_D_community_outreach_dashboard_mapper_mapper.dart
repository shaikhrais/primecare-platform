// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_community_outreach_dashboard_mapper_view_model.dart';
import '../dtos/02_M_community_outreach_dashboard_mapper_dto.dart';

class CommunityOutreachDashboardMapperMapper {
  static CommunityOutreachDashboardMapperViewModel fromDto(CommunityOutreachDashboardMapperDto dto) {
    return CommunityOutreachDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'communityOutreachDashboardMapper',
      metadata: dto.raw,
    );
  }
}

