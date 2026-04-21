// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_bus_dev_dashboard_dto_view_model.dart';
import '../dtos/02_M_head_of_bus_dev_dashboard_dto_dto.dart';

class HeadOfBusDevDashboardDtoMapper {
  static HeadOfBusDevDashboardDtoViewModel fromDto(HeadOfBusDevDashboardDtoDto dto) {
    return HeadOfBusDevDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfBusDevDashboardDto',
      metadata: dto.raw,
    );
  }
}

