// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_owner_dashboard_mapper_view_model.dart';
import '../dtos/02_M_franchise_owner_dashboard_mapper_dto.dart';

class FranchiseOwnerDashboardMapperMapper {
  static FranchiseOwnerDashboardMapperViewModel fromDto(FranchiseOwnerDashboardMapperDto dto) {
    return FranchiseOwnerDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseOwnerDashboardMapper',
      metadata: dto.raw,
    );
  }
}

