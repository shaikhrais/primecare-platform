// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_ceo_dashboard_view_model_adapter_dto.dart';

class CeoDashboardViewModelAdapterMapper {
  static CeoDashboardViewModelAdapterViewModel fromDto(CeoDashboardViewModelAdapterDto dto) {
    return CeoDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

