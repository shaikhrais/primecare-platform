// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_owner_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_franchise_owner_dashboard_dto_adapter_dto.dart';

class FranchiseOwnerDashboardDtoAdapterMapper {
  static FranchiseOwnerDashboardDtoAdapterViewModel fromDto(FranchiseOwnerDashboardDtoAdapterDto dto) {
    return FranchiseOwnerDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseOwnerDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

