// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_head_of_bus_dev_dashboard_adapter_view_model.dart';
import '../dtos/02_M_head_of_bus_dev_dashboard_adapter_dto.dart';

class HeadOfBusDevDashboardAdapterMapper {
  static HeadOfBusDevDashboardAdapterViewModel fromDto(HeadOfBusDevDashboardAdapterDto dto) {
    return HeadOfBusDevDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfBusDevDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

