// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_general_manager_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_general_manager_dashboard_mapper_adapter_dto.dart';

class GeneralManagerDashboardMapperAdapterMapper {
  static GeneralManagerDashboardMapperAdapterViewModel fromDto(GeneralManagerDashboardMapperAdapterDto dto) {
    return GeneralManagerDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'generalManagerDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

