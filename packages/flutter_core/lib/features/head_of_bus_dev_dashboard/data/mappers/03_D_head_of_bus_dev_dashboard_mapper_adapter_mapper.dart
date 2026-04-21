// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_bus_dev_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_head_of_bus_dev_dashboard_mapper_adapter_dto.dart';

class HeadOfBusDevDashboardMapperAdapterMapper {
  static HeadOfBusDevDashboardMapperAdapterViewModel fromDto(HeadOfBusDevDashboardMapperAdapterDto dto) {
    return HeadOfBusDevDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfBusDevDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

