// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_marketing_dashboard_dto_view_model.dart';
import '../dtos/02_M_head_of_marketing_dashboard_dto_dto.dart';

class HeadOfMarketingDashboardDtoMapper {
  static HeadOfMarketingDashboardDtoViewModel fromDto(HeadOfMarketingDashboardDtoDto dto) {
    return HeadOfMarketingDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfMarketingDashboardDto',
      metadata: dto.raw,
    );
  }
}

