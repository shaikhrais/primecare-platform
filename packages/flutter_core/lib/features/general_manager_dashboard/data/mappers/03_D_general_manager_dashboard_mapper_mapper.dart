// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_general_manager_dashboard_mapper_view_model.dart';
import '../dtos/02_M_general_manager_dashboard_mapper_dto.dart';

class GeneralManagerDashboardMapperMapper {
  static GeneralManagerDashboardMapperViewModel fromDto(GeneralManagerDashboardMapperDto dto) {
    return GeneralManagerDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'generalManagerDashboardMapper',
      metadata: dto.raw,
    );
  }
}

