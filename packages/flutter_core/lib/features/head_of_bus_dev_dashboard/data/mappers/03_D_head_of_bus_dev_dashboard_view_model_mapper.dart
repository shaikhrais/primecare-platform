// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_head_of_bus_dev_dashboard_view_model.dart';
import '../dtos/02_M_head_of_bus_dev_dashboard_view_model_dto.dart';

class HeadOfBusDevDashboardViewModelMapper {
  static HeadOfBusDevDashboardViewModel fromDto(HeadOfBusDevDashboardViewModelDto dto) {
    return HeadOfBusDevDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'headOfBusDevDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

