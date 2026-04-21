// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_community_outreach_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_community_outreach_dashboard_dto_adapter_dto.dart';

class CommunityOutreachDashboardDtoAdapterMapper {
  static CommunityOutreachDashboardDtoAdapterViewModel fromDto(CommunityOutreachDashboardDtoAdapterDto dto) {
    return CommunityOutreachDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'communityOutreachDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

