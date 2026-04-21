// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_owner_dashboard_view_model.dart';
import '../dtos/02_M_owner_dashboard_view_model_dto.dart';

class OwnerDashboardViewModelMapper {
  static OwnerDashboardViewModel fromDto(OwnerDashboardViewModelDto dto) {
    return OwnerDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'ownerDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

