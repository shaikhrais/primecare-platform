// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_dto_view_model.dart';
import '../dtos/02_M_coo_dashboard_dto_dto.dart';

class CooDashboardDtoMapper {
  static CooDashboardDtoViewModel fromDto(CooDashboardDtoDto dto) {
    return CooDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardDto',
      metadata: dto.raw,
    );
  }
}

