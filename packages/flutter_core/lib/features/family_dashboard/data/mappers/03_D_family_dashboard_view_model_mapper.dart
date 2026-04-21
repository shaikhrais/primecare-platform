// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_family_dashboard_view_model.dart';
import '../dtos/02_M_family_dashboard_view_model_dto.dart';

class FamilyDashboardViewModelMapper {
  static FamilyDashboardViewModel fromDto(FamilyDashboardViewModelDto dto) {
    return FamilyDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'familyDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

