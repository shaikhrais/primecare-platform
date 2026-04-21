// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_intake_dashboard_dto_view_model.dart';
import '../dtos/02_M_intake_dashboard_dto_dto.dart';

class IntakeDashboardDtoMapper {
  static IntakeDashboardDtoViewModel fromDto(IntakeDashboardDtoDto dto) {
    return IntakeDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'intakeDashboardDto',
      metadata: dto.raw,
    );
  }
}

