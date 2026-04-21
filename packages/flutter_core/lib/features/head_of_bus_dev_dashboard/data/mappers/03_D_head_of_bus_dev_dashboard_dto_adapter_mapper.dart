// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_bus_dev_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_head_of_bus_dev_dashboard_dto_adapter_dto.dart';

class HeadOfBusDevDashboardDtoAdapterMapper {
  static HeadOfBusDevDashboardDtoAdapterViewModel fromDto(HeadOfBusDevDashboardDtoAdapterDto dto) {
    return HeadOfBusDevDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfBusDevDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

