// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_head_of_marketing_dashboard_view_model.dart';
import '../dtos/02_M_head_of_marketing_dashboard_view_model_dto.dart';

class HeadOfMarketingDashboardViewModelMapper {
  static HeadOfMarketingDashboardViewModel fromDto(HeadOfMarketingDashboardViewModelDto dto) {
    return HeadOfMarketingDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfMarketingDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

