// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_demo_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_demo_dashboard_view_model_adapter_dto.dart';

class DemoDashboardViewModelAdapterMapper {
  static DemoDashboardViewModelAdapterViewModel fromDto(DemoDashboardViewModelAdapterDto dto) {
    return DemoDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'demoDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

