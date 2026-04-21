// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_owner_dashboard_dto_view_model.dart';
import '../dtos/02_M_franchise_owner_dashboard_dto_dto.dart';

class FranchiseOwnerDashboardDtoMapper {
  static FranchiseOwnerDashboardDtoViewModel fromDto(FranchiseOwnerDashboardDtoDto dto) {
    return FranchiseOwnerDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseOwnerDashboardDto',
      metadata: dto.raw,
    );
  }
}

