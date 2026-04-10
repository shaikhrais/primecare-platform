import '../../domain/models/family_dashboard_view_model.dart';
import '../dtos/family_dashboard_dto.dart';

class FamilyDashboardMapper {
  static FamilyDashboardViewModel fromApi(FamilyDashboardDto dto) {
    return FamilyDashboardViewModel(kpis: dto.rawKpis);
  }

  static FamilyDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const FamilyDashboardViewModel();
  }
}
