// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_dto_view_model.dart';
import '../dtos/02_M_ceo_dashboard_dto_dto.dart';

class CeoDashboardDtoMapper {
  static CeoDashboardDtoViewModel fromDto(CeoDashboardDtoDto dto) {
    return CeoDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardDto',
      metadata: dto.raw,
    );
  }
}

