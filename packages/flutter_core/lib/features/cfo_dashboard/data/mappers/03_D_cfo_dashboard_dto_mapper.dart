// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cfo_dashboard_dto_view_model.dart';
import '../dtos/02_M_cfo_dashboard_dto_dto.dart';

class CfoDashboardDtoMapper {
  static CfoDashboardDtoViewModel fromDto(CfoDashboardDtoDto dto) {
    return CfoDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardDto',
      metadata: dto.raw,
    );
  }
}

