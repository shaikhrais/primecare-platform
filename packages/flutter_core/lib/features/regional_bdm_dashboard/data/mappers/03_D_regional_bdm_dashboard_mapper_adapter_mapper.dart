// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_mapper_adapter_dto.dart';

class RegionalBdmDashboardMapperAdapterMapper {
  static RegionalBdmDashboardMapperAdapterViewModel fromDto(RegionalBdmDashboardMapperAdapterDto dto) {
    return RegionalBdmDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

