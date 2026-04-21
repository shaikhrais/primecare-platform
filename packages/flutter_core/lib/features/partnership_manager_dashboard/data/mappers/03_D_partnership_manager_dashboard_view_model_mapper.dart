// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_partnership_manager_dashboard_view_model.dart';
import '../dtos/02_M_partnership_manager_dashboard_view_model_dto.dart';

class PartnershipManagerDashboardViewModelMapper {
  static PartnershipManagerDashboardViewModel fromDto(PartnershipManagerDashboardViewModelDto dto) {
    return PartnershipManagerDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'partnershipManagerDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

