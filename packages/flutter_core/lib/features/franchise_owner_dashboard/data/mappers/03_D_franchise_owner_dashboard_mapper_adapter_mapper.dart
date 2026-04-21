// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_owner_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_franchise_owner_dashboard_mapper_adapter_dto.dart';

class FranchiseOwnerDashboardMapperAdapterMapper {
  static FranchiseOwnerDashboardMapperAdapterViewModel fromDto(FranchiseOwnerDashboardMapperAdapterDto dto) {
    return FranchiseOwnerDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseOwnerDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

