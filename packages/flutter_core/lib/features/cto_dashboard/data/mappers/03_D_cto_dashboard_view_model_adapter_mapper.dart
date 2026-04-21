// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cto_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_cto_dashboard_view_model_adapter_dto.dart';

class CtoDashboardViewModelAdapterMapper {
  static CtoDashboardViewModelAdapterViewModel fromDto(CtoDashboardViewModelAdapterDto dto) {
    return CtoDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ctoDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

