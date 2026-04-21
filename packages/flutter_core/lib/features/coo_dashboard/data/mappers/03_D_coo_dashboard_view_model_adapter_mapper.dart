// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_coo_dashboard_view_model_adapter_dto.dart';

class CooDashboardViewModelAdapterMapper {
  static CooDashboardViewModelAdapterViewModel fromDto(CooDashboardViewModelAdapterDto dto) {
    return CooDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

