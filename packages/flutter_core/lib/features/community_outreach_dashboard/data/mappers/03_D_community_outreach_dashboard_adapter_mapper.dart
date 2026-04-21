// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_community_outreach_dashboard_adapter_view_model.dart';
import '../dtos/02_M_community_outreach_dashboard_adapter_dto.dart';

class CommunityOutreachDashboardAdapterMapper {
  static CommunityOutreachDashboardAdapterViewModel fromDto(CommunityOutreachDashboardAdapterDto dto) {
    return CommunityOutreachDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'communityOutreachDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

