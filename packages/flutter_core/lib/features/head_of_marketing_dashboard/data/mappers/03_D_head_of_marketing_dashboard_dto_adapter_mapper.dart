// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_marketing_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_head_of_marketing_dashboard_dto_adapter_dto.dart';

class HeadOfMarketingDashboardDtoAdapterMapper {
  static HeadOfMarketingDashboardDtoAdapterViewModel fromDto(HeadOfMarketingDashboardDtoAdapterDto dto) {
    return HeadOfMarketingDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfMarketingDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

