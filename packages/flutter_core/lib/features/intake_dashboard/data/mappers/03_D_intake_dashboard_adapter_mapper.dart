// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_intake_dashboard_adapter_view_model.dart';
import '../dtos/02_M_intake_dashboard_adapter_dto.dart';

class IntakeDashboardAdapterMapper {
  static IntakeDashboardAdapterViewModel fromDto(IntakeDashboardAdapterDto dto) {
    return IntakeDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'intakeDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

