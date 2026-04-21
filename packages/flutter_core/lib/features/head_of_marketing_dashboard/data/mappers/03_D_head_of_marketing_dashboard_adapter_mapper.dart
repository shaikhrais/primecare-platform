// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_marketing_dashboard_adapter_view_model.dart';
import '../dtos/02_M_head_of_marketing_dashboard_adapter_dto.dart';

class HeadOfMarketingDashboardAdapterMapper {
  static HeadOfMarketingDashboardAdapterViewModel fromDto(HeadOfMarketingDashboardAdapterDto dto) {
    return HeadOfMarketingDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfMarketingDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

