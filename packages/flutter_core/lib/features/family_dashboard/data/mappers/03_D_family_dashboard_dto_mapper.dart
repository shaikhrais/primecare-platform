// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_family_dashboard_dto_view_model.dart';
import '../dtos/02_M_family_dashboard_dto_dto.dart';

class FamilyDashboardDtoMapper {
  static FamilyDashboardDtoViewModel fromDto(FamilyDashboardDtoDto dto) {
    return FamilyDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'familyDashboardDto',
      metadata: dto.raw,
    );
  }
}

