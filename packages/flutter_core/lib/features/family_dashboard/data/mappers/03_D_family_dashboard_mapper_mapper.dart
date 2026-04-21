// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_family_dashboard_mapper_view_model.dart';
import '../dtos/02_M_family_dashboard_mapper_dto.dart';

class FamilyDashboardMapperMapper {
  static FamilyDashboardMapperViewModel fromDto(FamilyDashboardMapperDto dto) {
    return FamilyDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'familyDashboardMapper',
      metadata: dto.raw,
    );
  }
}

