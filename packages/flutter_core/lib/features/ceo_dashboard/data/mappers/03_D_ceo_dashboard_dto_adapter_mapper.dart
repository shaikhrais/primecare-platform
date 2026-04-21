// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_ceo_dashboard_dto_adapter_dto.dart';

class CeoDashboardDtoAdapterMapper {
  static CeoDashboardDtoAdapterViewModel fromDto(CeoDashboardDtoAdapterDto dto) {
    return CeoDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

