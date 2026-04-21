// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_dto_adapter_dto.dart';

class RegionalBdmDashboardDtoAdapterMapper {
  static RegionalBdmDashboardDtoAdapterViewModel fromDto(RegionalBdmDashboardDtoAdapterDto dto) {
    return RegionalBdmDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

