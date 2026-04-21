// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_local_marketing_manager_dashboard_dto_view_model.dart';
import '../dtos/02_M_local_marketing_manager_dashboard_dto_dto.dart';

class LocalMarketingManagerDashboardDtoMapper {
  static LocalMarketingManagerDashboardDtoViewModel fromDto(LocalMarketingManagerDashboardDtoDto dto) {
    return LocalMarketingManagerDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'localMarketingManagerDashboardDto',
      metadata: dto.raw,
    );
  }
}

