// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_intake_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_intake_dashboard_view_model_adapter_dto.dart';

class IntakeDashboardViewModelAdapterMapper {
  static IntakeDashboardViewModelAdapterViewModel fromDto(IntakeDashboardViewModelAdapterDto dto) {
    return IntakeDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'intakeDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

