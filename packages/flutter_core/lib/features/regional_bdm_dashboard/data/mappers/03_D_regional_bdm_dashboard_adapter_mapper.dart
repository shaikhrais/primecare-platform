// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_adapter_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_adapter_dto.dart';

class RegionalBdmDashboardAdapterMapper {
  static RegionalBdmDashboardAdapterViewModel fromDto(RegionalBdmDashboardAdapterDto dto) {
    return RegionalBdmDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

