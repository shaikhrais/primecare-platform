// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_view_model_adapter_dto.dart';

class RegionalBdmDashboardViewModelAdapterMapper {
  static RegionalBdmDashboardViewModelAdapterViewModel fromDto(RegionalBdmDashboardViewModelAdapterDto dto) {
    return RegionalBdmDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

