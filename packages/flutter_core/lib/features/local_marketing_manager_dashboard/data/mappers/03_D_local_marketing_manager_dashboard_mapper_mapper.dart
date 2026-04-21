// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_local_marketing_manager_dashboard_mapper_view_model.dart';
import '../dtos/02_M_local_marketing_manager_dashboard_mapper_dto.dart';

class LocalMarketingManagerDashboardMapperMapper {
  static LocalMarketingManagerDashboardMapperViewModel fromDto(LocalMarketingManagerDashboardMapperDto dto) {
    return LocalMarketingManagerDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'localMarketingManagerDashboardMapper',
      metadata: dto.raw,
    );
  }
}

