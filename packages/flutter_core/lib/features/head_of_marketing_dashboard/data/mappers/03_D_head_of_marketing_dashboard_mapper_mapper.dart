// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_marketing_dashboard_mapper_view_model.dart';
import '../dtos/02_M_head_of_marketing_dashboard_mapper_dto.dart';

class HeadOfMarketingDashboardMapperMapper {
  static HeadOfMarketingDashboardMapperViewModel fromDto(HeadOfMarketingDashboardMapperDto dto) {
    return HeadOfMarketingDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfMarketingDashboardMapper',
      metadata: dto.raw,
    );
  }
}

