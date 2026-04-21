// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_franchise_owner_dashboard_view_model.dart';
import '../dtos/02_M_franchise_owner_dashboard_view_model_dto.dart';

class FranchiseOwnerDashboardViewModelMapper {
  static FranchiseOwnerDashboardViewModel fromDto(FranchiseOwnerDashboardViewModelDto dto) {
    return FranchiseOwnerDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseOwnerDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

