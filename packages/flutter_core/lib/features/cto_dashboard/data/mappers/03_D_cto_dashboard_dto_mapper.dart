// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cto_dashboard_dto_view_model.dart';
import '../dtos/02_M_cto_dashboard_dto_dto.dart';

class CtoDashboardDtoMapper {
  static CtoDashboardDtoViewModel fromDto(CtoDashboardDtoDto dto) {
    return CtoDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'ctoDashboardDto',
      metadata: dto.raw,
    );
  }
}

