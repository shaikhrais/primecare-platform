// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cfo_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_cfo_dashboard_view_model_adapter_dto.dart';

class CfoDashboardViewModelAdapterMapper {
  static CfoDashboardViewModelAdapterViewModel fromDto(CfoDashboardViewModelAdapterDto dto) {
    return CfoDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

