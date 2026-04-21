// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cto_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_cto_dashboard_dto_adapter_dto.dart';

class CtoDashboardDtoAdapterMapper {
  static CtoDashboardDtoAdapterViewModel fromDto(CtoDashboardDtoAdapterDto dto) {
    return CtoDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ctoDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

