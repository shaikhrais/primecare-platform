// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_bus_dev_dashboard_mapper_view_model.dart';
import '../dtos/02_M_head_of_bus_dev_dashboard_mapper_dto.dart';

class HeadOfBusDevDashboardMapperMapper {
  static HeadOfBusDevDashboardMapperViewModel fromDto(HeadOfBusDevDashboardMapperDto dto) {
    return HeadOfBusDevDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfBusDevDashboardMapper',
      metadata: dto.raw,
    );
  }
}

