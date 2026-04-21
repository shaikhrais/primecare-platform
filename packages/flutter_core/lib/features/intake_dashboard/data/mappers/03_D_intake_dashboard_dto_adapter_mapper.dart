// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_intake_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_intake_dashboard_dto_adapter_dto.dart';

class IntakeDashboardDtoAdapterMapper {
  static IntakeDashboardDtoAdapterViewModel fromDto(IntakeDashboardDtoAdapterDto dto) {
    return IntakeDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'intakeDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

